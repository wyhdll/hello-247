###############################################################################
# Dcmģ���makefile�ļ�
# Author��zhailg117736
# date��2011-7-8
###############################################################################

###############################################################################
# ָ����Ҫ����ı�ģ��ʵ���ļ���C����CPP�ļ����������ļ���Ŀ���ļ�
###############################################################################

# ָ����Ҫ�����CPP�ļ���������ӱ�ģ����������Ŀ¼�µ��ļ�
_RNLC_Mesh_All_C += $(wildcard $(_RNLC_MESH_SOURCE_PATH_LTE)/rrd/*.c)
_RNLC_Mesh_All_C += $(wildcard $(_RNLC_MESH_SOURCE_PATH_LTE)/main/source/*.c)
_RNLC_Mesh_All_C += $(wildcard $(_RNLC_MESH_SOURCE_PATH_LTE)/olsrd/comm/source/*.c)
_RNLC_Mesh_All_C += $(wildcard $(_RNLC_MESH_SOURCE_PATH_LTE)/olsrd/olsr/source/*.c)
_RNLC_Mesh_All_C += $(wildcard $(_RNLC_MESH_SOURCE_PATH_LTE)/olsrd/lq/source/*.c)
_RNLC_Mesh_All_C += $(wildcard $(_RNLC_MESH_SOURCE_PATH_LTE)/olsrd/extern/source/*.c)


# ָ����Ҫ����������ļ�����Ӧ������Ҫ�����C�ļ�����CPP�ļ�
_RNLC_Mesh_All_Depend += $(addprefix $(_RNLC_MESH_DEPEND_PATH_LTE)/, $(subst .c,.d,$(notdir $(_RNLC_Mesh_All_C))))

# ָ����Ҫ����.o�ļ�������·��������Ӧ������Ҫ�����C�ļ�����CPP�ļ�
_RNLC_Mesh_All_O += $(addprefix $(_LTE_RNLC_TEMP_PATH)/, $(subst .c,.o,$(notdir $(_RNLC_Mesh_All_C))))

###############################################################################
# ����ģ��Ŀ���ļ���ӵ���ϵͳĿ���ļ��б�
###############################################################################
_RNLC_All_Objects += $(_RNLC_Mesh_All_O)

###############################################################################
# ���ɱ�ģ�������ļ�
###############################################################################

# �������ɱ�ģ�������ļ�ʹ�õı���ѡ��
MESH_SELF_PATH = -D__linux__
MESH_SELF_PATH += $(addprefix -I,$(_RNLC_MESH_SOURCE_PATH_LTE)/rrd) \
                 $(addprefix -I,$(_RNLC_MESH_SOURCE_PATH_LTE)/main/include) \
                 $(addprefix -I,$(_RNLC_MESH_SOURCE_PATH_LTE)/olsrd/comm/include) \
                 $(addprefix -I,$(_RNLC_MESH_SOURCE_PATH_LTE)/olsrd/olsr/include) \
                 $(addprefix -I,$(_RNLC_MESH_SOURCE_PATH_LTE)/olsrd/lq/include) \
                 $(addprefix -I,$(_RNLC_MESH_SOURCE_PATH_LTE)/olsrd/extern/include)
                 
MESH_DEPCFLAGS = $(RNLC_DEPCFLAGS) $(MESH_SELF_PATH)

# �������ɱ�ģ�������ļ�����������
define mesh_make_d
@if not exist $(_RNLC_MESH_DEPEND_PATH_LTE) $(MKDIR) $(subst /,\,$(_RNLC_MESH_DEPEND_PATH_LTE))
@$(ECHO) Making $@ ......
@$(CC) $(MESH_DEPCFLAGS) -c $< | \
    sed "s/$*\.o[ :]*/$(subst /,\/,$(_LTE_RNLC_TEMP_PATH))\/$*.o \
    $(subst /,\/,$(_LTE_RNLC_TEMP_PATH))\/$*.d \: /g" > $@
@$(ECHO) Done!
endef

# �������ɱ�ģ�������ļ��Ĺ������ζ���ÿ����Ŀ¼ʵ���ļ������ɹ���
$(_RNLC_MESH_DEPEND_PATH_LTE)/%.d : $(_RNLC_MESH_SOURCE_PATH_LTE)/rrd/%.c
	$(mesh_make_d)

$(_RNLC_MESH_DEPEND_PATH_LTE)/%.d : $(_RNLC_MESH_SOURCE_PATH_LTE)/main/source/%.c
	$(mesh_make_d)

$(_RNLC_MESH_DEPEND_PATH_LTE)/%.d : $(_RNLC_MESH_SOURCE_PATH_LTE)/olsrd/comm/source/%.c
	$(mesh_make_d)

$(_RNLC_MESH_DEPEND_PATH_LTE)/%.d : $(_RNLC_MESH_SOURCE_PATH_LTE)/olsrd/olsr/source/%.c
	$(mesh_make_d)

$(_RNLC_MESH_DEPEND_PATH_LTE)/%.d : $(_RNLC_MESH_SOURCE_PATH_LTE)/olsrd/lq/source/%.c
	$(mesh_make_d)

$(_RNLC_MESH_DEPEND_PATH_LTE)/%.d : $(_RNLC_MESH_SOURCE_PATH_LTE)/olsrd/extern/source/%.c
	$(mesh_make_d)


###############################################################################
# ���ɱ�ģ��Ŀ���ļ�
###############################################################################

# �������ɱ�ģ�������ļ�ʹ�õı���ѡ��

MESH_CFLAGS = $(filter-out -Wno-deprecated, $(RNLC_CFLAGS) $(MESH_SELF_PATH))

# �������ɱ�ģ��Ŀ���ļ�����������
define mesh_make_o
@echo ��ʼ����$<
@if not exist $(_LTE_RNLC_OBJ_PATH) $(MKDIR) $(subst /,\,$(_LTE_RNLC_OBJ_PATH))
@if not exist $(_LTE_RNLC_TEMP_PATH) $(MKDIR) $(subst /,\,$(_LTE_RNLC_TEMP_PATH))
@$(ECHO) Making $@ ......
@$(CC) $(MESH_CFLAGS) -c $< -o $@
@$(ECHO) Done!
endef

# �������ɱ�ģ��Ŀ���ļ��Ĺ������ζ���ÿ����Ŀ¼ʵ���ļ������ɹ���
$(_LTE_RNLC_TEMP_PATH)/%.o : $(_RNLC_MESH_SOURCE_PATH_LTE)/rrd/%.c
	$(mesh_make_o)

$(_LTE_RNLC_TEMP_PATH)/%.o : $(_RNLC_MESH_SOURCE_PATH_LTE)/main/source/%.c
	$(mesh_make_o)
	
$(_LTE_RNLC_TEMP_PATH)/%.o : $(_RNLC_MESH_SOURCE_PATH_LTE)/olsrd/comm/source/%.c
	$(mesh_make_o)


$(_LTE_RNLC_TEMP_PATH)/%.o : $(_RNLC_MESH_SOURCE_PATH_LTE)/olsrd/olsr/source/%.c
	$(mesh_make_o)

$(_LTE_RNLC_TEMP_PATH)/%.o : $(_RNLC_MESH_SOURCE_PATH_LTE)/olsrd/lq/source/%.c
	$(mesh_make_o)

$(_LTE_RNLC_TEMP_PATH)/%.o : $(_RNLC_MESH_SOURCE_PATH_LTE)/olsrd/extern/source/%.c
	$(mesh_make_o)


###############################################################################
# ��ģ��Lint���
###############################################################################

# ���屾ģ��lint����ʱĿ¼
_RNLC_MESH_TEMP_LINT_PATH = $(_RNLC_TEMP_LINT_PATH_LTE)/mesh
_RNLC_MESH_RESULT_LINT_PATH_LTE = $(_RNLC_RESULT_LINT_PATH_LTE)/mesh

# ���屾ģ���Lob�ļ�
_RNLC_Mesh_Lint_Obj = $(_RNLC_MESH_TEMP_LINT_PATH)/_RNLC_Mesh_Obj.lob

# ���屾ģ���Lob�ļ��б�
_RNLC_Mesh_All_Lint_Objects += $(addprefix $(_RNLC_MESH_TEMP_LINT_PATH)/, $(subst .c,.lob,$(notdir $(_RNLC_Mesh_All_CPP))))

# ����ģ���Lob�ļ��б���뵽��ϵͳ��Lob�ļ��б���
_Rnlc_All_Lint_Objects += $(_RNLC_Mesh_Lint_Obj)


# ���屾ģ��lint����
define mesh_lint
@echo ��ʼLint $<
@if not exist $(_RNLC_MESH_TEMP_LINT_PATH) $(MKDIR) $(subst /,\,$(_RNLC_MESH_TEMP_LINT_PATH))
@if not exist $(_RNLC_MESH_RESULT_LINT_PATH_LTE) $(MKDIR) $(subst /,\,$(_RNLC_MESH_RESULT_LINT_PATH_LTE))
$(ECHO) Linting $@ ......
@$(LINT) $(RNLC_LINT_CFLAGS) -u +fdi $(LINTOPTIONRNLC) $< -oo($@)
-@$(LINT_OUT_PUT_ERR)
@echo Done!
endef

$(_RNLC_Mesh_Lint_Obj): $(_RNLC_Mesh_All_Lint_Objects)
	@echo ��ʼ ---- $@
	@if not exist $(_RNLC_MESH_TEMP_LINT_PATH) $(MKDIR) $(subst /,\,$(_RNLC_MESH_TEMP_LINT_PATH))
	@$(LINT) $(LINTOPTION) $+ -oo($@)
	@echo �������Ϊ$@


$(_RNLC_MESH_TEMP_LINT_PATH)/%.lob : $(_RNLC_MESH_SOURCE_PATH_LTE)/rrd/%.c
	$(mesh_lint)

$(_RNLC_MESH_TEMP_LINT_PATH)/%.lob : $(_RNLC_MESH_SOURCE_PATH_LTE)/main/source/%.c
	$(mesh_lint)
	
$(_RNLC_MESH_TEMP_LINT_PATH)/%.lob : $(_RNLC_MESH_SOURCE_PATH_LTE)/olsrd/comm/source/%.c
	$(mesh_lint)

$(_RNLC_MESH_TEMP_LINT_PATH)/%.lob : $(_RNLC_MESH_SOURCE_PATH_LTE)/olsrd/olsr/source/%.c
	$(mesh_lint)

$(_RNLC_MESH_TEMP_LINT_PATH)/%.lob : $(_RNLC_MESH_SOURCE_PATH_LTE)/olsrd/lq/source/%.c
	$(mesh_lint)

$(_RNLC_MESH_TEMP_LINT_PATH)/%.lob : $(_RNLC_MESH_SOURCE_PATH_LTE)/olsrd/extern/source/%.c
	$(mesh_lint)


###############################################################################
# ������ģ�����ɵ�.d�ļ�
###############################################################################

ifeq (, $(_PLAT_DISABLE_DEPEND))
-include $(_RNLC_Mesh_All_Depend)
endif

###############################################################################
###############################################################################
