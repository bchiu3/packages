LIBCURL_CFLAGS := -I$(shell pwd)/../build/include 
LIBCURL_LDFLAGS := -L$(shell pwd)/../build/lib  -lcurl -static

LIBOPENSSL_CFLAGS := -I$(shell pwd)/../build/include
LIBOPENSSL_LDFLAGS := -L$(shell pwd)/../build/lib -lssl -static

ifeq ($(DEBUG),1)
CFLAGS ?= -Wall -Wextra -O0 -ggdb3
else
CFLAGS ?= -Wall -Wextra -O1 
endif

LIBS_CFLAGS := $(LIBCURL_CFLAGS) $(LIBOPENSSL_CFLAGS)
LIBS_LDFLAGS := $(LIBCURL_LDFLAGS) $(LIBOPENSSL_LDFLAGS)

.PHONY: all clean

all: curl-websocket autobahn-testee

curl-websocket: main.c curl-websocket.c curl-websocket-utils.c Makefile
	$(CC) $(CFLAGS) $(LIBS_CFLAGS) \
		main.c curl-websocket.c \
		-o $@ $(LIBS_LDFLAGS)

autobahn-testee: autobahn-testee.c curl-websocket.c curl-websocket-utils.c Makefile
	$(CC) $(CFLAGS) $(LIBS_CFLAGS) \
		autobahn-testee.c curl-websocket.c \
		-o $@ $(LIBS_LDFLAGS)

clean:
	rm -f curl-websocket autobahn-testee
