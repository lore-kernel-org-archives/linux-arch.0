Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-by2lp0239.outbound.protection.outlook.com ([207.46.163.239]:16394
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932452AbaGOIsq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 15 Jul 2014 04:48:46 -0400
From: Ley Foon Tan <lftan@altera.com>
Subject: [PATCH v2 28/29] Documentation: Add documentation for Nios2 architecture
Date: Tue, 15 Jul 2014 16:45:55 +0800
Message-ID: <1405413956-2772-29-git-send-email-lftan@altera.com>
In-Reply-To: <1405413956-2772-1-git-send-email-lftan@altera.com>
References: <1405413956-2772-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com, cltang@codesourcery.com
Message-ID: <20140715084555.6Ilq0DD8_a261__J_7WpFZjr_wAfRlXmn8i2mcl_Hig@z>

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 Documentation/nios2/README | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)
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
1.8.2.1

