{ lib
, bluetooth-data-tools
, bluetooth-sensor-state-data
, buildPythonPackage
, fetchFromGitHub
, home-assistant-bluetooth
, poetry-core
, pytestCheckHook
, pythonOlder
, sensor-state-data
}:

buildPythonPackage rec {
  pname = "govee-ble";
  version = "0.21.1";
  format = "pyproject";

  disabled = pythonOlder "3.9";

  src = fetchFromGitHub {
    owner = "Bluetooth-Devices";
    repo = pname;
    rev = "refs/tags/v${version}";
    hash = "sha256-F5BUt+A5IF010PT/OvkINrMyK8tZ+uqml3CqNWpaM0c=";
  };

  nativeBuildInputs = [
    poetry-core
  ];

  propagatedBuildInputs = [
    bluetooth-data-tools
    bluetooth-sensor-state-data
    home-assistant-bluetooth
    sensor-state-data
  ];

  checkInputs = [
    pytestCheckHook
  ];

  postPatch = ''
    substituteInPlace pyproject.toml \
      --replace " --cov=govee_ble --cov-report=term-missing:skip-covered" ""
  '';

  pythonImportsCheck = [
    "govee_ble"
  ];

  meta = with lib; {
    description = "Library for Govee BLE devices";
    homepage = "https://github.com/Bluetooth-Devices/govee-ble";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ fab ];
  };
}
