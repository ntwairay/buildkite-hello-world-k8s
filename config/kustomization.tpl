namespace: application

configMapGenerator:
  - name: ray-configmap
    files:
    - ./envs/base.properties
    - ./envs/$env.properties
    - ./secrets/$env.secrets.properties

generatorOptions:
  disableNameSuffixHash: true
