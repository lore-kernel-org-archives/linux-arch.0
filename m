Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754043AbcHSVey (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 19 Aug 2016 17:34:54 -0400
From: mcgrof@kernel.org
Subject: [PATCH v4 03/16] scripts/module-common.lds: enable generation
Date: Fri, 19 Aug 2016 14:32:52 -0700
Message-ID: <1471642385-5629-4-git-send-email-mcgrof@kernel.org>
In-Reply-To: <1471642385-5629-1-git-send-email-mcgrof@kernel.org>
References: <1471642385-5629-1-git-send-email-mcgrof@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, jpoimboe@redhat.com, bp@alien8.de, linux@arm.linux.org.uk, mhiramat@kernel.org, masami.hiramatsu.pt@hitachi.com, jbaron@akamai.com, heiko.carstens@de.ibm.com, ananth@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, realmz6@gmail.com
Cc: x86@kernel.org, luto@amacapital.net, keescook@chromium.org, torvalds@linux-foundation.org, gregkh@linuxfoundation.org, rusty@rustcorp.com.au, gnomes@lxorguk.ukuu.org.uk, alan@linux.intel.com, dwmw2@infradead.org, arnd@arndb.de, ming.lei@canonical.com, linux-arch@vger.kernel.org, benh@kernel.crashing.org, ananth@in.ibm.com, pebolle@tiscali.nl, fontana@sharpeleven.org, david.vrabel@citrix.com, konrad.wilk@oracle.com, mcb30@ipxe.org, jgross@suse.com, andrew.cooper3@citrix.com, andriy.shevchenko@linux.intel.com, paul.gortmaker@windriver.com, xen-devel@lists.xensource.com, ak@linux.intel.com, pali.rohar@gmail.com, dvhart@infradead.org, platform-driver-x86@vger.kernel.org, mmarek@suse.com, linux@rasmusvillemoes.dk, jkosina@suse.cz, korea.drzix@gmail.com, linux-kbuild@vger.kernel.org, tony.luck@intel.com, akpm@linux-foundation.org, linux-ia64@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, rostedt@goodmis.org, jani.nikula@intel.com, mchehab@osg.samsung.com, markus.heiser@darmarit.de, acme@redhat.com, jolsa@kernel.org, msalter@redhat.com, chris@zankel.net, jcmvbkbc@gmail.com, linux-xtensa@linux-xtensa.org, paulus@samba.org, mpe@ellerman.id.au, James.Bottomley@HansenPartnership.com, "Luis R. Rodriguez" <mcgrof@kernel.org>
Message-ID: <20160819213252.cf7Ajn7X0epCqogE44HCG-CrVKkN01Tj7n6VbwVkzqc@z>

From: "Luis R. Rodriguez" <mcgrof@kernel.org>

scripts/module-common.lds is currently pretty static, in the
future this may change and we will want access to kernel macros
to help expands certain areas. To get access to use macros we
need to generate module-common.lds from module-common.lds.S, for
now though only enable the generation. We'll later expand on this
as needed.

Since this file is now generated add it to .gitignore.

v4: add file to MAINTAINERS
v3: new to this series

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 .gitignore                                         | 2 ++
 MAINTAINERS                                        | 1 +
 Makefile                                           | 6 +++++-
 scripts/Makefile.modpost                           | 2 +-
 scripts/{module-common.lds => module-common.lds.S} | 0
 5 files changed, 9 insertions(+), 2 deletions(-)
 rename scripts/{module-common.lds => module-common.lds.S} (100%)

diff --git a/.gitignore b/.gitignore
index c2ed4ecb0acd..0f0702054fdb 100644
--- a/.gitignore
+++ b/.gitignore
@@ -114,3 +114,5 @@ all.config
 
 # Kdevelop4
 *.kdev4
+
+scripts/module-common.lds
diff --git a/MAINTAINERS b/MAINTAINERS
index d635ab047f3a..5aec01883020 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7887,6 +7887,7 @@ M:	Rusty Russell <rusty@rustcorp.com.au>
 S:	Maintained
 F:	include/linux/module.h
 F:	kernel/module.c
+F:	scripts/module-common.lds.S
 
 MOTION EYE VAIO PICTUREBOOK CAMERA DRIVER
 W:	http://popies.net/meye/
diff --git a/Makefile b/Makefile
index 5c18baad7218..b3e5ea78d582 100644
--- a/Makefile
+++ b/Makefile
@@ -408,6 +408,10 @@ KBUILD_AFLAGS_MODULE  := -DMODULE
 KBUILD_CFLAGS_MODULE  := -DMODULE
 KBUILD_LDFLAGS_MODULE := -T $(srctree)/scripts/module-common.lds
 
+$(srctree)/scripts/module-common.lds: $(srctree)/scripts/module-common.lds.S
+	$(Q)$(CC) $(CFLAGS) $(INCLUDES) $(LINUXINCLUDE) -E -P \
+		-D__ASSEMBLY__ -DLINKER_SCRIPT -o $@ $<
+
 # Read KERNELRELEASE from include/config/kernel.release (if it exists)
 KERNELRELEASE = $(shell cat include/config/kernel.release 2> /dev/null)
 KERNELVERSION = $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(SUBLEVEL),.$(SUBLEVEL)))$(EXTRAVERSION)
@@ -1174,7 +1178,7 @@ all: modules
 # using awk while concatenating to the final file.
 
 PHONY += modules
-modules: $(vmlinux-dirs) $(if $(KBUILD_BUILTIN),vmlinux) modules.builtin
+modules: $(srctree)/scripts/module-common.lds $(vmlinux-dirs) $(if $(KBUILD_BUILTIN),vmlinux) modules.builtin
 	$(Q)$(AWK) '!x[$$0]++' $(vmlinux-dirs:%=$(objtree)/%/modules.order) > $(objtree)/modules.order
 	@$(kecho) '  Building modules, stage 2.';
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost
diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 1366a94b6c39..2d8aff7735d6 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -121,7 +121,7 @@ quiet_cmd_ld_ko_o = LD [M]  $@
                              $(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE) \
                              -o $@ $(filter-out FORCE,$^)
 
-$(modules): %.ko :%.o %.mod.o FORCE
+$(modules): %.ko : $(srctree)/scripts/module-common.lds %.o %.mod.o FORCE
 	$(call if_changed,ld_ko_o)
 
 targets += $(modules)
diff --git a/scripts/module-common.lds b/scripts/module-common.lds.S
similarity index 100%
rename from scripts/module-common.lds
rename to scripts/module-common.lds.S
-- 
2.9.2

