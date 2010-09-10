From: David Howells <dhowells@redhat.com>
Subject: [PATCH 08/17] MIPS: TX49xx: rename ARCH_KMALLOC_MINALIGN to
	ARCH_DMA_MINALIGN
Date: Fri, 10 Sep 2010 17:24:48 +0100
Message-ID: <20100910162448.20817.26804.stgit@warthog.procyon.org.uk>
References: <20100910162407.20817.34359.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100910162407.20817.34359.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, Atsushi Nemoto <anemo@mba.ocn.ne.jp>
List-Id: linux-arch.vger.kernel.org

From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>

Architectures need to set ARCH_DMA_MINALIGN to the minimum DMA
alignment (the commit
a6eb9fe105d5de0053b261148cee56c94b4720ca). Defining
ARCH_KMALLOC_MINALIGN doesn't work anymore.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Acked-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---

 arch/mips/include/asm/mach-tx49xx/kmalloc.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/mach-tx49xx/kmalloc.h b/arch/mips/include/asm/mach-tx49xx/kmalloc.h
index b74caf6..ff9a8b8 100644
--- a/arch/mips/include/asm/mach-tx49xx/kmalloc.h
+++ b/arch/mips/include/asm/mach-tx49xx/kmalloc.h
@@ -1,6 +1,6 @@
 #ifndef __ASM_MACH_TX49XX_KMALLOC_H
 #define __ASM_MACH_TX49XX_KMALLOC_H
 
-#define ARCH_KMALLOC_MINALIGN	L1_CACHE_BYTES
+#define ARCH_DMA_MINALIGN L1_CACHE_BYTES
 
 #endif /* __ASM_MACH_TX49XX_KMALLOC_H */
