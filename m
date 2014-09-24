Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:41636 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753465AbaIXRU3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 24 Sep 2014 13:20:29 -0400
From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH v3 12/17] powerpc: io: implement dummy relaxed accessor macros for writes
Date: Wed, 24 Sep 2014 18:17:31 +0100
Message-ID: <1411579056-16966-13-git-send-email-will.deacon@arm.com>
In-Reply-To: <1411579056-16966-1-git-send-email-will.deacon@arm.com>
References: <1411579056-16966-1-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, benh@kernel.crashing.org, chris@zankel.net, cmetcalf@tilera.com, davem@davemloft.net, deller@gmx.de, dhowells@redhat.com, geert@linux-m68k.org, heiko.carstens@de.ibm.com, hpa@zytor.com, jcmvbkbc@gmail.com, jesper.nilsson@axis.com, mingo@redhat.com, monstr@monstr.eu, paulmck@linux.vnet.ibm.com, rdunlap@infradead.org, sam@ravnborg.org, schwidefsky@de.ibm.com, starvik@axis.com, takata@linux-m32r.org, tglx@linutronix.de, tony.luck@intel.com, daniel.thompson@linaro.org, broonie@linaro.org, linux@arm.linux.org.uk, Will Deacon <will.deacon@arm.com>
Message-ID: <20140924171731.ClW8ml1pI537zHa85MD3ZRBpqkYnLGhPOgFBxg2b_vI@z>

write{b,w,l,q}_relaxed are implemented by some architectures in order to
permit memory-mapped I/O accesses with weaker barrier semantics than the
non-relaxed variants.

This patch adds dummy macros for the write accessors to powerpc, in the
same vein as the dummy definitions for the relaxed read accessors.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/powerpc/include/asm/io.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 97d3869991ca..9eaf301ac952 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -617,10 +617,14 @@ static inline void name at					\
 /*
  * We don't do relaxed operations yet, at least not with this semantic
  */
-#define readb_relaxed(addr) readb(addr)
-#define readw_relaxed(addr) readw(addr)
-#define readl_relaxed(addr) readl(addr)
-#define readq_relaxed(addr) readq(addr)
+#define readb_relaxed(addr)	readb(addr)
+#define readw_relaxed(addr)	readw(addr)
+#define readl_relaxed(addr)	readl(addr)
+#define readq_relaxed(addr)	readq(addr)
+#define writeb_relaxed(v, addr)	writeb(v, addr)
+#define writew_relaxed(v, addr)	writew(v, addr)
+#define writel_relaxed(v, addr)	writel(v, addr)
+#define writeq_relaxed(v, addr)	writeq(v, addr)
 
 #ifdef CONFIG_PPC32
 #define mmiowb()
-- 
2.1.0

