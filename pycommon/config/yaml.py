from yaml import load, dump

class YAMLConfigHolder():

    def __init__(self, file_name: str):
        self._file_name = file_name
        self._config = None

    def load(self):
        with open(self._file_name, 'r') as f:
            self._config = load(f)

    def store(self):
        with open(self._file_name, 'w') as f:
            dump(self._config, f)
