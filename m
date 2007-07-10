Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:37852 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758386AbXGJQyl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Jul 2007 12:54:41 -0400
Date: Tue, 10 Jul 2007 10:54:40 -0600
From: Matthew Wilcox <matthew@wil.cx>
Subject: [PATCH] Only build PCI syscalls on architectures that want them
Message-ID: <20070710165440.GO9704@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


The PCI syscalls are built on every architecture except X86, but only
a few have ever hooked them up.  Use a new Kconfig symbol to save a
couple of kB on the architectures that have never used the syscalls.
Tested on x86 and ia64 only.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 79c6e5a..0565e29 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -327,6 +327,9 @@ config PCI_DOMAINS
 	bool
 	default y
 
+config PCI_SYSCALL
+	def_bool PCI
+
 config ALPHA_CORE_AGP
 	bool
 	depends on ALPHA_GENERIC || ALPHA_TITAN || ALPHA_MARVEL
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 50d9f3e..482d33f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -531,6 +531,9 @@ config PCI
 	  information about which PCI hardware does work under Linux and which
 	  doesn't.
 
+config PCI_SYSCALL
+	def_bool PCI
+
 # Select the host bridge type
 config PCI_HOST_VIA82C505
 	bool
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index de1bff6..db9ddff 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -520,8 +520,10 @@ config PCI
 	  here unless you are using a simulator without PCI support.
 
 config PCI_DOMAINS
-	bool
-	default PCI
+	def_bool PCI
+
+config PCI_SYSCALL
+	def_bool PCI
 
 source "drivers/pci/pcie/Kconfig"
 
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 5eaeafd..6beee32 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -698,8 +698,10 @@ config PCI
 	  infrastructure code to support PCI bus devices.
 
 config PCI_DOMAINS
-	bool
-	default PCI
+	def_bool PCI
+
+config PCI_SYSCALL
+	def_bool PCI
 
 config PCI_QSPAN
 	bool "QSpan PCI"
diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
index ccce2a4..6bdeeb7 100644
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -1237,8 +1237,10 @@ config PCI
 	  infrastructure code to support PCI bus devices.
 
 config PCI_DOMAINS
-	bool
-	default PCI
+	def_bool PCI
+
+config PCI_SYSCALL
+	def_bool PCI
 
 config MPC83xx_PCI2
 	bool "Support for 2nd PCI host controller"
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index fbcc00c..8567cc9 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -210,6 +210,9 @@ config PCI
 	  CP-1200, JavaEngine-1, Corona, Red October, and Serengeti SGSC.
 	  All of these platforms are extremely obscure, so say N if unsure.
 
+config PCI_SYSCALL
+	def_bool PCI
+
 source "drivers/pci/Kconfig"
 
 endif
diff --git a/arch/sparc64/Kconfig b/arch/sparc64/Kconfig
index 89a1b46..6566d13 100644
--- a/arch/sparc64/Kconfig
+++ b/arch/sparc64/Kconfig
@@ -320,8 +320,10 @@ config PCI
 	  doesn't.
 
 config PCI_DOMAINS
-	bool
-	default PCI
+	def_bool PCI
+
+config PCI_SYSCALL
+	def_bool PCI
 
 source "drivers/pci/Kconfig"
 
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index e3beb78..006054a 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -41,9 +41,7 @@ obj-$(CONFIG_ACPI)    += pci-acpi.o
 # Cardbus & CompactPCI use setup-bus
 obj-$(CONFIG_HOTPLUG) += setup-bus.o
 
-ifndef CONFIG_X86
-obj-y += syscall.o
-endif
+obj-$(CONFIG_PCI_SYSCALL) += syscall.o
 
 ifeq ($(CONFIG_PCI_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG

-- 
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
