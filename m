From: Ley Foon Tan <lftan@altera.com>
Subject: [PATCH 07/25] cris: Add 32 bit time_t and clock_t
Date: Tue, 13 May 2014 17:10:46 +0800
Message-ID: <1399972246-5031-1-git-send-email-lftan@altera.com>
References: <1399971456-3941-1-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bn1bon0136.outbound.protection.outlook.com ([157.56.111.136]:21706
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759857AbaEMJK5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 13 May 2014 05:10:57 -0400
In-Reply-To: <1399971456-3941-1-git-send-email-lftan@altera.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com, cltang@codesourcery.com, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, linux-cris-kernel@axis.com

Override time_t and clock_t in include/uapi/asm-generic.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 arch/cris/include/uapi/asm/posix_types.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/cris/include/uapi/asm/posix_types.h b/arch/cris/include/uapi/asm/posix_types.h
index 0f22e6a..334499a 100644
--- a/arch/cris/include/uapi/asm/posix_types.h
+++ b/arch/cris/include/uapi/asm/posix_types.h
@@ -25,6 +25,12 @@ typedef unsigned short	__kernel_gid_t;
 typedef unsigned short	__kernel_old_dev_t;
 #define __kernel_old_dev_t __kernel_old_dev_t
 
+typedef long	__kernel_time_t;
+#define __kernel_time_t __kernel_time_t
+
+typedef long	__kernel_clock_t;
+#define __kernel_clock_t __kernel_clock_t
+
 #include <asm-generic/posix_types.h>
 
 #endif /* __ARCH_CRIS_POSIX_TYPES_H */
-- 
1.8.2.1
