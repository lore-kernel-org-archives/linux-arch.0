From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v2 15/15] Add ELF machine
Date: Wed, 28 Jan 2015 22:32:09 +0900
Message-ID: <13c41c2a2ff85ca58255a12188fc203b0afe1dfa.1422429854.git.ysato@users.sourceforge.jp>
References: <cover.1422429854.git.ysato@users.sourceforge.jp>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail1.asahi-net.or.jp ([202.224.39.197]:18971 "EHLO
	mail1.asahi-net.or.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761302AbbA1UjP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jan 2015 15:39:15 -0500
In-Reply-To: <cover.1422429854.git.ysato@users.sourceforge.jp>
In-Reply-To: <cover.1422429854.git.ysato@users.sourceforge.jp>
References: <cover.1422429854.git.ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

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
2.1.3
