From: David Howells <dhowells@redhat.com>
Subject: [PATCH [ver #2] 36/39] UAPI: Move linux/version.h
Date: Fri, 08 Jul 2011 15:28:51 +0100
Message-ID: <20110708142850.31344.42044.stgit@warthog.procyon.org.uk>
References: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:18574 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751872Ab1GHO3d (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 8 Jul 2011 10:29:33 -0400
In-Reply-To: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: rdunlap@xenotime.net, hpa@kernel.org, matthew@wil.cx, linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, ralf@linux-mips.org

Move include/linux/version.h to the UAPI header directory.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Makefile                  |   10 +++++-----
 include/linux/Kbuild      |    1 -
 include/uapi/linux/Kbuild |    3 +++
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index ca2bae7..9a165a7 100644
--- a/Makefile
+++ b/Makefile
@@ -450,7 +450,7 @@ asm-generic:
 
 no-dot-config-targets := clean mrproper distclean \
 			 cscope gtags TAGS tags help %docs check% coccicheck \
-			 include/linux/version.h headers_% \
+			 include/uapi/linux/version.h headers_% \
 			 kernelversion %src-pkg
 
 config-targets := 0
@@ -983,7 +983,7 @@ endif
 # prepare2 creates a makefile if using a separate output directory
 prepare2: prepare3 outputmakefile asm-generic
 
-prepare1: prepare2 include/linux/version.h include/generated/utsrelease.h \
+prepare1: prepare2 include/uapi/linux/version.h include/generated/utsrelease.h \
                    include/config/auto.conf
 	$(cmd_crmodverdir)
 
@@ -1017,7 +1017,7 @@ define filechk_version.h
 	echo '#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))';)
 endef
 
-include/linux/version.h: $(srctree)/Makefile FORCE
+include/uapi/linux/version.h: $(srctree)/Makefile FORCE
 	$(call filechk,version.h)
 
 include/generated/utsrelease.h: include/config/kernel.release FORCE
@@ -1056,7 +1056,7 @@ hdr-inst := -rR -f $(srctree)/scripts/Makefile.headersinst obj
 hdr-dst = $(if $(KBUILD_HEADERS), dst=include/asm-$(hdr-arch), dst=include/asm)
 
 PHONY += __headers
-__headers: include/linux/version.h scripts_basic asm-generic FORCE
+__headers: include/uapi/linux/version.h scripts_basic asm-generic FORCE
 	$(Q)$(MAKE) $(build)=scripts build_unifdef
 
 PHONY += headers_install_all
@@ -1175,7 +1175,7 @@ CLEAN_FILES +=	vmlinux System.map \
 MRPROPER_DIRS  += include/config usr/include include/generated          \
                   arch/*/include/generated
 MRPROPER_FILES += .config .config.old .version .old_version             \
-                  include/linux/version.h                               \
+                  include/uapi/linux/version.h                          \
 		  Module.symvers tags TAGS cscope* GPATH GTAGS GRTAGS GSYMS
 
 # clean - Delete most, but leave enough to build external modules
diff --git a/include/linux/Kbuild b/include/linux/Kbuild
index 01f6362..f429b36 100644
--- a/include/linux/Kbuild
+++ b/include/linux/Kbuild
@@ -19,7 +19,6 @@ header-y += netfilter_ipv6/
 header-y += usb/
 header-y += wimax/
 
-objhdr-y += version.h
 
 ifneq ($(wildcard $(srctree)/arch/$(SRCARCH)/include/asm/a.out.h \
 		  $(srctree)/include/asm-$(SRCARCH)/a.out.h \
diff --git a/include/uapi/linux/Kbuild b/include/uapi/linux/Kbuild
index b29b895..2731127 100644
--- a/include/uapi/linux/Kbuild
+++ b/include/uapi/linux/Kbuild
@@ -12,3 +12,6 @@ header-y += sunrpc/
 header-y += netfilter/
 header-y += usb/
 header-y += wimax/
+
+objhdr-y += version.h
+
