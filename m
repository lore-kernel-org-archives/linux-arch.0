Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bn1bon0131.outbound.protection.outlook.com ([157.56.111.131]:59690
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932693AbaEMJGs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 13 May 2014 05:06:48 -0400
From: Ley Foon Tan <lftan@altera.com>
Subject: [PATCH 22/25] sparc: Add 32 bit time_t and clock_t
Date: Tue, 13 May 2014 17:06:37 +0800
Message-ID: <1399971997-4781-1-git-send-email-lftan@altera.com>
In-Reply-To: <1399971456-3941-1-git-send-email-lftan@altera.com>
References: <1399971456-3941-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com, cltang@codesourcery.com, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Message-ID: <20140513090637.AYrlndBTDKR9zsdFRVT5vlsrk1aqKWUdKG4oKKj4bz4@z>

Override time_t and clock_t in include/uapi/asm-generic.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 arch/sparc/include/uapi/asm/posix_types.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/sparc/include/uapi/asm/posix_types.h b/arch/sparc/include/uapi/asm/posix_types.h
index 156220e..c5eaaef 100644
--- a/arch/sparc/include/uapi/asm/posix_types.h
+++ b/arch/sparc/include/uapi/asm/posix_types.h
@@ -42,6 +42,12 @@ typedef long                   __kernel_daddr_t;
 typedef unsigned short	       __kernel_old_dev_t;
 #define __kernel_old_dev_t __kernel_old_dev_t
 
+typedef long	__kernel_time_t;
+#define __kernel_time_t __kernel_time_t
+
+typedef long	__kernel_clock_t;
+#define __kernel_clock_t __kernel_clock_t
+
 #endif /* defined(__sparc__) && defined(__arch64__) */
 
 #include <asm-generic/posix_types.h>
-- 
1.8.2.1

