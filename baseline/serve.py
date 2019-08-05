import mrqa_allennlp
import argparse
from allennlp.models.archival import load_archive
from allennlp.predictors import Predictor
from allennlp.common.file_utils import cached_path
import flask

if __name__ == "__main__":
    parse = argparse.ArgumentParser("")
    parse.add_argument("model")
    parse.add_argument("port", type=int)
    parse.add_argument("--cuda_device", type=int, default=-1)
    args = parse.parse_args()

    file_path = cached_path(args.model)
    archive = load_archive(file_path, cuda_device=args.cuda_device)
    predictor = Predictor.from_archive(archive, 'mrqa_predictor')
    predictor._dataset_reader._is_training = False

    app = flask.Flask(__name__)

    @app.route('/', methods=['POST'])
    def index():
        json_obj = flask.request.get_json()
        pred = predictor.predict_json(json_obj)
        return flask.jsonify(pred)

    app.run(port=args.port)
