Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-by2on0123.outbound.protection.outlook.com ([207.46.100.123]:45785
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752759AbaEMJGV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 13 May 2014 05:06:21 -0400
From: Ley Foon Tan <lftan@altera.com>
Subject: [PATCH 17/25] parisc: Add 32 bit time_t and clock_t
Date: Tue, 13 May 2014 17:06:06 +0800
Message-ID: <1399971966-4598-1-git-send-email-lftan@altera.com>
In-Reply-To: <1399971456-3941-1-git-send-email-lftan@altera.com>
References: <1399971456-3941-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com, cltang@codesourcery.com, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
Message-ID: <20140513090606.VO341glje81_C9vzpQsnFeZa8FEAZSUYMz0dwpY_2m4@z>

Override time_t and clock_t in include/uapi/asm-generic.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 arch/parisc/include/uapi/asm/posix_types.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/parisc/include/uapi/asm/posix_types.h b/arch/parisc/include/uapi/asm/posix_types.h
index b934425..21fcf1c 100644
--- a/arch/parisc/include/uapi/asm/posix_types.h
+++ b/arch/parisc/include/uapi/asm/posix_types.h
@@ -19,6 +19,14 @@ typedef int			__kernel_suseconds_t;
 typedef long long		__kernel_off64_t;
 typedef unsigned long long	__kernel_ino64_t;
 
+#ifndef CONFIG_64BIT
+typedef long	__kernel_time_t;
+#define __kernel_time_t __kernel_time_t
+
+typedef long	__kernel_clock_t;
+#define __kernel_clock_t __kernel_clock_t
+#endif
+
 #include <asm-generic/posix_types.h>
 
 #endif
-- 
1.8.2.1

