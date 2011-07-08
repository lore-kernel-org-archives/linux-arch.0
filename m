From: David Howells <dhowells@redhat.com>
Subject: [PATCH [ver #2] 06/39] UAPI: Differentiate userspace build and
 kernelspace build include path sets
Date: Fri, 08 Jul 2011 15:23:54 +0100
Message-ID: <20110708142353.31344.79919.stgit@warthog.procyon.org.uk>
References: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:3945 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750959Ab1GHOYh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 8 Jul 2011 10:24:37 -0400
In-Reply-To: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: rdunlap@xenotime.net, hpa@kernel.org, matthew@wil.cx, linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, ralf@linux-mips.org

Differentiate userspace build and kernelspace build (LINUXINCLUDE) include path
sets by adding a new make variable (USERINCLUDE) that has everything barring
the kernel-specific include paths, and then make LINUXINCLUDE simply preface
that with the kernel-specific include paths.

Then use USERINCLUDE in building the x86 boot code.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Makefile                          |   12 ++++++++----
 arch/x86/boot/Makefile            |    4 ++--
 arch/x86/boot/mkcpustr.c          |    2 ++
 arch/x86/include/asm/cpufeature.h |    2 ++
 arch/x86/kernel/cpu/mkcapflags.pl |    5 ++++-
 5 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index b66bab5..0fe2209 100644
--- a/Makefile
+++ b/Makefile
@@ -355,16 +355,20 @@ AFLAGS_KERNEL	=
 CFLAGS_GCOV	= -fprofile-arcs -ftest-coverage
 
 
+# Use USERINCLUDE when you must reference the UAPI directories only.
+USERINCLUDE    := \
+		-I$(srctree)/arch/$(hdr-arch)/include/uapi \
+		-Iinclude/uapi \
+                   $(if $(KBUILD_SRC), -I$(srctree)/include) \
+                   -include include/generated/autoconf.h
+
 # Use LINUXINCLUDE when you must reference the include/ directory.
 # Needed to be compatible with the O= option
 LINUXINCLUDE    := \
 		-I$(srctree)/arch/$(hdr-arch)/include \
 		-Iarch/$(hdr-arch)/include/generated \
-		-I$(srctree)/arch/$(hdr-arch)/include/uapi \
 		-Iinclude \
-		-Iinclude/uapi \
-                   $(if $(KBUILD_SRC), -I$(srctree)/include) \
-                   -include include/generated/autoconf.h
+		$(USERINCLUDE)
 
 KBUILD_CPPFLAGS := -D__KERNEL__
 
diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index f7cb086..84592cf 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -43,7 +43,7 @@ setup-y		+= video-bios.o
 targets		+= $(setup-y)
 hostprogs-y	:= mkcpustr tools/build
 
-HOST_EXTRACFLAGS += $(LINUXINCLUDE)
+HOST_EXTRACFLAGS += $(USERINCLUDE)
 
 $(obj)/cpu.o: $(obj)/cpustr.h
 
@@ -57,7 +57,7 @@ $(obj)/cpustr.h: $(obj)/mkcpustr FORCE
 
 # How to compile the 16-bit code.  Note we always compile for -march=i386,
 # that way we can complain to the user if the CPU is insufficient.
-KBUILD_CFLAGS	:= $(LINUXINCLUDE) -g -Os -D_SETUP -D__KERNEL__ \
+KBUILD_CFLAGS	:= $(USERINCLUDE) -g -Os -D_SETUP -D__KERNEL__ \
 		   -DDISABLE_BRANCH_PROFILING \
 		   -Wall -Wstrict-prototypes \
 		   -march=i386 -mregparm=3 \
diff --git a/arch/x86/boot/mkcpustr.c b/arch/x86/boot/mkcpustr.c
index 919257f..4579eff 100644
--- a/arch/x86/boot/mkcpustr.c
+++ b/arch/x86/boot/mkcpustr.c
@@ -15,6 +15,8 @@
 
 #include <stdio.h>
 
+#include "../include/asm/required-features.h"
+#include "../include/asm/cpufeature.h"
 #include "../kernel/cpu/capflags.c"
 
 int main(void)
diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 71cc380..eba9354 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -4,7 +4,9 @@
 #ifndef _ASM_X86_CPUFEATURE_H
 #define _ASM_X86_CPUFEATURE_H
 
+#ifndef _ASM_X86_REQUIRED_FEATURES_H
 #include <asm/required-features.h>
+#endif
 
 #define NCAPINTS	10	/* N 32-bit words worth of info */
 
diff --git a/arch/x86/kernel/cpu/mkcapflags.pl b/arch/x86/kernel/cpu/mkcapflags.pl
index dfea390..6c3c4f1 100644
--- a/arch/x86/kernel/cpu/mkcapflags.pl
+++ b/arch/x86/kernel/cpu/mkcapflags.pl
@@ -8,7 +8,10 @@
 open(IN, "< $in\0")   or die "$0: cannot open: $in: $!\n";
 open(OUT, "> $out\0") or die "$0: cannot create: $out: $!\n";
 
-print OUT "#include <asm/cpufeature.h>\n\n";
+print OUT "#ifndef _ASM_X86_CPUFEATURE_H\n";
+print OUT "#include <asm/cpufeature.h>\n";
+print OUT "#endif\n";
+print OUT "\n";
 print OUT "const char * const x86_cap_flags[NCAPINTS*32] = {\n";
 
 while (defined($line = <IN>)) {
