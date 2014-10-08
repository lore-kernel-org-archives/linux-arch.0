Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bl2on0056.outbound.protection.outlook.com ([65.55.169.56]:5504
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755851AbaJHJcN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 8 Oct 2014 05:32:13 -0400
From: Ley Foon Tan <lftan@altera.com>
Subject: [PATCH v4 28/29] Documentation: Add documentation for Nios2 architecture
Date: Wed, 8 Oct 2014 17:29:54 +0800
Message-ID: <1412760595-3935-29-git-send-email-lftan@altera.com>
In-Reply-To: <1412760595-3935-1-git-send-email-lftan@altera.com>
References: <1412760595-3935-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com, cltang@codesourcery.com
Message-ID: <20141008092954.FZzqQN-A66jnV739UooEfSdoEFxOFhkU_G-rOemyMCc@z>

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 Documentation/nios2/README |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/nios2/README

diff --git a/Documentation/nios2/README b/Documentation/nios2/README
new file mode 100644
index 0000000..054a67d
--- /dev/null
+++ b/Documentation/nios2/README
@@ -0,0 +1,23 @@
+Linux on the Nios II architecture
+=================================
+
+This is a port of Linux to Nios II (nios2) processor.
+
+In order to compile for Nios II, you need a version of GCC with support for the generic
+system call ABI. Please see this link for more information on how compiling and booting
+software for the Nios II platform:
+http://www.rocketboards.org/foswiki/Documentation/NiosIILinuxUserManual
+
+For reference, please see the following link:
+http://www.altera.com/literature/lit-nio2.jsp
+
+What is Nios II?
+================
+Nios II is a 32-bit embedded-processor architecture designed specifically for the
+Altera family of FPGAs. In order to support Linux, Nios II needs to be configured
+with MMU and hardware multiplier enabled.
+
+Nios II ABI
+===========
+Please refer to chapter "Application Binary Interface" in Nios II Processor Reference
+Handbook.
-- 
1.7.7.4

