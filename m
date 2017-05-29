From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH] kbuild: provide THIN_ARCHIVES option for all architectures
Date: Mon, 29 May 2017 18:11:03 +1000
Message-ID: <20170529081103.29999-1-npiggin@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35982 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750921AbdE2ILU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 May 2017 04:11:20 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kbuild@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>

Supporting two different intermediate-artifact packaging schemes
was only ever intended as a temporary transition.

This has so far caused no problems for powerpc, after a small fix
for how the arch invoked ar. So now allow any arch to select the
option, continue defaulting to N.

Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
The next step will be to have archs always select THIN_ARCHIVES
when they are known to work. Then remove the option entirely.

x86 has always just worked for me, so that should be easy.

 arch/Kconfig         | 19 ++++++++++++++++---
 arch/powerpc/Kconfig |  8 --------
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 6c00e5b00f8b..28e64cb65dd5 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -511,10 +511,23 @@ config CC_STACKPROTECTOR_STRONG
 endchoice
 
 config THIN_ARCHIVES
-	bool
+	bool "Build the kernel using thin archives"
+	default n
 	help
-	  Select this if the architecture wants to use thin archives
-	  instead of ld -r to create the built-in.o files.
+	  Enable this if you want to use thin archives (binutils `ar` thin
+	  archive format) rather than `ld -r`, to create the built-in.o and
+	  other intermediate packaging steps in the kernel build.
+
+	  This option reduces disk space for builds, especially important for
+	  debug builds and IO-constrained environments. It gives the linker
+	  more flexibility in assembling sections. And it is more amenable to
+	  link-time-optimization that may be implemented in future.
+
+	  The intention is for all architectures to move to thin archives
+	  soon, and the ld -r support code removed.
+
+	  If unsure, say N.
+	  Kernel hackers, say Y and test/fix your arch!
 
 config LD_DEAD_CODE_DATA_ELIMINATION
 	bool
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 6eb70c96ec5e..9274d9faf122 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -483,14 +483,6 @@ config MPROFILE_KERNEL
 	depends on PPC64 && CPU_LITTLE_ENDIAN
 	def_bool !DISABLE_MPROFILE_KERNEL
 
-config USE_THIN_ARCHIVES
-	bool "Build the kernel using thin archives"
-	default n
-	select THIN_ARCHIVES
-	help
-	  Build the kernel using thin archives.
-	  If you're unsure say N.
-
 config IOMMU_HELPER
 	def_bool PPC64
 
-- 
2.11.0
