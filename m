Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([192.83.249.54]:49728 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758726AbXGJDVy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jul 2007 23:21:54 -0400
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: [x86 setup 13/33] Header file to produce 16-bit code with gcc
Date: Mon,  9 Jul 2007 19:51:52 -0700
Message-Id: <11840373002601-git-send-email-hpa@zytor.com>
In-Reply-To: <11840371953778-git-send-email-hpa@zytor.com>
References: <11840359321823-git-send-email-hpa@zytor.com>
 <11840360383913-git-send-email-hpa@zytor.com>
 <11840361432207-git-send-email-hpa@zytor.com>
 <11840362483663-git-send-email-hpa@zytor.com>
 <11840363531039-git-send-email-hpa@zytor.com>
 <11840364593068-git-send-email-hpa@zytor.com>
 <1184036564610-git-send-email-hpa@zytor.com>
 <11840366692770-git-send-email-hpa@zytor.com>
 <11840367741994-git-send-email-hpa@zytor.com>
 <11840368791603-git-send-email-hpa@zytor.com>
 <11840369841576-git-send-email-hpa@zytor.com>
 <11840370903975-git-send-email-hpa@zytor.com>
 <11840371953778-git-send-email-hpa@zytor.com>
Message-Id: <96024b4c88d58a8473deb48a8038f6893b8b6b55.1184032749.git.hpa@zytor.com>
In-Reply-To: <2034f71d414def30de582fb59573295cadbdabb4.1184032748.git.hpa@zytor.com>
References: <2034f71d414def30de582fb59573295cadbdabb4.1184032748.git.hpa@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, andi@firstfloor.org, akpm@linux-foundation.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
List-ID: <linux-arch.vger.kernel.org>

From: H. Peter Anvin <hpa@zytor.com>

gcc for i386 can be used with the assembly prefix ".code16gcc" to generate
16-bit (real-mode) code.  This header file provides the assembly prefix.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>
---
 arch/i386/boot/code16gcc.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)
 create mode 100644 arch/i386/boot/code16gcc.h

diff --git a/arch/i386/boot/code16gcc.h b/arch/i386/boot/code16gcc.h
new file mode 100644
index 0000000..dbc6414
--- /dev/null
+++ b/arch/i386/boot/code16gcc.h
@@ -0,0 +1,9 @@
+/*
+ * code16gcc.h
+ *
+ * This file is -include'd when compiling 16-bit C code.
+ */
+
+#ifndef __ASSEMBLY__
+asm(".code16gcc");
+#endif
-- 
1.5.2.2

