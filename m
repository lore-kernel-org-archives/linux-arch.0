From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH v3 05/17] frv: io: implement dummy relaxed accessor macros for writes
Date: Wed, 24 Sep 2014 18:17:24 +0100
Message-ID: <1411579056-16966-6-git-send-email-will.deacon@arm.com>
References: <1411579056-16966-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1411579056-16966-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, benh@kernel.crashing.org, chris@zankel.net, cmetcalf@tilera.com, davem@davemloft.net, deller@gmx.de, dhowells@redhat.com, geert@linux-m68k.org, heiko.carstens@de.ibm.com, hpa@zytor.com, jcmvbkbc@gmail.com, jesper.nilsson@axis.com, mingo@redhat.com, monstr@monstr.eu, paulmck@linux.vnet.ibm.com, rdunlap@infradead.org, sam@ravnborg.org, schwidefsky@de.ibm.com, starvik@axis.com, takata@linux-m32r.org, tglx@linutronix.de, tony.luck@intel.com, daniel.thompson@linaro.org, broonie@linaro.org, linux@arm.linux.org.uk, Will Deacon <will.deacon@arm.com>
List-Id: linux-arch.vger.kernel.org

write{b,w,l}_relaxed are implemented by some architectures in order to
permit memory-mapped I/O accesses with weaker barrier semantics than the
non-relaxed variants.

This patch adds dummy macros for the write accessors to frv, in the same
vein as the dummy definitions for the relaxed read accessors.

Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/frv/include/asm/io.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/frv/include/asm/io.h b/arch/frv/include/asm/io.h
index 8cb50a2fbcb2..99bb7efaf9b7 100644
--- a/arch/frv/include/asm/io.h
+++ b/arch/frv/include/asm/io.h
@@ -243,6 +243,9 @@ static inline void writel(uint32_t datum, volatile void __iomem *addr)
 		__flush_PCI_writes();
 }
 
+#define writeb_relaxed writeb
+#define writew_relaxed writew
+#define writel_relaxed writel
 
 /* Values for nocacheflag and cmode */
 #define IOMAP_FULL_CACHING		0
-- 
2.1.0
