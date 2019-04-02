Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pegase1.c-s.fr ([93.17.236.30]:52499 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729924AbfDBJIp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Apr 2019 05:08:45 -0400
Message-ID: <f42400db206bcc94f99b38c7d7b2967bb7591bd2.1554195798.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1554195798.git.christophe.leroy@c-s.fr>
References: <cover.1554195798.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 8/9] Gives arches opportunity to use generically defined boot
 cmdline manipulation
Date: Tue,  2 Apr 2019 09:08:43 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, danielwa@cisco.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org
Message-ID: <20190402090843.U1nIoeV0Dg40TzUknKp2W23w1x7mcpQGz8QmvKtBGEI@z>

Most arches have similar boot command line manipulation options.
This patchs adds the definition in init/Kconfig, gated by
CONFIG_HAVE_CMDLINE that the arches can select to use them.

In order to use this, a few arches will have to change their
CONFIG options:
- riscv has to replace CMDLINE_FALLBACK by CMDLINE_FROM_BOOTLOADER
- arches using CONFIG_CMDLINE_OVERRIDE or CONFIG_CMDLINE_OVERWRITE
have to replace them by CONFIG_CMDLINE_FORCE

Arches also have to define CONFIG_DEFAULT_CMDLINE

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 init/Kconfig | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index 4592bf7997c0..83537603412c 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -80,6 +80,62 @@ config INIT_ENV_ARG_LIMIT
 	  Maximum of each of the number of arguments and environment
 	  variables passed to init from the kernel command line.
 
+config HAVE_CMDLINE
+	bool
+
+config CMDLINE_BOOL
+	bool "Default bootloader kernel arguments"
+	depends on HAVE_CMDLINE
+	help
+	  On some platforms, there is currently no way for the boot loader to
+	  pass arguments to the kernel. For these platforms, you can supply
+	  some command-line options at build time by entering them here.  In
+	  most cases you will need to specify the root device here.
+
+config CMDLINE
+	string "Initial kernel command string"
+	depends on CMDLINE_BOOL
+	default DEFAULT_CMDLINE
+	help
+	  On some platforms, there is currently no way for the boot loader to
+	  pass arguments to the kernel. For these platforms, you can supply
+	  some command-line options at build time by entering them here.  In
+	  most cases you will need to specify the root device here.
+
+choice
+	prompt "Kernel command line type" if CMDLINE != ""
+	default CMDLINE_FROM_BOOTLOADER
+	help
+	  Selects the way you want to use the default kernel arguments.
+
+config CMDLINE_FROM_BOOTLOADER
+	bool "Use bootloader kernel arguments if available"
+	help
+	  Uses the command-line options passed by the boot loader. If
+	  the boot loader doesn't provide any, the default kernel command
+	  string provided in CMDLINE will be used.
+
+config CMDLINE_EXTEND
+	bool "Extend bootloader kernel arguments"
+	help
+	  The default kernel command string will be appended to the
+	  command-line arguments provided during boot.
+
+config CMDLINE_PREPEND
+	bool "Prepend bootloader kernel arguments"
+	help
+	  The default kernel command string will be prepend to the
+	  command-line arguments provided during boot.
+
+config CMDLINE_FORCE
+	bool "Always use the default kernel command string"
+	help
+	  Always use the default kernel command string, even if the boot
+	  loader passes other arguments to the kernel.
+	  This is useful if you cannot or don't want to change the
+	  command-line options your boot loader passes to the kernel.
+endchoice
+
 config COMPILE_TEST
 	bool "Compile also drivers which will not load"
 	depends on !UML
-- 
2.13.3
