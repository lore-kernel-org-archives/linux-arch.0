From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 5/5] kbuild: thin archives make default for all archs
Date: Fri,  9 Jun 2017 15:24:17 +1000
Message-ID: <20170609052417.561-6-npiggin@gmail.com>
References: <20170609052417.561-1-npiggin@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34896 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751499AbdFIFZM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Jun 2017 01:25:12 -0400
In-Reply-To: <20170609052417.561-1-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <mmarek@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>

Make thin archives build the default, but keep the config option
to allow exemptions if any breakage can't be quickly solved.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 Documentation/process/changes.rst | 9 ++++-----
 arch/Kconfig                      | 2 +-
 arch/powerpc/Kconfig              | 8 --------
 3 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index e25d63f8c0da..56fd0687bd4a 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -31,7 +31,7 @@ you probably needn't concern yourself with isdn4k-utils.
 ====================== ===============  ========================================
 GNU C                  3.2              gcc --version
 GNU make               3.81             make --version
-binutils               2.12             ld -v
+binutils               2.20             ld -v
 util-linux             2.10o            fdformat --version
 module-init-tools      0.9.10           depmod -V
 e2fsprogs              1.41.4           e2fsck -V
@@ -75,10 +75,9 @@ You will need GNU make 3.81 or later to build the kernel.
 Binutils
 --------
 
-Linux on IA-32 has recently switched from using ``as86`` to using ``gas`` for
-assembling the 16-bit boot code, removing the need for ``as86`` to compile
-your kernel.  This change does, however, mean that you need a recent
-release of binutils.
+The build system has recently switched to using thin archives (`ar T`) rather
+than incremental linking (`ld -r`) for built-in.o intermediate steps. This
+requires binutils 2.20 or newer.
 
 Perl
 ----
diff --git a/arch/Kconfig b/arch/Kconfig
index 6c00e5b00f8b..3abe581878d6 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -511,7 +511,7 @@ config CC_STACKPROTECTOR_STRONG
 endchoice
 
 config THIN_ARCHIVES
-	bool
+	def_bool y
 	help
 	  Select this if the architecture wants to use thin archives
 	  instead of ld -r to create the built-in.o files.
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index f7c8f9972f61..80d882a78426 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -472,14 +472,6 @@ config MPROFILE_KERNEL
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
