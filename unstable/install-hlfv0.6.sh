(cat > composer.sh; chmod +x composer.sh; exec bash composer.sh)
#!/bin/bash
set -ev

# Get the current directory.
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Get the full path to this script.
SOURCE="${DIR}/composer.sh"

# Create a work directory for extracting files into.
WORKDIR="$(pwd)/composer-data"
rm -rf "${WORKDIR}" && mkdir -p "${WORKDIR}"
cd "${WORKDIR}"

# Find the PAYLOAD: marker in this script.
PAYLOAD_LINE=$(grep -a -n '^PAYLOAD:$' "${SOURCE}" | cut -d ':' -f 1)
echo PAYLOAD_LINE=${PAYLOAD_LINE}

# Find and extract the payload in this script.
PAYLOAD_START=$((PAYLOAD_LINE + 1))
echo PAYLOAD_START=${PAYLOAD_START}
tail -n +${PAYLOAD_START} "${SOURCE}" | tar -xzf -

# Pull the latest Docker images from Docker Hub.
docker-compose pull
docker pull hyperledger/fabric-baseimage:x86_64-0.1.0
docker tag hyperledger/fabric-baseimage:x86_64-0.1.0 hyperledger/fabric-baseimage:latest

# Kill and remove any running Docker containers.
docker-compose -p composer kill
docker-compose -p composer down --remove-orphans

# Kill any other Docker containers.
docker ps -aq | xargs docker rm -f

# Start all Docker containers.
docker-compose -p composer up -d

# Wait for the Docker containers to start and initialize.
sleep 10

# Open the playground in a web browser.
if [ "$(uname)" = "Darwin" ]
then
  open http://localhost:8080
fi

# Exit; this is required as the payload immediately follows.
exit 0
PAYLOAD:
� �rY �[o�0�yx��P�21�BJр�$��	�����\Z6���N$$��Tm��D.����sll��"R�|7�C�عN�݁�v���b�
f�I�`E�Dx;�C����f���HF&�3��y�k���������E�H�-� ��]QI,� v�5��f � {���`�����u{�n�a���A	F����'Q�2 uP�����.�Ԇ��s�Eer�h���/��e���i�f���Q*�m뚞-g���$��� D�-d��Z�&2���5����I�&�f�}US�3Eі��@St�77ԁb(}�փp1��������~�AHL"���t;7Bz����h:\���2�������A�&��1�<Z*�3`7SqV�3z����g#t�?�F�}��$�:�uE(���ŝ�諦���}��ڷ8X����6��n�ta�u�B� \}�ˀ���C&z��wbef++�|���s����_�z���5�c�.m�kxev��-0���Ŗ4p_��T�V��NoGC|�; �qx�j�����73�?`�U9�����C��LQ�Qsy��Qh�O0��11�6�ۋ�"*��\tn�na:z�T#l|�,4��iV���I�Y��@��sm̦[���;����^�a�;��Z��8��U�^*K[���/&���X�� �^�oQN��<gޞ/su�$�M7m����Gi7��}����^����*���p8���p8���p8���p8����V~ (  