GDPC                 �                                                                         P   res://.godot/exported/133200997/export-019748289b573d9d08e308a7ce3a0701-grid.scn�      U      ���	��;I�J��j    P   res://.godot/exported/133200997/export-dfbaa3b728ad779f93c7149c2a9a8326-tile.scn�!      @      �l�}�O"k��,1�    ,   res://.godot/global_script_class_cache.cfg                 ��Р�8���8~$}P�    H   res://.godot/imported/Ground1.png-c15f6d4cb89866863f6ef8622be69a22.ctex P            L���^~�S��b�$�    L   res://.godot/imported/MiniTown3.png-e60941117fb76c5fca5677a8e34b77cd.ctex   `      .      ��.N����51���s�    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex@      \      6(4�d=EQ�ǮVj,       res://.godot/uid_cache.bin   7      �       ^�j���m���NW�p�       res://Ground1.png.importp      �       ́��y.`h�lM��ϥ       res://MiniTown3.png.import  �      �       �5��]��/+��w��       res://camera.gd         �      I~!�ckև��nc,�       res://grid.gd   �      7      (Ig����gw_���       res://grid.tscn.remap   �%      a       f�.(�&]��qJ��x�       res://icon.svg  �&      N      ]��s�9^w/�����       res://icon.svg.import   �      �       �3�l�;~��GY9�       res://project.binary�7      �      �..ҩQ�������'{       res://tile.gd   `       E      ��X�m5��%�H@[�       res://tile.tscn.remap   `&      a       &��  ����EA�$�    S��list=Array[Dictionary]([])
;��'�extends Camera2D

const MAX_ZOOM_LEVEL = 0.25
const MIN_ZOOM_LEVEL = 1.5
const ZOOM_INCREMENT = 0.25

signal moved()
signal zoomed()

var _current_zoom_level = 1
var _drag = false

func _input(event):
	if event.is_action_pressed("cam_pan"):
		_drag = true
	elif event.is_action_released("cam_pan"):
		_drag = false
	elif event.is_action_pressed("cam_zoom_in"):
		_update_zoom(ZOOM_INCREMENT)
	elif event.is_action_pressed("cam_zoom_out"):
		_update_zoom(-ZOOM_INCREMENT)
	elif event is InputEventMouseMotion and _drag:
		position -= event.relative / _current_zoom_level
		emit_signal("moved")

func _update_zoom(incr):
	var old_zoom = _current_zoom_level
	_current_zoom_level += incr
	if _current_zoom_level < MAX_ZOOM_LEVEL:
		_current_zoom_level = MAX_ZOOM_LEVEL
	elif _current_zoom_level > MIN_ZOOM_LEVEL:
		_current_zoom_level = MIN_ZOOM_LEVEL
	if old_zoom == _current_zoom_level:
		return

	# var zoom_center = get_viewport_rect().size / 2
	# var zoom_ratio = old_zoom / _current_zoom_level
	# position = position * zoom_ratio + (zoom_center * (1 - zoom_ratio))

	set_zoom(Vector2(_current_zoom_level, _current_zoom_level))
	emit_signal("zoomed")



�<�i��Z��J��extends Node2D

@export var count: int = 9
@export var tilePrefab: PackedScene
@export var tileWidth: int = 64
@export var tileHeight: int = 32

# Called when the node enters the scene tree for the first time.
func _ready():
	var origin = get_viewport_rect().size / 2
	for i in range(1, count+1):
		var tile = tilePrefab.instantiate()
		var ulam_coords = ulam_spiral(i)
		tile.position = _grid_to_isometric(ulam_coords, origin)
		tile.z_index = tile.position.y
		add_child(tile)

var memo = {}

func ulam_spiral(n: int) -> Vector2i:
	if n == 1:
		return Vector2i(0, 0)

	if n in memo:
		return memo[n]
	
	var coords = ulam_spiral(n-1)
	var result = Vector2i(
		coords.x + int(sin(floor(sqrt(4*n-7))*PI/2)),
		coords.y + int(-cos(floor(sqrt(4*n-7))*PI/2))
	)
	memo[n] = result
	return result

func _grid_to_isometric(coords: Vector2i, origin: Vector2) -> Vector2:
	@warning_ignore("integer_division")
	var iso_x = (coords.x - coords.y) * tileWidth / 2
	@warning_ignore("integer_division")
	var iso_y = (coords.x + coords.y) * tileHeight / 2
	return Vector2(iso_x, iso_y) + origin
e&��-�RSRC                     PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://grid.gd ��������   PackedScene    res://tile.tscn ��[)��K   Script    res://camera.gd ��������      local://PackedScene_fvvw6 X         PackedScene          	         names "         Grid    script    count    tilePrefab    Node2D 	   Camera2D 	   position    	   variants                    �           
     �B  �B               node_count             nodes        ��������       ����                                        ����                         conn_count              conns               node_paths              editable_instances              version             RSRCG9т�1u|�GST2   `   `      ����               ` `        �   RIFF�   WEBPVP8L�   /_� HqT,Hq"#L @�*<3��`׶�F�%���`�]y���aܣҗ�v���?�������������-���~�9ߖKL��M:GT���h����'�W!"����x/l��3߭KO��/)��a���R�\D$=H`��*z�hZ^E_)X�C�IQ�+k	�F`��Մ`1X�RE�#5�����4�4�5Q�;C ���[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://ctmykowxejgpx"
path="res://.godot/imported/Ground1.png-c15f6d4cb89866863f6ef8622be69a22.ctex"
metadata={
"vram_texture": false
}
 �%����T��GST2   �   �      ����               � �        $  RIFF  WEBPVP8L  /������!"2�H�l�m�l�H�Q/H^��޷������d��g�(9�$E�Z��ߓ���'3���ض�U�j��$�՜ʝI۶c��3� [���5v�ɶ�=�Ԯ�m���mG�����j�m�m�_�XV����r*snZ'eS�����]n�w�Z:G9�>B�m�It��R#�^�6��($Ɓm+q�h��6�5��I��'���F�"ɹ{�p����	"+d������M�q��� .^>и��6��a�q��gD�h:L��A�\D�
�\=k�(���_d2W��dV#w�o�	����I]�q5�*$8Ѡ$G9��lH]��c�LX���ZӞ3֌����r�2�2ؽL��d��l��1�.��u�5�!�]2�E��`+�H&�T�D�ި7P��&I�<�ng5�O!��͙������n�
ؚѠ:��W��J�+�����6��ɒ�HD�S�z�����8�&�kF�j7N�;YK�$R�����]�VٶHm���)�rh+���ɮ�d�Q��
����]	SU�9�B��fQm]��~Z�x.�/��2q���R���,snV{�7c,���p�I�kSg�[cNP=��b���74pf��)w<:Ŋ��7j0���{4�R_��K܅1�����<߁����Vs)�j�c8���L�Um% �*m/�*+ �<����S��ɩ��a��?��F�w��"�`���BrV�����4�1�*��F^���IKJg`��MK������!iVem�9�IN3;#cL��n/�i����q+������trʈkJI-����R��H�O�ܕ����2
���1&���v�ֳ+Q4蝁U
���m�c�����v% J!��+��v%�M�Z��ꚺ���0N��Q2�9e�qä�U��ZL��䜁�u_(���I؛j+0Ɩ�Z��}�s*�]���Kܙ����SG��+�3p�Ei�,n&���>lgC���!qյ�(_e����2ic3iڦ�U��j�q�RsUi����)w��Rt�=c,if:2ɛ�1�6I�����^^UVx*e��1�8%��DzR1�R'u]Q�	�rs��]���"���lW���a7]o�����~P���W��lZ�+��>�j^c�+a��4���jDNὗ�-��8'n�?e��hҴ�iA�QH)J�R�D�̰oX?ؿ�i�#�?����g�к�@�e�=C{���&��ށ�+ڕ��|h\��'Ч_G�F��U^u2T��ӁQ%�e|���p ���������k	V����eq3���8 � �K�w|�Ɗ����oz-V���s ����"�H%* �	z��xl�4��u�"�Hk�L��P���i��������0�H!�g�Ɲ&��|bn�������]4�"}�"���9;K���s��"c. 8�6�&��N3R"p�pI}��*G��3@�`��ok}��9?"@<�����sv� ���Ԣ��Q@,�A��P8��2��B��r��X��3�= n$�^ ������<ܽ�r"�1 �^��i��a �(��~dp-V�rB�eB8��]
�p ZA$\3U�~B�O ��;��-|��
{�V��6���o��D��D0\R��k����8��!�I�-���-<��/<JhN��W�1���H�#2:E(*�H���{��>��&!��$| �~�\#��8�> �H??�	E#��VY���t7���> 6�"�&ZJ��p�C_j���	P:�a�G0 �J��$�M���@�Q��[z��i��~q�1?�E�p�������7i���<*�,b�е���Z����N-
��>/.�g�'R�e��K�)"}��K�U�ƹ�>��#�rw߶ȑqF�l�Ο�ͧ�e�3�[䴻o�L~���EN�N�U9�������w��G����B���t��~�����qk-ί�#��Ξ����κ���Z��u����;{�ȴ<������N�~���hA+�r ���/����~o�9>3.3�s������}^^�_�����8���S@s%��]K�\�)��B�w�Uc۽��X�ǧ�;M<*)�ȝ&����~$#%�q����������Q�4ytz�S]�Y9���ޡ$-5���.���S_��?�O/���]�7�;��L��Zb�����8���Guo�[''�،E%���;����#Ɲ&f��_1�߃fw�!E�BX���v��+�p�DjG��j�4�G�Wr����� 3�7��� ������(����"=�NY!<l��	mr�՚���Jk�mpga�;��\)6�*k�'b�;	�V^ݨ�mN�f�S���ն�a���ϡq�[f|#U����^����jO/���9͑Z��������.ɫ�/���������I�D��R�8�5��+��H4�N����J��l�'�כ�������H����%"��Z�� ����`"��̃��L���>ij~Z,qWXo�}{�y�i�G���sz�Q�?�����������lZdF?�]FXm�-r�m����Ф:�З���:}|x���>e������{�0���v��Gş�������u{�^��}hR���f�"����2�:=��)�X\[���Ů=�Qg��Y&�q�6-,P3�{�vI�}��f��}�~��r�r�k�8�{���υ����O�֌ӹ�/�>�}�t	��|���Úq&���ݟW����ᓟwk�9���c̊l��Ui�̸~��f��i���_�j�S-|��w�R�<Lծd�ٞ,9�8��I�Ү�6 *3�ey�[�Ԗ�k��R���<������
g�R���~��a��
��ʾiI9u����*ۏ�ü�<mԤ���T��Amf�B���ĝq��iS��4��yqm-w�j��̝qc�3�j�˝mqm]P��4���8i�d�u�΄ݿ���X���KG.�?l�<�����!��Z�V�\8��ʡ�@����mK�l���p0/$R�����X�	Z��B�]=Vq �R�bk�U�r�[�� ���d�9-�:g I<2�Oy�k���������H�8����Z�<t��A�i��#�ӧ0"�m�:X�1X���GҖ@n�I�겦�CM��@������G"f���A$�t�oyJ{θxOi�-7�F�n"�eS����=ɞ���A��Aq�V��e����↨�����U3�c�*�*44C��V�:4�ĳ%�xr2V�_)^�a]\dZEZ�C 
�*V#��	NP��\�(�4^sh8T�H��P�_��}���۴[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://g3vo74oivwgd"
path="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"
metadata={
"vram_texture": false
}
 GST2   `   `      ����               ` `        �  RIFF�  WEBPVP8L�  /_��&���iH����������l5���~�T1��2��$I�������^ֻ��E�� ��' $���P
��rǢ*�3Ȗr4/m�&�u����%�s������nV{�N�=���� #������C6q�ty�� ��̰<�	&UH�gඑ�L�p����[�Z-1GMg�<K�ՙ\PO;s����mPK�,�n�^P��13﹫x\7D-�Z�M{��z�ގ�h���
˺?��ҕ&����b]�K�a��ҭ���гҺ�N���gX��A�<p��-���.#��^\/ɰV[Z�6	JH�r�t{�lU��Q�9�Ѕ-R�j;�x��P��~Q��.!I|�v�r�&���]b��v���M�~ e��N�"b���//���ژ(f�U���J����D��b�J�
&�����2�IAD0���`����.,`!]%CD��6l�(b�o��@:�&�@ʄ�P�/26-DL:�����8�V!�9�LB�h�ى�����V�#b�]&l�g�"
�|t�8 ���0��qA�5��K��o��)@��ѧl���yD%w��H�a�Z8爘��x��E��D�h��(AqB"��m3���ca�%"9�5�[��4��R�xp�c�~�`/o�p�B��g�����
�<�'bb(��B�e�_�1��!��������0�r9���*1Ӳ����O�&���dj*K��S1UYN�T h�[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://bn8dputna33jt"
path="res://.godot/imported/MiniTown3.png-e60941117fb76c5fca5677a8e34b77cd.ctex"
metadata={
"vram_texture": false
}
 �����=23extends Sprite2D

func on_hover():
	modulate = Color(0.8, 0.8, 0.8)

func on_hover_exit():
	modulate = Color(1, 1, 1)

func on_click(_viewport: Node, event: InputEvent, _shape_idx: int):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		texture = load("res://MiniTown3.png")
�Z�ؕ�iV�RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script    
   Texture2D    res://Ground1.png �
���U   Script    res://tile.gd ��������      local://PackedScene_vsdq3 1         PackedScene          	         names "      	   Sprite2D 	   position    texture    script    metadata/_edit_group_    Area2D    CollisionPolygon2D    polygon 	   on_click    input_event 	   on_hover    mouse_entered    on_hover_exit    mouse_exited    	   variants       
     B  �B                         %         �  �A       B  �A  �A       A      node_count             nodes        ��������        ����                                              ����                     ����                   conn_count             conns               	                           
                                            node_paths              editable_instances              version             RSRC[remap]

path="res://.godot/exported/133200997/export-019748289b573d9d08e308a7ce3a0701-grid.scn"
3�t�
��>	g�jtk\[remap]

path="res://.godot/exported/133200997/export-dfbaa3b728ad779f93c7149c2a9a8326-tile.scn"
�j��HV'�U��p<svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><g transform="translate(32 32)"><path d="m-16-32c-8.86 0-16 7.13-16 15.99v95.98c0 8.86 7.13 15.99 16 15.99h96c8.86 0 16-7.13 16-15.99v-95.98c0-8.85-7.14-15.99-16-15.99z" fill="#363d52"/><path d="m-16-32c-8.86 0-16 7.13-16 15.99v95.98c0 8.86 7.13 15.99 16 15.99h96c8.86 0 16-7.13 16-15.99v-95.98c0-8.85-7.14-15.99-16-15.99zm0 4h96c6.64 0 12 5.35 12 11.99v95.98c0 6.64-5.35 11.99-12 11.99h-96c-6.64 0-12-5.35-12-11.99v-95.98c0-6.64 5.36-11.99 12-11.99z" fill-opacity=".4"/></g><g stroke-width="9.92746" transform="matrix(.10073078 0 0 .10073078 12.425923 2.256365)"><path d="m0 0s-.325 1.994-.515 1.976l-36.182-3.491c-2.879-.278-5.115-2.574-5.317-5.459l-.994-14.247-27.992-1.997-1.904 12.912c-.424 2.872-2.932 5.037-5.835 5.037h-38.188c-2.902 0-5.41-2.165-5.834-5.037l-1.905-12.912-27.992 1.997-.994 14.247c-.202 2.886-2.438 5.182-5.317 5.46l-36.2 3.49c-.187.018-.324-1.978-.511-1.978l-.049-7.83 30.658-4.944 1.004-14.374c.203-2.91 2.551-5.263 5.463-5.472l38.551-2.75c.146-.01.29-.016.434-.016 2.897 0 5.401 2.166 5.825 5.038l1.959 13.286h28.005l1.959-13.286c.423-2.871 2.93-5.037 5.831-5.037.142 0 .284.005.423.015l38.556 2.75c2.911.209 5.26 2.562 5.463 5.472l1.003 14.374 30.645 4.966z" fill="#fff" transform="matrix(4.162611 0 0 -4.162611 919.24059 771.67186)"/><path d="m0 0v-47.514-6.035-5.492c.108-.001.216-.005.323-.015l36.196-3.49c1.896-.183 3.382-1.709 3.514-3.609l1.116-15.978 31.574-2.253 2.175 14.747c.282 1.912 1.922 3.329 3.856 3.329h38.188c1.933 0 3.573-1.417 3.855-3.329l2.175-14.747 31.575 2.253 1.115 15.978c.133 1.9 1.618 3.425 3.514 3.609l36.182 3.49c.107.01.214.014.322.015v4.711l.015.005v54.325c5.09692 6.4164715 9.92323 13.494208 13.621 19.449-5.651 9.62-12.575 18.217-19.976 26.182-6.864-3.455-13.531-7.369-19.828-11.534-3.151 3.132-6.7 5.694-10.186 8.372-3.425 2.751-7.285 4.768-10.946 7.118 1.09 8.117 1.629 16.108 1.846 24.448-9.446 4.754-19.519 7.906-29.708 10.17-4.068-6.837-7.788-14.241-11.028-21.479-3.842.642-7.702.88-11.567.926v.006c-.027 0-.052-.006-.075-.006-.024 0-.049.006-.073.006v-.006c-3.872-.046-7.729-.284-11.572-.926-3.238 7.238-6.956 14.642-11.03 21.479-10.184-2.264-20.258-5.416-29.703-10.17.216-8.34.755-16.331 1.848-24.448-3.668-2.35-7.523-4.367-10.949-7.118-3.481-2.678-7.036-5.24-10.188-8.372-6.297 4.165-12.962 8.079-19.828 11.534-7.401-7.965-14.321-16.562-19.974-26.182 4.4426579-6.973692 9.2079702-13.9828876 13.621-19.449z" fill="#478cbf" transform="matrix(4.162611 0 0 -4.162611 104.69892 525.90697)"/><path d="m0 0-1.121-16.063c-.135-1.936-1.675-3.477-3.611-3.616l-38.555-2.751c-.094-.007-.188-.01-.281-.01-1.916 0-3.569 1.406-3.852 3.33l-2.211 14.994h-31.459l-2.211-14.994c-.297-2.018-2.101-3.469-4.133-3.32l-38.555 2.751c-1.936.139-3.476 1.68-3.611 3.616l-1.121 16.063-32.547 3.138c.015-3.498.06-7.33.06-8.093 0-34.374 43.605-50.896 97.781-51.086h.066.067c54.176.19 97.766 16.712 97.766 51.086 0 .777.047 4.593.063 8.093z" fill="#478cbf" transform="matrix(4.162611 0 0 -4.162611 784.07144 817.24284)"/><path d="m0 0c0-12.052-9.765-21.815-21.813-21.815-12.042 0-21.81 9.763-21.81 21.815 0 12.044 9.768 21.802 21.81 21.802 12.048 0 21.813-9.758 21.813-21.802" fill="#fff" transform="matrix(4.162611 0 0 -4.162611 389.21484 625.67104)"/><path d="m0 0c0-7.994-6.479-14.473-14.479-14.473-7.996 0-14.479 6.479-14.479 14.473s6.483 14.479 14.479 14.479c8 0 14.479-6.485 14.479-14.479" fill="#414042" transform="matrix(4.162611 0 0 -4.162611 367.36686 631.05679)"/><path d="m0 0c-3.878 0-7.021 2.858-7.021 6.381v20.081c0 3.52 3.143 6.381 7.021 6.381s7.028-2.861 7.028-6.381v-20.081c0-3.523-3.15-6.381-7.028-6.381" fill="#fff" transform="matrix(4.162611 0 0 -4.162611 511.99336 724.73954)"/><path d="m0 0c0-12.052 9.765-21.815 21.815-21.815 12.041 0 21.808 9.763 21.808 21.815 0 12.044-9.767 21.802-21.808 21.802-12.05 0-21.815-9.758-21.815-21.802" fill="#fff" transform="matrix(4.162611 0 0 -4.162611 634.78706 625.67104)"/><path d="m0 0c0-7.994 6.477-14.473 14.471-14.473 8.002 0 14.479 6.479 14.479 14.473s-6.477 14.479-14.479 14.479c-7.994 0-14.471-6.485-14.471-14.479" fill="#414042" transform="matrix(4.162611 0 0 -4.162611 656.64056 631.05679)"/></g></svg>
G   �/ĭ!$   res://grid.tscn�
���U   res://Ground1.png�1�Sd%�   res://icon.svg�u�ǻ�.   res://MiniTown3.png��[)��K   res://tile.tscnECFG      application/config/name      
   tradeworld     application/run/main_scene         res://grid.tscn    application/config/features(   "         4.0    GL Compatibility        application/boot_splash/bg_color      s� >r�>��0>  �?   application/config/icon         res://icon.svg  "   display/window/size/viewport_width      �   #   display/window/size/viewport_height      �   )   display/window/size/window_width_override      @  *   display/window/size/window_height_override      @     display/window/stretch/mode         canvas_items   dotnet/project/assembly_name      
   tradeworld     input/cam_zoom_in`              deadzone      ?      events              InputEventMouseButton         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          button_mask           position              global_position               factor       �?   button_index         pressed           double_click          script            InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   =   	   key_label             unicode    =      echo          script         input/cam_zoom_out`              deadzone      ?      events              InputEventMouseButton         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          button_mask           position              global_position               factor       �?   button_index         pressed           double_click          script            InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   -   	   key_label             unicode    -      echo          script         input/cam_pan�              deadzone      ?      events              InputEventMouseButton         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          button_mask           position              global_position               factor       �?   button_index         pressed           double_click          script      9   rendering/textures/canvas_textures/default_texture_filter          #   rendering/renderer/rendering_method         gl_compatibility*   rendering/renderer/rendering_method.mobile         gl_compatibility4   rendering/limits/global_shader_variables/buffer_size       @  2   rendering/environment/defaults/default_clear_color      s� >r�>��0>  �?F�