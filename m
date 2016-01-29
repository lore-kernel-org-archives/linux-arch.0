From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [PATCH 01/12] [kbuild] handle exports in lib-y objects reliably
Date: Fri, 29 Jan 2016 19:18:23 +0000
Message-ID: <1454095114-4128-1-git-send-email-viro@ZenIV.linux.org.uk>
References: <20160129191744.GB17997@ZenIV.linux.org.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160129191744.GB17997@ZenIV.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 scripts/Makefile.build | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

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
