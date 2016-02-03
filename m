From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [PATCH v2 01/13] [kbuild] handle exports in lib-y objects reliably
Date: Wed,  3 Feb 2016 21:20:33 +0000
Message-ID: <1454534445-16759-1-git-send-email-viro@ZenIV.linux.org.uk>
References: <20160203211953.GT17997@ZenIV.linux.org.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160203211953.GT17997@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Collect the symbols exported by anything that goes into lib.a and
add an empty object (lib-exports.o) with explicit undefs for each
of those to obj-y.

That allows to relax the rules regarding the use of exports in
lib-* objects - right now an object with export can be in lib-*
only if we are guaranteed that there always will be users in
built-in parts of the tree, otherwise it needs to be in obj-*.
As the result, we have an unholy mix of lib- and obj- in lib/Makefile
and (especially) in arch/*/lib/Makefile.  Moreover, a change in
generic part of the kernel can lead to mysteriously missing exports
on some configs.  With this change we don't have to worry about
that anymore.

One side effect is that built-in.o now pulls everything with exports
from the corresponding lib.a (if such exists).  That's exactly what
we want for linking vmlinux and fortunately it's almost the only thing
built-in.o is used in.  arch/ia64/hp/sim/boot/bootloader is the only
exception and it's easy to get rid of now - just turn everything in
arch/ia64/lib into lib-* and don't bother with arch/ia64/lib/built-in.o
anymore.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/ia64/hp/sim/boot/Makefile |  2 +-
 arch/ia64/lib/Makefile         |  8 +++-----
 scripts/Makefile.build         | 20 ++++++++++++++++++++
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/arch/ia64/hp/sim/boot/Makefile b/arch/ia64/hp/sim/boot/Makefile
index 2e805e0..df6e996 100644
--- a/arch/ia64/hp/sim/boot/Makefile
+++ b/arch/ia64/hp/sim/boot/Makefile
@@ -33,5 +33,5 @@ $(obj)/vmlinux.bin: vmlinux FORCE
 LDFLAGS_bootloader = -static -T
 
 $(obj)/bootloader: $(src)/bootloader.lds $(obj)/bootloader.o $(obj)/boot_head.o $(obj)/fw-emu.o \
-                   lib/lib.a arch/ia64/lib/built-in.o arch/ia64/lib/lib.a FORCE
+                   lib/lib.a arch/ia64/lib/lib.a FORCE
 	$(call if_changed,ld)
diff --git a/arch/ia64/lib/Makefile b/arch/ia64/lib/Makefile
index 98771e2..1f3d387 100644
--- a/arch/ia64/lib/Makefile
+++ b/arch/ia64/lib/Makefile
@@ -2,17 +2,15 @@
 # Makefile for ia64-specific library routines..
 #
 
-obj-y := io.o
-
-lib-y := __divsi3.o __udivsi3.o __modsi3.o __umodsi3.o			\
+lib-y := io.o __divsi3.o __udivsi3.o __modsi3.o __umodsi3.o		\
 	__divdi3.o __udivdi3.o __moddi3.o __umoddi3.o			\
 	checksum.o clear_page.o csum_partial_copy.o			\
 	clear_user.o strncpy_from_user.o strlen_user.o strnlen_user.o	\
 	flush.o ip_fast_csum.o do_csum.o				\
 	memset.o strlen.o xor.o
 
-obj-$(CONFIG_ITANIUM)	+= copy_page.o copy_user.o memcpy.o
-obj-$(CONFIG_MCKINLEY)	+= copy_page_mck.o memcpy_mck.o
+lib-$(CONFIG_ITANIUM)	+= copy_page.o copy_user.o memcpy.o
+lib-$(CONFIG_MCKINLEY)	+= copy_page_mck.o memcpy_mck.o
 lib-$(CONFIG_PERFMON)	+= carta_random.o
 
 AFLAGS___divdi3.o	=
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 2c47f9c..d041013 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -81,6 +81,7 @@ endif
 
 ifneq ($(strip $(lib-y) $(lib-m) $(lib-)),)
 lib-target := $(obj)/lib.a
+obj-y += $(obj)/lib-ksyms.o
 endif
 
 ifneq ($(strip $(obj-y) $(obj-m) $(obj-) $(subdir-m) $(lib-target)),)
@@ -363,6 +364,25 @@ $(lib-target): $(lib-y) FORCE
 	$(call if_changed,link_l_target)
 
 targets += $(lib-target)
+
+dummy-object = $(obj)/__lib_exports.o
+ksyms-lds = $(obj)/lib-ksyms.lds
+ifdef CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
+ref_prefix = EXTERN(_
+else
+ref_prefix = EXTERN(
+endif
+
+quiet_cmd_export_list = EXPORTS $@
+cmd_export_list = $(OBJDUMP) -h $< | \
+	sed -ne '/___ksymtab/{s/.*+/$(ref_prefix)/;s/ .*/)/;p}' >$(ksyms-lds);\
+	rm -f $(dummy-object);\
+	$(AR) rcs$(KBUILD_ARFLAGS) $(dummy-object);\
+	$(LD) $(ld_flags) -r -o $@ -T $(ksyms-lds) $(dummy-object);\
+	rm $(dummy-object) $(ksyms-lds)
+
+$(obj)/lib-ksyms.o: $(lib-target) FORCE
+	$(call if_changed,export_list)
 endif
 
 #
-- 
2.1.4
