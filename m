Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bl2on0097.outbound.protection.outlook.com ([65.55.169.97]:55774
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933603AbcDEWZg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 5 Apr 2016 18:25:36 -0400
From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH 08/25] arm64: ilp32: add documentation on the ILP32 ABI for ARM64
Date: Wed, 6 Apr 2016 01:08:30 +0300
Message-ID: <1459894127-17698-9-git-send-email-ynorov@caviumnetworks.com>
In-Reply-To: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ynorov@caviumnetworks.com, pinskia@gmail.com, Prasun.Kapoor@caviumnetworks.com, schwab@suse.de, Nathan_Lynch@mentor.com, agraf@suse.de, klimov.linux@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org
Message-ID: <20160405220830.gB03rfATLqNN_90CPG4wLtqN-wnbI-tG_R6_UMuS3G4@z>

Based on Andrew Pinski's patch-series.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 Documentation/arm64/ilp32.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 Documentation/arm64/ilp32.txt

diff --git a/Documentation/arm64/ilp32.txt b/Documentation/arm64/ilp32.txt
new file mode 100644
index 0000000..15b5c83
--- /dev/null
+++ b/Documentation/arm64/ilp32.txt
@@ -0,0 +1,13 @@
+ILP32 AARCH64 SYSCALL ABI
+=========================
+
+This document describes the ILP32 syscall ABI and where it differs
+from the generic compat linux syscall interface.
+
+Syscalls which normally would pass 64bit values as two arguments;
+now pass the 64bit value as one argument.
+
+struct rt_sigframe is redefined and contains struct compat_siginfo,
+as compat syscalls expects, and struct ilp32_sigframe, to handle
+AARCH64 register set and 32-bit userspace register representation.
+
-- 
2.5.0

