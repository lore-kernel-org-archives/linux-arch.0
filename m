From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v12 11/21] h8300: compressed image support
Date: Mon, 11 May 2015 15:26:30 +0900
Message-ID: <1431325600-12333-12-git-send-email-ysato@users.sourceforge.jp>
References: <1431325600-12333-1-git-send-email-ysato@users.sourceforge.jp>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail1.asahi-net.or.jp ([202.224.39.197]:35906 "EHLO
	mail1.asahi-net.or.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752376AbbEKG0t (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 11 May 2015 02:26:49 -0400
In-Reply-To: <1431325600-12333-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/h8300/boot/Makefile               | 26 ++++++++++++
 arch/h8300/boot/compressed/Makefile    | 37 +++++++++++++++++
 arch/h8300/boot/compressed/head.S      | 48 ++++++++++++++++++++++
 arch/h8300/boot/compressed/misc.c      | 74 ++++++++++++++++++++++++++++++++++
 arch/h8300/boot/compressed/vmlinux.lds | 32 +++++++++++++++
 arch/h8300/boot/compressed/vmlinux.scr |  9 +++++
 6 files changed, 226 insertions(+)
 create mode 100644 arch/h8300/boot/Makefile
 create mode 100644 arch/h8300/boot/compressed/Makefile
 create mode 100644 arch/h8300/boot/compressed/head.S
 create mode 100644 arch/h8300/boot/compressed/misc.c
 create mode 100644 arch/h8300/boot/compressed/vmlinux.lds
 create mode 100644 arch/h8300/boot/compressed/vmlinux.scr

diff --git a/arch/h8300/boot/Makefile b/arch/h8300/boot/Makefile
new file mode 100644
index 0000000..2f6393a
--- /dev/null
+++ b/arch/h8300/boot/Makefile
@@ -0,0 +1,26 @@
+# arch/h8300/boot/Makefile
+
+targets := vmlinux.srec vmlinux.bin zImage
+subdir- := compressed
+
+OBJCOPYFLAGS_vmlinux.srec := -Osrec
+OBJCOPYFLAGS_vmlinux.bin  := -Obinary
+OBJCOPYFLAGS_zImage := -O binary -R .note -R .comment -R .stab -R .stabstr -S
+
+UIMAGE_LOADADDR = $(CONFIG_RAMBASE)
+UIMAGE_ENTRYADDR = $(shell /bin/bash -c 'printf "0x%08x" \
+	$$[$(CONFIG_RAMBASE) + $(CONFIG_OFFSET)]')
+
+$(obj)/vmlinux.srec $(obj)/vmlinux.bin:  vmlinux FORCE
+	$(call if_changed,objcopy)
+
+$(obj)/zImage: $(obj)/compressed/vmlinux FORCE
+	$(call if_changed,objcopy)
+
+$(obj)/compressed/vmlinux: FORCE
+	$(Q)$(MAKE) $(build)=$(obj)/compressed $@
+
+$(obj)/uImage.bin: $(obj)/vmlinux.bin
+	$(call if_changed,uimage,none)
+
+CLEAN_FILES += arch/$(ARCH)/vmlinux.bin arch/$(ARCH)/vmlinux.srec arch/$(ARCH)/uImage.bin
diff --git a/arch/h8300/boot/compressed/Makefile b/arch/h8300/boot/compressed/Makefile
new file mode 100644
index 0000000..87d03b7
--- /dev/null
+++ b/arch/h8300/boot/compressed/Makefile
@@ -0,0 +1,37 @@
+#
+# linux/arch/sh/boot/compressed/Makefile
+#
+# create a compressed vmlinux image from the original vmlinux
+#
+
+targets		:= vmlinux vmlinux.bin vmlinux.bin.gz head.o misc.o piggy.o
+
+OBJECTS = $(obj)/head.o $(obj)/misc.o
+
+#
+# IMAGE_OFFSET is the load offset of the compression loader
+# Assign dummy values if these 2 variables are not defined,
+# in order to suppress error message.
+#
+CONFIG_MEMORY_START     ?= 0x00400000
+CONFIG_BOOT_LINK_OFFSET ?= 0x00140000
+IMAGE_OFFSET := $(shell printf "0x%08x" $$(($(CONFIG_MEMORY_START)+$(CONFIG_BOOT_LINK_OFFSET))))
+
+LIBGCC := $(shell $(CROSS-COMPILE)$(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
+LDFLAGS_vmlinux := -Ttext $(IMAGE_OFFSET) -estartup $(obj)/vmlinux.lds
+
+$(obj)/vmlinux: $(OBJECTS) $(obj)/piggy.o $(LIBGCC) FORCE
+	$(call if_changed,ld)
+	@:
+
+$(obj)/vmlinux.bin: vmlinux FORCE
+	$(call if_changed,objcopy)
+
+$(obj)/vmlinux.bin.gz: $(obj)/vmlinux.bin FORCE
+	$(call if_changed,gzip)
+
+LDFLAGS_piggy.o := -r --format binary --oformat elf32-h8300-linux -T
+OBJCOPYFLAGS := -O binary
+
+$(obj)/piggy.o: $(obj)/vmlinux.scr $(obj)/vmlinux.bin.gz FORCE
+	$(call if_changed,ld)
diff --git a/arch/h8300/boot/compressed/head.S b/arch/h8300/boot/compressed/head.S
new file mode 100644
index 0000000..74c0d8cc
--- /dev/null
+++ b/arch/h8300/boot/compressed/head.S
@@ -0,0 +1,48 @@
+/*
+ *  linux/arch/h8300/boot/compressed/head.S
+ *
+ *  Copyright (C) 2006 Yoshinori Sato
+ */
+
+#include <linux/linkage.h>
+
+	.section	.text..startup,"ax"
+	.global	startup
+startup:
+	mov.l	er0, er4
+	mov.l	er0, sp
+	mov.l	#__sbss, er0
+	mov.l	#__ebss, er1
+	sub.l	er0, er1
+	shlr	er1
+	shlr	er1
+	sub.l	er2, er2
+1:
+	mov.l	er2, @er0
+	adds	#4, er0
+	dec.l	#1, er1
+	bne	1b
+	jsr	@decompress_kernel
+	mov.l	er4, er0
+	jmp	@0x400000
+
+	.align	9
+fake_headers_as_bzImage:
+	.word	0
+	.ascii	"HdrS"		; header signature
+	.word	0x0202		; header version number (>= 0x0105)
+				; or else old loadlin-1.5 will fail)
+	.word	0		; default_switch
+	.word	0		; SETUPSEG
+	.word	0x1000
+	.word	0		; pointing to kernel version string
+	.byte	0		; = 0, old one (LILO, Loadlin,
+				; 0xTV: T=0 for LILO
+				;       V = version
+	.byte	1		; Load flags bzImage=1
+	.word	0x8000		; size to move, when setup is not
+	.long	0x100000	; 0x100000 = default for big kernel
+	.long	0		; address of loaded ramdisk image
+	.long	0		; its size in bytes
+
+	.end
diff --git a/arch/h8300/boot/compressed/misc.c b/arch/h8300/boot/compressed/misc.c
new file mode 100644
index 0000000..7042741
--- /dev/null
+++ b/arch/h8300/boot/compressed/misc.c
@@ -0,0 +1,74 @@
+/*
+ * arch/h8300/boot/compressed/misc.c
+ *
+ * This is a collection of several routines from gzip-1.0.3
+ * adapted for Linux.
+ *
+ * malloc by Hannu Savolainen 1993 and Matthias Urlichs 1994
+ *
+ * Adapted for h8300 by Yoshinori Sato 2006
+ */
+
+#include <asm/uaccess.h>
+
+/*
+ * gzip declarations
+ */
+
+#define OF(args)  args
+#define STATIC static
+
+#undef memset
+#undef memcpy
+#define memzero(s, n)     memset((s), (0), (n))
+
+extern int _end;
+static unsigned long free_mem_ptr;
+static unsigned long free_mem_end_ptr;
+
+extern char input_data[];
+extern int input_len;
+static unsigned char *output;
+
+#define HEAP_SIZE             0x10000
+
+#include "../../../../lib/decompress_inflate.c"
+
+void *memset(void *s, int c, size_t n)
+{
+	int i;
+	char *ss = (char *)s;
+
+	for (i = 0; i < n; i++)
+		ss[i] = c;
+	return s;
+}
+
+void *memcpy(void *dest, const void *src, size_t n)
+{
+	int i;
+	char *d = (char *)dest, *s = (char *)src;
+
+	for (i = 0; i < n; i++)
+		d[i] = s[i];
+	return dest;
+}
+
+static void error(char *x)
+{
+
+	while (1)
+		;	/* Halt */
+}
+
+#define STACK_SIZE (4096)
+long user_stack[STACK_SIZE];
+long *stack_start = &user_stack[STACK_SIZE];
+
+void decompress_kernel(void)
+{
+	free_mem_ptr = (unsigned long)&_end;
+	free_mem_end_ptr = free_mem_ptr + HEAP_SIZE;
+
+	decompress(input_data, input_len, NULL, NULL, output, NULL, error);
+}
diff --git a/arch/h8300/boot/compressed/vmlinux.lds b/arch/h8300/boot/compressed/vmlinux.lds
new file mode 100644
index 0000000..a0a3a0e
--- /dev/null
+++ b/arch/h8300/boot/compressed/vmlinux.lds
@@ -0,0 +1,32 @@
+SECTIONS
+{
+        .text :
+        {
+        __stext = . ;
+	__text = .;
+	       *(.text..startup)
+	       *(.text)
+        __etext = . ;
+        }
+
+	.rodata :
+	{
+		*(.rodata)
+	}
+        .data :
+
+        {
+        __sdata = . ;
+        ___data_start = . ;
+                *(.data.*)
+	}
+        .bss :
+        {
+        . = ALIGN(0x4) ;
+        __sbss = . ;
+                *(.bss*)
+        . = ALIGN(0x4) ;
+        __ebss = . ;
+        __end = . ;
+        }
+}
diff --git a/arch/h8300/boot/compressed/vmlinux.scr b/arch/h8300/boot/compressed/vmlinux.scr
new file mode 100644
index 0000000..a0849036
--- /dev/null
+++ b/arch/h8300/boot/compressed/vmlinux.scr
@@ -0,0 +1,9 @@
+SECTIONS
+{
+  .data : {
+	input_len = .;
+	LONG(input_data_end - input_data) input_data = .;
+	*(.data)
+	input_data_end = .;
+	}
+}
-- 
2.1.4
