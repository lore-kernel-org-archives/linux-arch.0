Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:13049 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726344AbeJYK71 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Oct 2018 06:59:27 -0400
From: Nick Hu <nickhu@andestech.com>
Subject: [PATCH v4 1/4] nds32: Fix bug in bitfield.h
Date: Thu, 25 Oct 2018 10:24:14 +0800
Message-ID: <1e30cef737d040ad4cae7e80737354d370ce938e.1540430862.git.nickhu@andestech.com>
In-Reply-To: <cover.1540430861.git.nickhu@andestech.com>
References: <cover.1540430861.git.nickhu@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, will.deacon@arm.com, mark.rutland@arm.com, robh+dt@kernel.org, peterz@infradead.org, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, jolsa@redhat.com, namhyung@kernel.org, ebiederm@xmission.com, gregkh@linuxfoundation.org, kstewart@linuxfoundation.org, tglx@linutronix.de, pombredanne@nexb.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, zong@andestech.com, alankao@andestech.com, deanbo422@gmail.com
Cc: Nickhu <nickhu@andestech.com>, green.hu@gmail.com
Message-ID: <20181025022414.YkBhTvK3hZonXQgGRwYg-Jj-DxN_PsY1FmVDakgJx9s@z>

From: Nickhu <nickhu@andestech.com>

There two bitfield bug for perfomance counter
in bitfield.h:

	PFM_CTL_offSEL1		21 --> 16
	PFM_CTL_offSEL2		27 --> 22

This commit fix it.

Signed-off-by: Nickhu <nickhu@andestech.com>
---
 arch/nds32/include/asm/bitfield.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/nds32/include/asm/bitfield.h b/arch/nds32/include/asm/bitfield.h
index 8e84fc385b94..19b2841219ad 100644
--- a/arch/nds32/include/asm/bitfield.h
+++ b/arch/nds32/include/asm/bitfield.h
@@ -692,8 +692,8 @@
 #define PFM_CTL_offKU1		13	/* Enable user mode event counting for PFMC1 */
 #define PFM_CTL_offKU2		14	/* Enable user mode event counting for PFMC2 */
 #define PFM_CTL_offSEL0		15	/* The event selection for PFMC0 */
-#define PFM_CTL_offSEL1		21	/* The event selection for PFMC1 */
-#define PFM_CTL_offSEL2		27	/* The event selection for PFMC2 */
+#define PFM_CTL_offSEL1		16	/* The event selection for PFMC1 */
+#define PFM_CTL_offSEL2		22	/* The event selection for PFMC2 */
 /* bit 28:31 reserved */
 
 #define PFM_CTL_mskEN0		( 0x01  << PFM_CTL_offEN0 )
-- 
2.17.0
