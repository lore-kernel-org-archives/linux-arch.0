From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v6 15/16] Add ELF machine
Date: Mon,  9 Mar 2015 17:47:09 +0900
Message-ID: <1425890830-29399-16-git-send-email-ysato@users.sourceforge.jp>
References: <1425890830-29399-1-git-send-email-ysato@users.sourceforge.jp>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail1.asahi-net.or.jp ([202.224.39.197]:42988 "EHLO
	mail1.asahi-net.or.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753496AbbCIIrd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Mar 2015 04:47:33 -0400
In-Reply-To: <1425890830-29399-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 include/uapi/linux/elf-em.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/elf-em.h b/include/uapi/linux/elf-em.h
index ae99f77..b088296 100644
--- a/include/uapi/linux/elf-em.h
+++ b/include/uapi/linux/elf-em.h
@@ -25,6 +25,7 @@
 #define EM_ARM		40	/* ARM 32 bit */
 #define EM_SH		42	/* SuperH */
 #define EM_SPARCV9	43	/* SPARC v9 64-bit */
+#define EM_H8_300	46	/* Renesas H8/300 */
 #define EM_IA_64	50	/* HP/Intel IA-64 */
 #define EM_X86_64	62	/* AMD x86-64 */
 #define EM_S390		22	/* IBM S/390 */
-- 
2.1.4
