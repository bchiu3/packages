TARGET_EXEC = libpcre2.a
CFLAGS += -DHAVE_CONFIG_H -DPCRE2_CODE_UNIT_WIDTH=8

BUILD_DIR ?= ../build
SRC_DIRS ?= ./src

SRCS := pcre2_auto_possess.c \
	     pcre2_chartables.c \
       pcre2_compile.c \
       pcre2_config.c \
       pcre2_context.c \
       pcre2_convert.c \
       pcre2_dfa_match.c \
       pcre2_error.c \
       pcre2_extuni.c \
       pcre2_find_bracket.c \
       pcre2_jit_compile.c \
       pcre2_maketables.c \
       pcre2_match.c \
       pcre2_match_data.c \
       pcre2_newline.c \
       pcre2_ord2utf.c \
       pcre2_pattern_info.c \
       pcre2_script_run.c \
       pcre2_serialize.c \
       pcre2_string_utils.c \
       pcre2_study.c \
       pcre2_substitute.c \
       pcre2_substring.c \
       pcre2_tables.c \
       pcre2_ucd.c \
       pcre2_valid_utf.c \
       pcre2_xclass.c

OBJS := $(SRCS:%=$(BUILD_DIR)/%.o)
DEPS := $(OBJS:.o=.d)

CPPFLAGS ?= $(INC_FLAGS) -MMD -MP

$(BUILD_DIR)/$(TARGET_EXEC): $(OBJS)
	$(AR) rcs -o $@ $(OBJS)

# c source
$(BUILD_DIR)/%.c.o: %.c
	$(MKDIR_P) $(dir $@)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

.PHONY: clean

clean:
	$(RM) -r $(BUILD_DIR)

-include $(DEPS)

MKDIR_P ?= mkdir -p
