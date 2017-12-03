###############################################################################
# Dcm模块的makefile文件
# Author：zhailg117736
# date：2011-7-8
###############################################################################

###############################################################################
# 指定需要编译的本模块实现文件（C或者CPP文件）、依赖文件和目标文件
###############################################################################

# 指定需要编译的CPP文件：依次添加本模块下所有子目录下的文件
_RNLC_Mesh_All_C += $(wildcard $(_RNLC_MESH_SOURCE_PATH_LTE)/rrd/*.c)
_RNLC_Mesh_All_C += $(wildcard $(_RNLC_MESH_SOURCE_PATH_LTE)/main/source/*.c)
_RNLC_Mesh_All_C += $(wildcard $(_RNLC_MESH_SOURCE_PATH_LTE)/olsrd/comm/source/*.c)
_RNLC_Mesh_All_C += $(wildcard $(_RNLC_MESH_SOURCE_PATH_LTE)/olsrd/olsr/source/*.c)
_RNLC_Mesh_All_C += $(wildcard $(_RNLC_MESH_SOURCE_PATH_LTE)/olsrd/lq/source/*.c)
_RNLC_Mesh_All_C += $(wildcard $(_RNLC_MESH_SOURCE_PATH_LTE)/olsrd/extern/source/*.c)


# 指定需要编译的依赖文件：对应所有需要编译的C文件或者CPP文件
_RNLC_Mesh_All_Depend += $(addprefix $(_RNLC_MESH_DEPEND_PATH_LTE)/, $(subst .c,.d,$(notdir $(_RNLC_Mesh_All_C))))

# 指定需要编译.o文件名（含路径）：对应所有需要编译的C文件或者CPP文件
_RNLC_Mesh_All_O += $(addprefix $(_LTE_RNLC_TEMP_PATH)/, $(subst .c,.o,$(notdir $(_RNLC_Mesh_All_C))))

###############################################################################
# 将本模块目标文件添加到子系统目标文件列表
###############################################################################
_RNLC_All_Objects += $(_RNLC_Mesh_All_O)

###############################################################################
# 生成本模块依赖文件
###############################################################################

# 定义生成本模块依赖文件使用的编译选项
MESH_SELF_PATH = -D__linux__
MESH_SELF_PATH += $(addprefix -I,$(_RNLC_MESH_SOURCE_PATH_LTE)/rrd) \
                 $(addprefix -I,$(_RNLC_MESH_SOURCE_PATH_LTE)/main/include) \
                 $(addprefix -I,$(_RNLC_MESH_SOURCE_PATH_LTE)/olsrd/comm/include) \
                 $(addprefix -I,$(_RNLC_MESH_SOURCE_PATH_LTE)/olsrd/olsr/include) \
                 $(addprefix -I,$(_RNLC_MESH_SOURCE_PATH_LTE)/olsrd/lq/include) \
                 $(addprefix -I,$(_RNLC_MESH_SOURCE_PATH_LTE)/olsrd/extern/include)
                 
MESH_DEPCFLAGS = $(RNLC_DEPCFLAGS) $(MESH_SELF_PATH)

# 定义生成本模块依赖文件的命令序列
define mesh_make_d
@if not exist $(_RNLC_MESH_DEPEND_PATH_LTE) $(MKDIR) $(subst /,\,$(_RNLC_MESH_DEPEND_PATH_LTE))
@$(ECHO) Making $@ ......
@$(CC) $(MESH_DEPCFLAGS) -c $< | \
    sed "s/$*\.o[ :]*/$(subst /,\/,$(_LTE_RNLC_TEMP_PATH))\/$*.o \
    $(subst /,\/,$(_LTE_RNLC_TEMP_PATH))\/$*.d \: /g" > $@
@$(ECHO) Done!
endef

# 定义生成本模块依赖文件的规则：依次定义每个子目录实现文件的生成规则
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
# 生成本模块目标文件
###############################################################################

# 定义生成本模块依赖文件使用的编译选项

MESH_CFLAGS = $(filter-out -Wno-deprecated, $(RNLC_CFLAGS) $(MESH_SELF_PATH))

# 定义生成本模块目标文件的命令序列
define mesh_make_o
@echo 开始编译$<
@if not exist $(_LTE_RNLC_OBJ_PATH) $(MKDIR) $(subst /,\,$(_LTE_RNLC_OBJ_PATH))
@if not exist $(_LTE_RNLC_TEMP_PATH) $(MKDIR) $(subst /,\,$(_LTE_RNLC_TEMP_PATH))
@$(ECHO) Making $@ ......
@$(CC) $(MESH_CFLAGS) -c $< -o $@
@$(ECHO) Done!
endef

# 定义生成本模块目标文件的规则：依次定义每个子目录实现文件的生成规则
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
# 本模块Lint检查
###############################################################################

# 定义本模块lint的临时目录
_RNLC_MESH_TEMP_LINT_PATH = $(_RNLC_TEMP_LINT_PATH_LTE)/mesh
_RNLC_MESH_RESULT_LINT_PATH_LTE = $(_RNLC_RESULT_LINT_PATH_LTE)/mesh

# 定义本模块的Lob文件
_RNLC_Mesh_Lint_Obj = $(_RNLC_MESH_TEMP_LINT_PATH)/_RNLC_Mesh_Obj.lob

# 定义本模块的Lob文件列表
_RNLC_Mesh_All_Lint_Objects += $(addprefix $(_RNLC_MESH_TEMP_LINT_PATH)/, $(subst .c,.lob,$(notdir $(_RNLC_Mesh_All_CPP))))

# 将本模块的Lob文件列表加入到子系统的Lob文件列表中
_Rnlc_All_Lint_Objects += $(_RNLC_Mesh_Lint_Obj)


# 定义本模块lint操作
define mesh_lint
@echo 开始Lint $<
@if not exist $(_RNLC_MESH_TEMP_LINT_PATH) $(MKDIR) $(subst /,\,$(_RNLC_MESH_TEMP_LINT_PATH))
@if not exist $(_RNLC_MESH_RESULT_LINT_PATH_LTE) $(MKDIR) $(subst /,\,$(_RNLC_MESH_RESULT_LINT_PATH_LTE))
$(ECHO) Linting $@ ......
@$(LINT) $(RNLC_LINT_CFLAGS) -u +fdi $(LINTOPTIONRNLC) $< -oo($@)
-@$(LINT_OUT_PUT_ERR)
@echo Done!
endef

$(_RNLC_Mesh_Lint_Obj): $(_RNLC_Mesh_All_Lint_Objects)
	@echo 开始 ---- $@
	@if not exist $(_RNLC_MESH_TEMP_LINT_PATH) $(MKDIR) $(subst /,\,$(_RNLC_MESH_TEMP_LINT_PATH))
	@$(LINT) $(LINTOPTION) $+ -oo($@)
	@echo 输出内容为$@


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
# 包含本模块生成的.d文件
###############################################################################

ifeq (, $(_PLAT_DISABLE_DEPEND))
-include $(_RNLC_Mesh_All_Depend)
endif

###############################################################################
###############################################################################
