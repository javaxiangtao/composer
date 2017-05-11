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
docker pull hyperledger/fabric-ccenv:x86_64-1.0.0-alpha

# Kill and remove any running Docker containers.
docker-compose -p composer kill
docker-compose -p composer down --remove-orphans

# Kill any other Docker containers.
docker ps -aq | xargs docker rm -f

# Start all Docker containers.
docker-compose -p composer up -d

# Wait for the Docker containers to start and initialize.
sleep 10

# Create the channel on peer0.
docker exec peer0 peer channel create -o orderer0:7050 -c mychannel -f /etc/hyperledger/configtx/mychannel.tx

# Join peer0 to the channel.
docker exec peer0 peer channel join -b mychannel.block

# Fetch the channel block on peer1.
docker exec peer1 peer channel fetch -o orderer0:7050 -c mychannel

# Join peer1 to the channel.
docker exec peer1 peer channel join -b mychannel.block

# Open the playground in a web browser.
if [ "$(uname)" = "Darwin" ]
then
  open http://localhost:8080
fi

# Exit; this is required as the payload immediately follows.
exit 0
PAYLOAD:
� �rY �]Y��ʶ���
��o��q�IQAAD�ƍ
fgT�_@��k���b�����B3�$ɕkJW.��o�+7Z���K��i���4�<���/G���Q#пj���1���Nj��6����/�{��_
��c�O�Ih��G{3�V駬���O�Qѿ�E���W����"�T�/�����r��$AU�/���m/�b�]�ӟ@+�/�D��H7Q⿱.�?Y4��_��k�;�*�LW�/�GA`*7��h�䚋{��Z@P��s�����<���(ڼ���)>��s�u1w��<��)��Q��Q�b��q�e����Q��HsmǣHE��oүZ{^G�?�?E�(�q},���s�_5��	����UNl�jM�>��t��Xk�֩R�.4Q�e$ڧ���$X`�+X�\v�&�m�0R�?�D�_7�
�B ��@���c��6�'pG���&zHPt�C��I�@O�<a��t�����24H���֮ޗG�.��P��-Q�j�u��w�4XQ^z�z�S����r�r�d�cx��GaT��W
>��wW����_>���%p��'�J����uC�d>���_������� �9ʚ���x��v̐�Ys%�ZD� m.ד����4̸P���5K05�!f-sp%�@"�)m�R{8޹K2�q�pک��+� ���8>@֐��#u�E]���Ev����Q܋�q�jr@1�&��Z=w���A�!⊠dJq=Z�bF#���2����2K;
��G0Qx�T���й������i,����Cq/���\����M������8Zs?*���a�b&d�y�l������[+���
�4��Ym�P<�P��&W� �����$�6o���b�IdB؍�i�v�k���RuN�Um
h����\2T�p7ByWZi�����՝)�Ե����y
 ����L��L��3�;�A��ϼ \���-5<��XR�����u���(��E�$����7�k&@f+��(�t isy�1����V�9)y��@����u��H�b|[$����1���ќ׏�Czķ��ogrȭ&IKj��������4��Er$Ǣ͙E/���L�}X|`6<[��4g��_���4|�������V��|��?�����S���]��2��g��w�w�_j�a�l���zov��yƇ�܎��q���P��i�K*�3��~�
|Hʐ�zGE󫂩�d�e��e�ޗ)��珠u��e��i(��A�ل��,��>/ك�\L��$p�k�jXC"�W���TcSww��yX�a����"�31��������( ͽ���K���2��]�թ� ��TuhM�����)�zKӔ�FN���U {��y����:�q������xH�8�t�=܇�.���|K3ymJ
�(�Hs=]4���Lrآ��F>�>��6s4!��7�8��D���͛X�����P���o�m��D����0��Z<��h�Y�!���&��x}��$�]���C���d�Q
>���9�}��G����J�=*����+��ϵ~A��;&�r��{�t����/��+�*��T�?U�ϯ�?�St��(Fxe���	p�d��CД�4�2��:F����A.�q�#�*��B����Y�E���W.����=qpw4)he�Hc=A]���\���х��V��/��ldcvm+��qC�����l�Zʰo��q��%ǜ�L7�d7���csc��V�p{�nX@�b$�oW�=�������+����R�Y�������e���������j��C��+�*�_
>����?%����J�������7s(|)t�0�7۸ ��¿]�f�����bX��ǰ��gb64�������܏	T8.Sy �Ȥ��O꽩4��s�m��{�;�;Ԓt��$��P�3��m��7�y�ֻ�`�hJEx�3�J��;Y�#��ݓZטBm����lPD$�{�����Y�i�fQ%�S�q�3 ��l(bK Ӑ���3'���|��k�2	]X�7h�y��磅iϞ,�P���I`*�e��w{�χf}yX@�I�F�M���^��Ҳ��h�����j"8���cq)e#���K�HȜ'pr�5CZ�?^�?�/������+�_>��_�S��RP����_���=�n���Nv��G���������_������T��RP��J�W������C�J=�4/A���2p����t���GC�'��]����p������8�(���H��>��,IRv�����_��Օ�W.��S��+���ZU,o86'��t�lk�=GZw�-���=yA
/����w�,��i%���䎖�Id���z����hcw�a�Ni����8"��	�y\������=n2�L?�SJF���*���x��Q��ɧ�����Gi���/����f����U��.����eB�r��]�)�(�޾|Y8\NǱ��e�3���qЋ鏣(]��-����������O��gs>��#s�&]ƦX
u1
�\�e1���F�u� p�`���m�a}��(*e����)�?U�?_�����Ab�h+�S�A��ƒ%`�}��#��A���m^��YhW���9��u��TO�È�|٘	G��/S����Z������p�i�a��S���}mc�`f���χ����q��U���w��P�xj�QE�����z|�?��4Z�B�(��o�(A>��&r������[�_�"�������]+��X��a�����g��п�����q�<���21����ܥ�p���K��<��Qh�.�G�@C��~8���ā�ɧ9{����<��ж�1��Cb�ڷ�me1l#ע�IZ_����15��D�Xo�Ql��:G����h�(�74cLw�(c=�H�p[�G�d#�|FzxH��9|�tH,̸���@8ǻ5u����K�&���t�*�)�sj�N%��ǆD��0����@ u�3"�]o˥Y��·A�Ě@�D0�ljN�����|�@�����:[i�f��JyJX;;���C� �y��L:AO�$������������E�/��4����>S��t��?�W�)�-���٫��_��?��܀�e��M����O%����}�?���?�m�a��o��^2;M�p�g�?��~���P�'������7��������9�#n�C�j
�����m��W�A@B��nr��	)"i�J�h��F�Kw���[��S�m�ߚ���&4�T:c��ij]�2�
��H���}5n��z���� ��>t�����dͲAs��R����y��t���V���R��S2���k�g�`�r���[�߃N�Ѱ	#$�D��������L��R:����&���R�[�������OI�
��6��=(����/~���������_��W�����s���aX�����r�_n�]��1*�*�_*�_��J������������?�ￕ���?�6McJ��P$K��3E">�3ഋ#���>ྏP��9��U��
e����g�_H���)��J˔l9>Z�Ԍ`��"4����V�Xd�l�-Z����?�`9�������7�{�����0�C���+7���C�;WpD��޷t����MN0���Je�iͪ�?��s?��G�}X.>���?�s;�$���U��R��4���jcCP�'���ߠZ͵��R�M�v��M��,|/��1��d�^���=C�P�z�\#W�"�ا����4�VK�9wR�]�$��2Ã�fW���ƅ��U1?9}0��M�����I|+���T�/ܥ����I�ʭ����ZA�M�*/�.v+��¯�y�'��~lt�;��������y�+�v:`���7���]y�)�E���0G��%Yݾ��)n�{���+?�Y��|U���]gP���V�]9O�վ��n�]���� �~�UQ����7D�.��ߑ�ӿ[׾�WD����}��$w~�����Û,��0��}�kg��ٗ��AG��d�{����͛�Y>�e�l/v`t�7��p1V{����E�[M�+��w�,�����w�!�����~��;~{�7��5x����we�s��<�آ叟�@.j�=l����fQ2���o�|��Q���(�78M\8�n&[�:Y?a�GT��j�H�\"� D~&�b�9k�-�G�>�;��|�"�۞�����T��l(�\$��.��M �|Wođ�ѐ�;0����*���d�?.6��g�^WV����t���I�n�����v�-���!��>��u�����{\�w����g�|~�S�GR"D����ƺN�q�\.����P�\p3\�=^��{�P��[���ۺ�Mɵ���m����&�_���M�F����'%�A�~Q>(��1���v[�v���s8\��䞮�?}^������=�3�B�Y"� c���.������d&K]J�#�0�[۲zL@u�$uD��L��p:�ǭ��7�r`��ѱ��b 6t/��5 h��s�3�ۄ�	�|��yGU�$����C��m��hNԍ��+��Ah�ef�tð��^��ŷ�q��)b�%#�ۊ�릮�ڽc�4 g�����z��~����3��dG:��B��LS�n9��A�T�lGj�C���9�����8sq\��CS1��ȬJ�?P��-��oֈ�9|r��xiȘeTx�oU�K��n5���h�,GS䃍��0�}��� mN�����L6��pz48���)�� ��w��#?��i>���:�:��g1�2���"�A�;�ʢ�sa�����1�I�Vc�2Ǻ���/dzI:�4�q���9���!���p�m���)U6ޅ5�}3��(��:wE�ft�~~W�{%*�Ʃ5�(���>.ifqt��h>_[߹��_֑*�Jc	2CJW�&o=�^��]�E.�k�-��"Ƀ[kgkfP�kN����~FhNf�~�_�Ԟk{�z&_G��j���cER�W<�<��s�����v�?I����ǜ�n ��!3�%8��t
�zaA3�6'f��a��;^k����$̕be仺j/Ɇ.�E�:|����Y^���,�:�'�����ㇳO3~hToHt./���1Y�po��n����7j��3��5�������	���ډ�Sk�����_���R�l#U���qU��l�E�������nl���h��z�}ժK0_�p~��p(�g���4�w������8�������~S��_���?�B�g(�[���3'�f�~�^��ݸ8��?:�2�9}��Ĺ���?y �1��ڧǛ�������Oq�z=��F�<����zt=֣��^�k�f����4?��=,����f6~��LW�X@t�@�l��fކݱD�-v�8J�3����yk;=d�B�ij�,�r̗���*���0M��<�e��zp���fn1/$>g�fN6t��$�g���9
SJt��0Q��i:KG;��zL���Dx�,�g��fQe��A_�46SE�E&�R�S�g�=J�7JyQ��a9Um	1!����`!�m�TU�X6�^/��8���K!
�ri?r��)�	k3am&�*LX��v;d ,�/�6�����]��[j�p��=5WB֭j��	��E�5%q�A@y��+�d��v�l��z\��Z���M�	��<�
m��h�H()f�d���	�8��̰ä�t93-8�v$�b-���u����X����&L�~`���X%�ZVj�X+��ҟ�E�,VӼx-�%�(i��i�yϰ�U��D�No'�B.H����!�c"�n���+K���e��3ʲ��l�R ˥�o�S)~w���i&?�|�G�E?õ��|�C�Y�կ��a��j�M*X�S����|*WVU�ܦ�,8#�y�(Q:\HUEӴ��㙖��S�=�3�K�%�z��GӾ!Ih]>F�
��i�:������MZ�SY�j1�݉*h?��U*���\�)�{�j��%�>WU\xo�%�HY�������WP�(����[.�����!A�M�I�3Ԛ����J��[xa�a5�+Ѣ���k'��r��7��FbRM 9�>����dM�"�Ue$�&�Jg���)��٥�6a�Ї�-V��i��
0�d�^�_k,!�ل��!��- ��lHꎏH���ʵ	)��ꞡ�&E�A	�'Y�4����i�l��f�l��l�p#ڧ9QpMA��yU�>�[�ڀ֠S��kWl����~��2y��� 9t�ۧ�Cg��_9]T�g+�*j�.p]�ms�_�;m�F�p���jj�������研,ոtt#��8^i�4:�q'���Ҽ�Vk�'Z�*�zB?÷���(<��'5Y�-'�֬M�6䡛��k`�ᇟC�>���j��ꜳЙ�� 0��~� n�<+�*f͡[��u�k��1u?��,��i��S\v���4�(z_�
|�<�2dV�0?�<���-N�U��9�� ���0�����1����!��8�������m}�~�K��R��K��ݣ���t�$�z���
A"�o��[����±/<h�#!Җ:����A�\t0���<�)�U,�Ypp�h��.88�0=��jMD�'�z�3��ᦇ��3�6�F�HzUQ�+�(G�[Z���8!��{��
���-"G��R���m�N'5����
�{LU������R�S`�����!<��1>~�!i��{��p�X8��I�A�����Lt��U]�Vb��L-G2�X��H_���w�	E�@%�W�ޖ��2Ά=Hvq�l�������?Іh'���^L�Du��5����m0M����pVn`��Tӊ�t���5�m�q��q������nӝ�[���ӆ?4vL�sL|�s �gwt�.x�T���V�]�w�a�����o�?9F��y�����xXv$�I[u�LG�F)\I"��rI&ZǼ� �S ��78�;X̠�`)*�q��g�"��8jPdR+0
�LWkʲ���al���`6¨M%��)e'.�Ƞ4F�)�)�S[� w�
Sb>ZvQ� �e�K�F�=\����`��E�t)%!TLG�����p�`�n,�(t��0�v�&Djl�ɷ�����!QW��m#(����K;� �{Ų�vG��W�R��'y9X(#.8�$����aFD�ʖ\�o��Ú�ؒp8��&K�Z�^�E��nw��%R�wi�=,�8l��3�Cy?�و�JN���N�L�B_+��V�m\��a��f��&�ZB��v�vG5��k���S���&^������k7��gȼ��y�>�).	���	A�8���n���+���sqT�J��8	�����܋�bv���o��j�pǧ��o������K/���?]k�]�{�^���4�NT?�2��޽��<6��$��p<��~� �}��?���O?��o�����j��Oϟ��O��w��n]�����_�\��m^M'�U�����_�ɏ=���亂?���k�����7>�$�:^��?RП���/8�7g�����N��iS;m��M����W���W\; m�mj�M������f�l�j�����z���Uh�~p�0B�\���5�E��I�c �[������>�~�������kSԄ!�g`�u6����jJ�y�q�������<k�r�,�뵩i6�<-{Όm������i���8l�sf�0��S`.�̜��;DhmU��K=F2�q�K�ZW����Nv���޷�q3�L  