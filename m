From: David Howells <dhowells@redhat.com>
Subject: [PATCH 01/13] Make the x86 bitops like test_bit() return bool
Date: Wed, 29 Apr 2015 20:21:40 +0100
Message-ID: <20150429192140.24909.56052.stgit@warthog.procyon.org.uk>
References: <20150429192133.24909.43184.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150429192133.24909.43184.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Make the x86 bitop functions like test_bit() return bool rather than an
integer.  This permits gcc-5 to make better choices and can reduce the code
size overall and allows some warnings to be evaded.
---

 arch/x86/include/asm/bitops.h |   28 ++++++++++++++--------------
 arch/x86/include/asm/rmwcc.h  |    4 ++--
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index cfe3b954d5e4..7bbcce00b43d 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -201,7 +201,7 @@ static inline void change_bit(long nr, volatile unsigned long *addr)
  * This operation is atomic and cannot be reordered.
  * It also implies a memory barrier.
  */
-static inline int test_and_set_bit(long nr, volatile unsigned long *addr)
+static inline bool test_and_set_bit(long nr, volatile unsigned long *addr)
 {
 	GEN_BINARY_RMWcc(LOCK_PREFIX "bts", *addr, "Ir", nr, "%0", "c");
 }
@@ -213,7 +213,7 @@ static inline int test_and_set_bit(long nr, volatile unsigned long *addr)
  *
  * This is the same as test_and_set_bit on x86.
  */
-static __always_inline int
+static __always_inline bool
 test_and_set_bit_lock(long nr, volatile unsigned long *addr)
 {
 	return test_and_set_bit(nr, addr);
@@ -228,7 +228,7 @@ test_and_set_bit_lock(long nr, volatile unsigned long *addr)
  * If two examples of this operation race, one can appear to succeed
  * but actually fail.  You must protect multiple accesses with a lock.
  */
-static inline int __test_and_set_bit(long nr, volatile unsigned long *addr)
+static inline bool __test_and_set_bit(long nr, volatile unsigned long *addr)
 {
 	int oldbit;
 
@@ -236,7 +236,7 @@ static inline int __test_and_set_bit(long nr, volatile unsigned long *addr)
 	    "sbb %0,%0"
 	    : "=r" (oldbit), ADDR
 	    : "Ir" (nr));
-	return oldbit;
+	return oldbit != 0;
 }
 
 /**
@@ -247,7 +247,7 @@ static inline int __test_and_set_bit(long nr, volatile unsigned long *addr)
  * This operation is atomic and cannot be reordered.
  * It also implies a memory barrier.
  */
-static inline int test_and_clear_bit(long nr, volatile unsigned long *addr)
+static inline bool test_and_clear_bit(long nr, volatile unsigned long *addr)
 {
 	GEN_BINARY_RMWcc(LOCK_PREFIX "btr", *addr, "Ir", nr, "%0", "c");
 }
@@ -268,7 +268,7 @@ static inline int test_and_clear_bit(long nr, volatile unsigned long *addr)
  * accessed from a hypervisor on the same CPU if running in a VM: don't change
  * this without also updating arch/x86/kernel/kvm.c
  */
-static inline int __test_and_clear_bit(long nr, volatile unsigned long *addr)
+static inline bool __test_and_clear_bit(long nr, volatile unsigned long *addr)
 {
 	int oldbit;
 
@@ -276,11 +276,11 @@ static inline int __test_and_clear_bit(long nr, volatile unsigned long *addr)
 		     "sbb %0,%0"
 		     : "=r" (oldbit), ADDR
 		     : "Ir" (nr));
-	return oldbit;
+	return oldbit != 0;
 }
 
 /* WARNING: non atomic and it can be reordered! */
-static inline int __test_and_change_bit(long nr, volatile unsigned long *addr)
+static inline bool __test_and_change_bit(long nr, volatile unsigned long *addr)
 {
 	int oldbit;
 
@@ -289,7 +289,7 @@ static inline int __test_and_change_bit(long nr, volatile unsigned long *addr)
 		     : "=r" (oldbit), ADDR
 		     : "Ir" (nr) : "memory");
 
-	return oldbit;
+	return oldbit != 0;
 }
 
 /**
@@ -300,18 +300,18 @@ static inline int __test_and_change_bit(long nr, volatile unsigned long *addr)
  * This operation is atomic and cannot be reordered.
  * It also implies a memory barrier.
  */
-static inline int test_and_change_bit(long nr, volatile unsigned long *addr)
+static inline bool test_and_change_bit(long nr, volatile unsigned long *addr)
 {
 	GEN_BINARY_RMWcc(LOCK_PREFIX "btc", *addr, "Ir", nr, "%0", "c");
 }
 
-static __always_inline int constant_test_bit(long nr, const volatile unsigned long *addr)
+static __always_inline bool constant_test_bit(long nr, const volatile unsigned long *addr)
 {
 	return ((1UL << (nr & (BITS_PER_LONG-1))) &
 		(addr[nr >> _BITOPS_LONG_SHIFT])) != 0;
 }
 
-static inline int variable_test_bit(long nr, volatile const unsigned long *addr)
+static inline bool variable_test_bit(long nr, volatile const unsigned long *addr)
 {
 	int oldbit;
 
@@ -320,7 +320,7 @@ static inline int variable_test_bit(long nr, volatile const unsigned long *addr)
 		     : "=r" (oldbit)
 		     : "m" (*(unsigned long *)addr), "Ir" (nr));
 
-	return oldbit;
+	return oldbit != 0;
 }
 
 #if 0 /* Fool kernel-doc since it doesn't do macros yet */
@@ -329,7 +329,7 @@ static inline int variable_test_bit(long nr, volatile const unsigned long *addr)
  * @nr: bit number to test
  * @addr: Address to start counting from
  */
-static int test_bit(int nr, const volatile unsigned long *addr);
+static bool test_bit(int nr, const volatile unsigned long *addr);
 #endif
 
 #define test_bit(nr, addr)			\
diff --git a/arch/x86/include/asm/rmwcc.h b/arch/x86/include/asm/rmwcc.h
index 8f7866a5b9a4..a712ef68541f 100644
--- a/arch/x86/include/asm/rmwcc.h
+++ b/arch/x86/include/asm/rmwcc.h
@@ -8,9 +8,9 @@ do {									\
 	asm_volatile_goto (fullop "; j" cc " %l[cc_label]"		\
 			: : "m" (var), ## __VA_ARGS__ 			\
 			: "memory" : cc_label);				\
-	return 0;							\
+	return false;							\
 cc_label:								\
-	return 1;							\
+	return true;							\
 } while (0)
 
 #define GEN_UNARY_RMWcc(op, var, arg0, cc) 				\
