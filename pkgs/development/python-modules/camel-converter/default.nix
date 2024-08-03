{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  poetry-core,
  pydantic,
  pytestCheckHook,
  pythonOlder,
}:

buildPythonPackage rec {
  pname = "camel-converter";
  version = "3.1.2";
  pyproject = true;

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "sanders41";
    repo = "camel-converter";
    rev = "refs/tags/v${version}";
    hash = "sha256-CJbflRI3wfUmPoVuLwZDYcobESmySvnS99PdpSDhDLk=";
  };

  postPatch = ''
    substituteInPlace pyproject.toml \
      --replace-fail "--cov=camel_converter --cov-report term-missing --no-cov-on-fail" ""
  '';

  build-system = [ poetry-core ];

  passthru.optional-dependencies = {
    pydantic = [ pydantic ];
  };

  nativeCheckInputs = [ pytestCheckHook ] ++ passthru.optional-dependencies.pydantic;

  pythonImportsCheck = [ "camel_converter" ];

  disabledTests = [
    # AttributeError: 'Test' object has no attribute 'model_dump'
    "test_camel_config"
  ];

  meta = with lib; {
    description = "Client for the Meilisearch API";
    homepage = "https://github.com/sanders41/camel-converter";
    changelog = "https://github.com/sanders41/camel-converter/releases/tag/v${version}";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ fab ];
  };
}
