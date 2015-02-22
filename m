Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail2.asahi-net.or.jp ([202.224.39.198]:46754 "EHLO
	mail2.asahi-net.or.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752152AbbBVGZa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 22 Feb 2015 01:25:30 -0500
From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v5 15/15] Add ELF machine
Date: Sun, 22 Feb 2015 15:25:20 +0900
Message-ID: <1424586320-3144-16-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1424586320-3144-1-git-send-email-ysato@users.sourceforge.jp>
References: <1424586320-3144-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Message-ID: <20150222062520.Hccy5v4z3vTv5WGIaZhQurUQaKIx9GZFPJ15jvKkQ-o@z>

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

