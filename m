From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH] arch: x86: include: asm: need 'unsigned' type cast for atomic_clear_mask()
Date: Sat, 08 Jun 2013 14:30:13 +0800
Message-ID: <51B2CF75.1090207@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: the arch/x86 maintainers <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, shli@fusionio.com, "dhowells@redhat.com" <dhowells@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org


atomic_set_mask() has already have 'unsigned' type case, and
atomic_clear_mask() is the pair of atomic_set_mask().

So it also need 'unsigned' type case.


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/x86/include/asm/atomic.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/x86/include/asm/atomic.h b/arch/x86/include/asm/atomic.h
index 722aa3b..5b5cf52 100644
--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -255,7 +255,7 @@ static inline void atomic_or_long(unsigned long *v1, unsigned long v2)
 /* These are x86-specific, used by some header files */
 #define atomic_clear_mask(mask, addr)				\
 	asm volatile(LOCK_PREFIX "andl %0,%1"			\
-		     : : "r" (~(mask)), "m" (*(addr)) : "memory")
+		     : : "r" (~(unsigned)(mask)), "m" (*(addr)) : "memory")
 
 #define atomic_set_mask(mask, addr)				\
 	asm volatile(LOCK_PREFIX "orl %0,%1"			\
-- 
1.7.7.6
