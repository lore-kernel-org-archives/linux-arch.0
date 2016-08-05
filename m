From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 4/5] powerpc: switch to using thin archives
Date: Fri,  5 Aug 2016 22:12:02 +1000
Message-ID: <1470399123-8455-5-git-send-email-npiggin@gmail.com>
References: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: linux-kbuild@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>, Segher Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>
List-Id: linux-arch.vger.kernel.org

From: Stephen Rothwell <sfr@canb.auug.org.au>

Some change to the way we invoke ar is required so it can be used
by scripts/link-vmlinux.sh

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/Makefile                  | 6 ++++--
 arch/powerpc/platforms/Kconfig.cputype | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 709a22a..160837c 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -23,7 +23,8 @@ CROSS32AR		:= $(CROSS32_COMPILE)ar
 ifeq ($(HAS_BIARCH),y)
 ifeq ($(CROSS32_COMPILE),)
 CROSS32CC	:= $(CC) -m32
-CROSS32AR	:= GNUTARGET=elf32-powerpc $(AR)
+CROSS32AR	:= $(AR)
+KBUILD_ARFLAGS	+= --target elf32-powerpc
 endif
 endif
 
@@ -93,7 +94,8 @@ ifeq ($(HAS_BIARCH),y)
 override AS	+= -a$(CONFIG_WORD_SIZE)
 override LD	+= -m elf$(CONFIG_WORD_SIZE)$(LDEMULATION)
 override CC	+= -m$(CONFIG_WORD_SIZE)
-override AR	:= GNUTARGET=elf$(CONFIG_WORD_SIZE)-$(GNUTARGET) $(AR)
+override AR	:= $(AR)
+KBUILD_ARFLAGS	+= --target elf$(CONFIG_WORD_SIZE)-$(GNUTARGET)
 endif
 
 LDFLAGS_vmlinux-y := -Bstatic
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 77e9b8d..3c77091 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -2,6 +2,7 @@ config PPC64
 	bool "64-bit kernel"
 	default n
 	select HAVE_VIRT_CPU_ACCOUNTING
+	select THIN_ARCHIVES
 	select ZLIB_DEFLATE
 	help
 	  This option selects whether a 32-bit or a 64-bit kernel
-- 
2.8.1

