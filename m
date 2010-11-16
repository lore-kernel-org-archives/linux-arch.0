Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38110 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014Ab0KPWmU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 16 Nov 2010 17:42:20 -0500
From: dirk.brandewie@gmail.com
Subject: [PATCH 3/5] x86/of:  Add building device tree blob(s) into image.
Date: Tue, 16 Nov 2010 14:41:38 -0800
Message-ID: <35263573f57fd7e780dede628cf489212bfa1400.1289943240.git.dirk.brandewie@gmail.com>
In-Reply-To: <cover.1289943240.git.dirk.brandewie@gmail.com>
References: <cover.1289943240.git.dirk.brandewie@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: devicetree-discuss@lists.ozlabs.org
Cc: sodaville@linutronix.de, arjan@linux.intel.com, dirk.brandewie@gmail.com, linuxppc-dev@lists.ozlabs.org, microblaze-uclinux@itee.uq.edu.au, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20101116224138.e7j2RtkBpnNKv5YRi4LBheVmY5c8wRyh98o0gozHH1Y@z>

From: Dirk Brandewie <dirk.brandewie@gmail.com>

This patch adds linking device tree blobs into vmlinux. DTB's are
added by adding the blob object name to list of objects to be linked
into the image.
e.g:
  obj-$(CONFIG_TEST_DTB) += test.dtb.o

The set of DTB linked into the image is controlled the Kconfig file
in arch/x86/kernel/dts/Kconfig

Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
---
 arch/x86/Kconfig            |    6 +++++-
 arch/x86/kernel/Makefile    |    6 ++++++
 arch/x86/kernel/dts/Kconfig |    7 +++++++
 3 files changed, 18 insertions(+), 1 deletions(-)
 create mode 100644 arch/x86/kernel/dts/Kconfig

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5904f38..f2f516a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -299,13 +299,17 @@ config X86_BIGSMP
 	---help---
 	  This option is needed for the systems that have more than 8 CPUs
 
-config X86_OF
+menuconfig X86_OF
 	bool "Support for device tree"
 	select OF
 	select OF_FLATTREE
 	---help---
 	  Device tree support on X86.
 
+if X86_OF
+source arch/x86/kernel/dts/Kconfig
+endif
+
 if X86_32
 config X86_EXTENDED_PLATFORM
 	bool "Support for extended (non-PC) x86 platforms"
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 586df14..49e017d 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -114,6 +114,12 @@ obj-$(CONFIG_SWIOTLB)			+= pci-swiotlb.o
 obj-$(CONFIG_X86_OF)			+= prom.o
 
 ###
+# device tree blobs
+obj-$(CONFIG_CE4100_DTB) += ce4100.dtb.o
+obj-$(CONFIG_TEST_DTB) += test.dtb.o
+
+
+###
 # 64 bit specific files
 ifeq ($(CONFIG_X86_64),y)
 	obj-$(CONFIG_AUDIT)		+= audit_64.o
diff --git a/arch/x86/kernel/dts/Kconfig b/arch/x86/kernel/dts/Kconfig
new file mode 100644
index 0000000..d3e5cd4
--- /dev/null
+++ b/arch/x86/kernel/dts/Kconfig
@@ -0,0 +1,7 @@
+config CE4100_DTB
+       bool "Intel CE4100"
+
+config TEST_DTB
+       bool "Test DTS"
+
+
-- 
1.7.2.3

