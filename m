From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 3/5] kbuild: generate asm-generic wrappers if mandatory headers are missing
Date: Thu,  3 Jan 2019 10:10:38 +0900
Message-ID: <1546477840-14278-3-git-send-email-yamada.masahiro@socionext.com>
References: <1546477840-14278-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546477840-14278-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kbuild@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org, Masahiro Yamada <yamada.masahiro@socionext.com>
List-Id: linux-arch.vger.kernel.org

Some time ago, Sam pointed out a certain degree of overwrap between
generic-y and mandatory-y. (https://lkml.org/lkml/2017/7/10/121)

I tweaked the meaning of mandatory-y a little bit; now it defines the
minimum set of ASM headers that all architectures must have.

If arch does not have specific implementation of a mandatory header,
Kbuild will let it fallback to the asm-generic one by automatically
generating a wrapper. This will allow to drop lots of redundant
generic-y defines.

Previously, "mandatory" was used in the context of UAPI, but I guess
this can be extended to kernel space ASM headers.

Suggested-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---

Changes in v2:
  - Filter-out $(generiated-y) from $(mandatory-y) because
    ARCH may generate mandatory headers by other means

 Documentation/kbuild/makefiles.txt | 9 ++++++---
 scripts/Makefile.asm-generic       | 4 ++++
 scripts/Makefile.headersinst       | 7 -------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
index 8da26c6..bf28c47 100644
--- a/Documentation/kbuild/makefiles.txt
+++ b/Documentation/kbuild/makefiles.txt
@@ -1296,9 +1296,12 @@ See subsequent chapter for the syntax of the Kbuild file.
 
 --- 7.4 mandatory-y
 
-	mandatory-y is essentially used by include/uapi/asm-generic/Kbuild.asm
-	to define the minimum set of headers that must be exported in
-	include/asm.
+	mandatory-y is essentially used by include/(uapi/)asm-generic/Kbuild.asm
+	to define the minimum set of ASM headers that all architectures must have.
+
+	This works like optional generic-y. If a mandatory header is missing
+	in arch/$(ARCH)/include/(uapi/)/asm, Kbuild will automatically generate
+	a wrapper of the asm-generic one.
 
 	The convention is to list one subdir per line and
 	preferably in alphabetic order.
diff --git a/scripts/Makefile.asm-generic b/scripts/Makefile.asm-generic
index 760323e..a62d282 100644
--- a/scripts/Makefile.asm-generic
+++ b/scripts/Makefile.asm-generic
@@ -14,6 +14,10 @@ src := $(subst /generated,,$(obj))
 
 include scripts/Kbuild.include
 
+# If arch does not implement mandatory headers, fallback to asm-generic ones.
+mandatory-y := $(filter-out $(generated-y), $(mandatory-y))
+generic-y   += $(foreach f, $(mandatory-y), $(if $(wildcard $(srctree)/$(src)/$(f)),,$(f)))
+
 generic-y   := $(addprefix $(obj)/, $(generic-y))
 generated-y := $(addprefix $(obj)/, $(generated-y))
 
diff --git a/scripts/Makefile.headersinst b/scripts/Makefile.headersinst
index 45927fc..3d1ebaa 100644
--- a/scripts/Makefile.headersinst
+++ b/scripts/Makefile.headersinst
@@ -56,13 +56,6 @@ check-file    := $(installdir)/.check
 all-files     := $(header-files) $(genhdr-files)
 output-files  := $(addprefix $(installdir)/, $(all-files))
 
-ifneq ($(mandatory-y),)
-missing       := $(filter-out $(all-files),$(mandatory-y))
-ifneq ($(missing),)
-$(error Some mandatory headers ($(missing)) are missing in $(obj))
-endif
-endif
-
 # Work out what needs to be removed
 oldheaders    := $(patsubst $(installdir)/%,%,$(wildcard $(installdir)/*.h))
 unwanted      := $(filter-out $(all-files),$(oldheaders))
-- 
2.7.4
