From: tip-bot for Davidlohr Bueso <tipbot@zytor.com>
Subject: [tip:locking/core] locking/cmpxchg, arch: Remove tas()
  definitions
Date: Fri, 4 Dec 2015 04:01:18 -0800
Message-ID: <tip-fbd35c0d2fb41b75863a0e45fe939c8440375b0a@git.kernel.org>
References: <1445975631-17047-2-git-send-email-dave@stgolabs.net>
Reply-To: mingo@kernel.org, paulmck@linux.vnet.ibm.com,
	  akpm@linux-foundation.org, hpa@zytor.com, peterz@infradead.org,
	  dave@stgolabs.net, tglx@linutronix.de,
	  linux-kernel@vger.kernel.org, dbueso@suse.de,
	  torvalds@linux-foundation.org, realmz6@gmail.com,
	  a-jacquiot@ti.com, linux-arch@vger.kernel.org,
	  cmetcalf@ezchip.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445975631-17047-2-git-send-email-dave@stgolabs.net>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Cc: linux-arch@vger.kernel.org, cmetcalf@ezchip.com, realmz6@gmail.com, a-jacquiot@ti.com, linux-kernel@vger.kernel.org, dbueso@suse.de, torvalds@linux-foundation.org, tglx@linutronix.de, dave@stgolabs.net, hpa@zytor.com, peterz@infradead.org, paulmck@linux.vnet.ibm.com, akpm@linux-foundation.org, mingo@kernel.org
List-Id: linux-arch.vger.kernel.org

Commit-ID:  fbd35c0d2fb41b75863a0e45fe939c8440375b0a
Gitweb:     http://git.kernel.org/tip/fbd35c0d2fb41b75863a0e45fe939c8440375b0a
Author:     Davidlohr Bueso <dave@stgolabs.net>
AuthorDate: Tue, 27 Oct 2015 12:53:48 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 4 Dec 2015 11:39:51 +0100

locking/cmpxchg, arch: Remove tas() definitions

It seems that commit 5dc12ddee93 ("Remove tas()") missed some files.
Correct this and fully drop this macro, for which we should be using
cmpxchg() like calls.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <linux-arch@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Aurelien Jacquiot <a-jacquiot@ti.com>
Cc: Chris Metcalf <cmetcalf@ezchip.com>
Cc: David Howells <dhowells@re hat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Miao <realmz6@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dave@stgolabs.net
Link: http://lkml.kernel.org/r/1445975631-17047-2-git-send-email-dave@stgolabs.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/blackfin/include/asm/cmpxchg.h | 1 -
 arch/c6x/include/asm/cmpxchg.h      | 2 --
 arch/frv/include/asm/cmpxchg.h      | 2 --
 arch/tile/include/asm/cmpxchg.h     | 2 --
 4 files changed, 7 deletions(-)

diff --git a/arch/blackfin/include/asm/cmpxchg.h b/arch/blackfin/include/asm/cmpxchg.h
index c05868c..2539288 100644
--- a/arch/blackfin/include/asm/cmpxchg.h
+++ b/arch/blackfin/include/asm/cmpxchg.h
@@ -128,6 +128,5 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr,
 #endif /* !CONFIG_SMP */
 
 #define xchg(ptr, x) ((__typeof__(*(ptr)))__xchg((unsigned long)(x), (ptr), sizeof(*(ptr))))
-#define tas(ptr) ((void)xchg((ptr), 1))
 
 #endif /* __ARCH_BLACKFIN_CMPXCHG__ */
diff --git a/arch/c6x/include/asm/cmpxchg.h b/arch/c6x/include/asm/cmpxchg.h
index b27c8ce..93d0a5a 100644
--- a/arch/c6x/include/asm/cmpxchg.h
+++ b/arch/c6x/include/asm/cmpxchg.h
@@ -47,8 +47,6 @@ static inline unsigned int __xchg(unsigned int x, volatile void *ptr, int size)
 #define xchg(ptr, x) \
 	((__typeof__(*(ptr)))__xchg((unsigned int)(x), (void *) (ptr), \
 				    sizeof(*(ptr))))
-#define tas(ptr)    xchg((ptr), 1)
-
 
 #include <asm-generic/cmpxchg-local.h>
 
diff --git a/arch/frv/include/asm/cmpxchg.h b/arch/frv/include/asm/cmpxchg.h
index 5b04dd0..a899765 100644
--- a/arch/frv/include/asm/cmpxchg.h
+++ b/arch/frv/include/asm/cmpxchg.h
@@ -69,8 +69,6 @@ extern uint32_t __xchg_32(uint32_t i, volatile void *v);
 
 #endif
 
-#define tas(ptr) (xchg((ptr), 1))
-
 /*****************************************************************************/
 /*
  * compare and conditionally exchange value with memory
diff --git a/arch/tile/include/asm/cmpxchg.h b/arch/tile/include/asm/cmpxchg.h
index 0ccda3c..25d5899 100644
--- a/arch/tile/include/asm/cmpxchg.h
+++ b/arch/tile/include/asm/cmpxchg.h
@@ -127,8 +127,6 @@ long long _atomic64_cmpxchg(long long *v, long long o, long long n);
 
 #endif
 
-#define tas(ptr) xchg((ptr), 1)
-
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_TILE_CMPXCHG_H */
