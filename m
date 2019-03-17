Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conuserg-12.nifty.com ([210.131.2.79]:65085 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfCQCCC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 16 Mar 2019 22:02:02 -0400
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 2/2] kbuild: force all architectures except um to include mandatory-y
Date: Sun, 17 Mar 2019 11:01:09 +0900
Message-Id: <1552788069-26557-2-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1552788069-26557-1-git-send-email-yamada.masahiro@socionext.com>
References: <1552788069-26557-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, Masahiro Yamada <yamada.masahiro@socionext.com>

Currently, every arch/*/include/uapi/asm/Kbuild explicitly includes
the common Kbuild.asm file. Factor out the duplicated include directives
to scripts/Makefile.asm-generic so that no architecture would opt out
of the mandatory-y mechanism.

um is not forced to include mandatory-y since it is a very exceptional
case which does not support UAPI.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Documentation/kbuild/makefiles.txt              | 2 +-
 Makefile                                        | 6 ++++--
 arch/alpha/include/uapi/asm/Kbuild              | 2 --
 arch/arc/include/uapi/asm/Kbuild                | 2 --
 arch/arm/include/uapi/asm/Kbuild                | 1 -
 arch/arm64/include/uapi/asm/Kbuild              | 1 -
 arch/c6x/include/uapi/asm/Kbuild                | 2 --
 arch/csky/include/uapi/asm/Kbuild               | 2 --
 arch/h8300/include/uapi/asm/Kbuild              | 2 --
 arch/hexagon/include/uapi/asm/Kbuild            | 2 --
 arch/ia64/include/uapi/asm/Kbuild               | 2 --
 arch/m68k/include/uapi/asm/Kbuild               | 2 --
 arch/microblaze/include/uapi/asm/Kbuild         | 2 --
 arch/mips/include/uapi/asm/Kbuild               | 2 --
 arch/nds32/include/uapi/asm/Kbuild              | 2 --
 arch/nios2/include/uapi/asm/Kbuild              | 2 --
 arch/openrisc/include/uapi/asm/Kbuild           | 2 --
 arch/parisc/include/uapi/asm/Kbuild             | 2 --
 arch/powerpc/include/uapi/asm/Kbuild            | 2 --
 arch/riscv/include/uapi/asm/Kbuild              | 1 -
 arch/s390/include/uapi/asm/Kbuild               | 1 -
 arch/sh/include/uapi/asm/Kbuild                 | 1 -
 arch/sparc/include/uapi/asm/Kbuild              | 2 --
 arch/unicore32/include/uapi/asm/Kbuild          | 2 --
 arch/x86/include/uapi/asm/Kbuild                | 2 --
 arch/xtensa/include/uapi/asm/Kbuild             | 2 --
 include/asm-generic/Kbuild                      | 5 +++++
 include/uapi/asm-generic/{Kbuild.asm => Kbuild} | 4 +++-
 scripts/Makefile.asm-generic                    | 5 +++++
 29 files changed, 18 insertions(+), 47 deletions(-)
 create mode 100644 include/asm-generic/Kbuild
 rename include/uapi/asm-generic/{Kbuild.asm => Kbuild} (87%)

diff --git a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
index f124be6..03c0658 100644
--- a/Documentation/kbuild/makefiles.txt
+++ b/Documentation/kbuild/makefiles.txt
@@ -1274,7 +1274,7 @@ See subsequent chapter for the syntax of the Kbuild file.
 
 --- 7.4 mandatory-y
 
-	mandatory-y is essentially used by include/(uapi/)asm-generic/Kbuild.asm
+	mandatory-y is essentially used by include/(uapi/)asm-generic/Kbuild
 	to define the minimum set of ASM headers that all architectures must have.
 
 	This works like optional generic-y. If a mandatory header is missing
diff --git a/Makefile b/Makefile
index 1ef92d7..00ea6b2 100644
--- a/Makefile
+++ b/Makefile
@@ -1098,9 +1098,11 @@ asm-generic := -f $(srctree)/scripts/Makefile.asm-generic obj
 
 PHONY += asm-generic uapi-asm-generic
 asm-generic: uapi-asm-generic
-	$(Q)$(MAKE) $(asm-generic)=arch/$(SRCARCH)/include/generated/asm
+	$(Q)$(MAKE) $(asm-generic)=arch/$(SRCARCH)/include/generated/asm \
+	generic=include/asm-generic
 uapi-asm-generic:
-	$(Q)$(MAKE) $(asm-generic)=arch/$(SRCARCH)/include/generated/uapi/asm
+	$(Q)$(MAKE) $(asm-generic)=arch/$(SRCARCH)/include/generated/uapi/asm \
+	generic=include/uapi/asm-generic
 
 PHONY += prepare-objtool
 prepare-objtool: $(objtool_target)
diff --git a/arch/alpha/include/uapi/asm/Kbuild b/arch/alpha/include/uapi/asm/Kbuild
index 439f515..7417847 100644
--- a/arch/alpha/include/uapi/asm/Kbuild
+++ b/arch/alpha/include/uapi/asm/Kbuild
@@ -1,3 +1 @@
-include include/uapi/asm-generic/Kbuild.asm
-
 generated-y += unistd_32.h
diff --git a/arch/arc/include/uapi/asm/Kbuild b/arch/arc/include/uapi/asm/Kbuild
index 0febf1a..755bb11 100644
--- a/arch/arc/include/uapi/asm/Kbuild
+++ b/arch/arc/include/uapi/asm/Kbuild
@@ -1,4 +1,2 @@
-include include/uapi/asm-generic/Kbuild.asm
-
 generic-y += kvm_para.h
 generic-y += ucontext.h
diff --git a/arch/arm/include/uapi/asm/Kbuild b/arch/arm/include/uapi/asm/Kbuild
index eee8f7d..23b4464 100644
--- a/arch/arm/include/uapi/asm/Kbuild
+++ b/arch/arm/include/uapi/asm/Kbuild
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd-common.h
 generated-y += unistd-oabi.h
diff --git a/arch/arm64/include/uapi/asm/Kbuild b/arch/arm64/include/uapi/asm/Kbuild
index 87eea29..602d137 100644
--- a/arch/arm64/include/uapi/asm/Kbuild
+++ b/arch/arm64/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
-include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += kvm_para.h
diff --git a/arch/c6x/include/uapi/asm/Kbuild b/arch/c6x/include/uapi/asm/Kbuild
index 0febf1a..755bb11 100644
--- a/arch/c6x/include/uapi/asm/Kbuild
+++ b/arch/c6x/include/uapi/asm/Kbuild
@@ -1,4 +1,2 @@
-include include/uapi/asm-generic/Kbuild.asm
-
 generic-y += kvm_para.h
 generic-y += ucontext.h
diff --git a/arch/csky/include/uapi/asm/Kbuild b/arch/csky/include/uapi/asm/Kbuild
index c1b06dc..1c72f04 100644
--- a/arch/csky/include/uapi/asm/Kbuild
+++ b/arch/csky/include/uapi/asm/Kbuild
@@ -1,3 +1 @@
-include include/uapi/asm-generic/Kbuild.asm
-
 generic-y += ucontext.h
diff --git a/arch/h8300/include/uapi/asm/Kbuild b/arch/h8300/include/uapi/asm/Kbuild
index 0febf1a..755bb11 100644
--- a/arch/h8300/include/uapi/asm/Kbuild
+++ b/arch/h8300/include/uapi/asm/Kbuild
@@ -1,4 +1,2 @@
-include include/uapi/asm-generic/Kbuild.asm
-
 generic-y += kvm_para.h
 generic-y += ucontext.h
diff --git a/arch/hexagon/include/uapi/asm/Kbuild b/arch/hexagon/include/uapi/asm/Kbuild
index c1b06dc..1c72f04 100644
--- a/arch/hexagon/include/uapi/asm/Kbuild
+++ b/arch/hexagon/include/uapi/asm/Kbuild
@@ -1,3 +1 @@
-include include/uapi/asm-generic/Kbuild.asm
-
 generic-y += ucontext.h
diff --git a/arch/ia64/include/uapi/asm/Kbuild b/arch/ia64/include/uapi/asm/Kbuild
index 5b819e5..20018cb 100644
--- a/arch/ia64/include/uapi/asm/Kbuild
+++ b/arch/ia64/include/uapi/asm/Kbuild
@@ -1,4 +1,2 @@
-include include/uapi/asm-generic/Kbuild.asm
-
 generated-y += unistd_64.h
 generic-y += kvm_para.h
diff --git a/arch/m68k/include/uapi/asm/Kbuild b/arch/m68k/include/uapi/asm/Kbuild
index 960bf1e..8a7ad40 100644
--- a/arch/m68k/include/uapi/asm/Kbuild
+++ b/arch/m68k/include/uapi/asm/Kbuild
@@ -1,4 +1,2 @@
-include include/uapi/asm-generic/Kbuild.asm
-
 generated-y += unistd_32.h
 generic-y += kvm_para.h
diff --git a/arch/microblaze/include/uapi/asm/Kbuild b/arch/microblaze/include/uapi/asm/Kbuild
index 97823ec..3ce84fb 100644
--- a/arch/microblaze/include/uapi/asm/Kbuild
+++ b/arch/microblaze/include/uapi/asm/Kbuild
@@ -1,5 +1,3 @@
-include include/uapi/asm-generic/Kbuild.asm
-
 generated-y += unistd_32.h
 generic-y += kvm_para.h
 generic-y += ucontext.h
diff --git a/arch/mips/include/uapi/asm/Kbuild b/arch/mips/include/uapi/asm/Kbuild
index 0851c10..c3798bf 100644
--- a/arch/mips/include/uapi/asm/Kbuild
+++ b/arch/mips/include/uapi/asm/Kbuild
@@ -1,5 +1,3 @@
-include include/uapi/asm-generic/Kbuild.asm
-
 generated-y += unistd_n32.h
 generated-y += unistd_n64.h
 generated-y += unistd_o32.h
diff --git a/arch/nds32/include/uapi/asm/Kbuild b/arch/nds32/include/uapi/asm/Kbuild
index c1b06dc..1c72f04 100644
--- a/arch/nds32/include/uapi/asm/Kbuild
+++ b/arch/nds32/include/uapi/asm/Kbuild
@@ -1,3 +1 @@
-include include/uapi/asm-generic/Kbuild.asm
-
 generic-y += ucontext.h
diff --git a/arch/nios2/include/uapi/asm/Kbuild b/arch/nios2/include/uapi/asm/Kbuild
index 0febf1a..755bb11 100644
--- a/arch/nios2/include/uapi/asm/Kbuild
+++ b/arch/nios2/include/uapi/asm/Kbuild
@@ -1,4 +1,2 @@
-include include/uapi/asm-generic/Kbuild.asm
-
 generic-y += kvm_para.h
 generic-y += ucontext.h
diff --git a/arch/openrisc/include/uapi/asm/Kbuild b/arch/openrisc/include/uapi/asm/Kbuild
index 0febf1a..755bb11 100644
--- a/arch/openrisc/include/uapi/asm/Kbuild
+++ b/arch/openrisc/include/uapi/asm/Kbuild
@@ -1,4 +1,2 @@
-include include/uapi/asm-generic/Kbuild.asm
-
 generic-y += kvm_para.h
 generic-y += ucontext.h
diff --git a/arch/parisc/include/uapi/asm/Kbuild b/arch/parisc/include/uapi/asm/Kbuild
index c54353d..22fdbd0 100644
--- a/arch/parisc/include/uapi/asm/Kbuild
+++ b/arch/parisc/include/uapi/asm/Kbuild
@@ -1,5 +1,3 @@
-include include/uapi/asm-generic/Kbuild.asm
-
 generated-y += unistd_32.h
 generated-y += unistd_64.h
 generic-y += kvm_para.h
diff --git a/arch/powerpc/include/uapi/asm/Kbuild b/arch/powerpc/include/uapi/asm/Kbuild
index 214a39a..2bd5b39 100644
--- a/arch/powerpc/include/uapi/asm/Kbuild
+++ b/arch/powerpc/include/uapi/asm/Kbuild
@@ -1,4 +1,2 @@
-include include/uapi/asm-generic/Kbuild.asm
-
 generated-y += unistd_32.h
 generated-y += unistd_64.h
diff --git a/arch/riscv/include/uapi/asm/Kbuild b/arch/riscv/include/uapi/asm/Kbuild
index d2ee86b..e69de29 100644
--- a/arch/riscv/include/uapi/asm/Kbuild
+++ b/arch/riscv/include/uapi/asm/Kbuild
@@ -1 +0,0 @@
-include include/uapi/asm-generic/Kbuild.asm
diff --git a/arch/s390/include/uapi/asm/Kbuild b/arch/s390/include/uapi/asm/Kbuild
index da3e0d4..46c1ff0 100644
--- a/arch/s390/include/uapi/asm/Kbuild
+++ b/arch/s390/include/uapi/asm/Kbuild
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_32.h
 generated-y += unistd_64.h
diff --git a/arch/sh/include/uapi/asm/Kbuild b/arch/sh/include/uapi/asm/Kbuild
index eaa30bc..ecfbd40 100644
--- a/arch/sh/include/uapi/asm/Kbuild
+++ b/arch/sh/include/uapi/asm/Kbuild
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_32.h
 generic-y += kvm_para.h
diff --git a/arch/sparc/include/uapi/asm/Kbuild b/arch/sparc/include/uapi/asm/Kbuild
index 214a39a..2bd5b39 100644
--- a/arch/sparc/include/uapi/asm/Kbuild
+++ b/arch/sparc/include/uapi/asm/Kbuild
@@ -1,4 +1,2 @@
-include include/uapi/asm-generic/Kbuild.asm
-
 generated-y += unistd_32.h
 generated-y += unistd_64.h
diff --git a/arch/unicore32/include/uapi/asm/Kbuild b/arch/unicore32/include/uapi/asm/Kbuild
index 0febf1a..755bb11 100644
--- a/arch/unicore32/include/uapi/asm/Kbuild
+++ b/arch/unicore32/include/uapi/asm/Kbuild
@@ -1,4 +1,2 @@
-include include/uapi/asm-generic/Kbuild.asm
-
 generic-y += kvm_para.h
 generic-y += ucontext.h
diff --git a/arch/x86/include/uapi/asm/Kbuild b/arch/x86/include/uapi/asm/Kbuild
index f6648e9..59b5ad3 100644
--- a/arch/x86/include/uapi/asm/Kbuild
+++ b/arch/x86/include/uapi/asm/Kbuild
@@ -1,5 +1,3 @@
-include include/uapi/asm-generic/Kbuild.asm
-
 generated-y += unistd_32.h
 generated-y += unistd_64.h
 generated-y += unistd_x32.h
diff --git a/arch/xtensa/include/uapi/asm/Kbuild b/arch/xtensa/include/uapi/asm/Kbuild
index 960bf1e..8a7ad40 100644
--- a/arch/xtensa/include/uapi/asm/Kbuild
+++ b/arch/xtensa/include/uapi/asm/Kbuild
@@ -1,4 +1,2 @@
-include include/uapi/asm-generic/Kbuild.asm
-
 generated-y += unistd_32.h
 generic-y += kvm_para.h
diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
new file mode 100644
index 0000000..6f4536d
--- /dev/null
+++ b/include/asm-generic/Kbuild
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# asm headers that all architectures except um should have
+# (This file is not included when SRCARCH=um since UML borrows several
+# asm headers from the host architecutre.)
diff --git a/include/uapi/asm-generic/Kbuild.asm b/include/uapi/asm-generic/Kbuild
similarity index 87%
rename from include/uapi/asm-generic/Kbuild.asm
rename to include/uapi/asm-generic/Kbuild
index 355c4ac..ebb180a 100644
--- a/include/uapi/asm-generic/Kbuild.asm
+++ b/include/uapi/asm-generic/Kbuild
@@ -1,6 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Headers that are mandatory in usr/include/asm/
-#
+# (This file is not included when SRCARCH=um since UML does not support UAPI.)
+
 mandatory-y += auxvec.h
 mandatory-y += bitsperlong.h
 mandatory-y += bpf_perf_event.h
diff --git a/scripts/Makefile.asm-generic b/scripts/Makefile.asm-generic
index c7d2b7a..82ad63d 100644
--- a/scripts/Makefile.asm-generic
+++ b/scripts/Makefile.asm-generic
@@ -12,6 +12,11 @@ all:
 src := $(subst /generated,,$(obj))
 -include $(src)/Kbuild
 
+# $(generic)/Kbuild lists mandatory-y. Exclude um since it is a special case.
+ifneq ($(SRCARCH),um)
+include $(generic)/Kbuild
+endif
+
 include scripts/Kbuild.include
 
 redundant := $(filter $(mandatory-y) $(generated-y), $(generic-y))
-- 
2.7.4
