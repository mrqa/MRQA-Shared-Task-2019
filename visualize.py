"""Read in dataset and print examples to console with highlighting.
Usage:
    python visualize.py dataset_file.jsonl.gz
"""
from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

import argparse
import json
import gzip
from termcolor import colored
from allennlp.common.file_utils import cached_path

parser = argparse.ArgumentParser()
parser.add_argument('input', type=str)
parser.add_argument('--qid', type=str, default=None)
args = parser.parse_args()


with gzip.open(cached_path(args.input), 'rb') as f:
    for i, line in enumerate(f):
        obj = json.loads(line)

        # Skip headers.
        if i == 0 and 'header' in obj:
            continue

        # Iterate questions:
        for qa in obj['qas']:
            if args.qid and qa['qid'] != args.qid:
                continue

            # Collect all of the answers and their character offsets.
            answers = []
            offsets = []
            context = obj['context']
            for answer in qa['detected_answers']:
                answers.append(answer['text'])
                for start, end in answer['char_spans']:
                    offsets.append((start, end + 1))

            # Build the context with highlighting.
            segments = []
            pointer = 0

            # Iterate over answer offsets.
            for start, end in sorted(offsets):
                # Span is overlapping with the previous span.
                # Force advance it to current position.
                if start < pointer:
                    start = pointer

                # The span doesn't start where we left off. There is some gap.
                # For each token in the gap, check if it is a question word.
                # Append all of these to the segments list.
                if start > pointer:
                    segments.append(context[pointer:start])
                
                # Now arrive at the answer span, highlight, and append to segments list.
                span = colored(context[start:end], 'red', attrs=['bold', 'dark', 'underline'])
                segments.append(span)

                # Advance pointer to end of this answer span.
                pointer = end

            # Get the remainder.
            segments.append(context[pointer:])

            # Print to console.
            print('=' * 50)
            print('Example %s' % qa['qid'])
            print('=' * 50)
            print('')
            print('Question: %s\n' % qa['question'])
            print('Answers: %s\n' % ' | '.join(answers))
            context = ''.join(segments)
            context = context.replace('[PAR]', '\n\n')
            context = context.replace('[DOC]', '\n\n')
            print('Context: %s\n' % context)
            input()
            print('')
