# can run `make Q=` to see commands as they run
Q := @

DTC := $(Q)dtc

.PHONY: all clean install

TARGETS := logibone-00A0.dtbo

all: $(TARGETS)

clean:
	$(RM) $(TARGETS) *.o

install: logibone-00A0.dtbo
	$(Q)install -v $^ /lib/firmware

%.dtbo: %.dts
	$(DTC) -I dts -b0 -O dtb -@ -o $@ $^

