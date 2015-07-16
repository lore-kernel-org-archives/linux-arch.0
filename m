From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 28/28] atomic: Add simple atomic_t tests
Date: Thu, 16 Jul 2015 19:21:38 +0200
Message-ID: <20150716172926.664516239@infradead.org>
References: <20150716172110.587529075@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=peterz-atomic-test.patch
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, will.deacon@arm.com, hskinnemoen@gmail.com, realmz6@gmail.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, heiko.carstens@de.ibm.com, davem@davemloft.net, cmetcalf@ezchip.com, ysato@users.sourceforge.jp, mingo@kernel.org, peterz@infradead.org
List-Id: linux-arch.vger.kernel.org

Add a few atomic_t tests, gets some compile coverage for the new
operations.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 lib/atomic64_test.c |   69 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 48 insertions(+), 21 deletions(-)

--- a/lib/atomic64_test.c
+++ b/lib/atomic64_test.c
@@ -16,8 +16,39 @@
 #include <linux/kernel.h>
 #include <linux/atomic.h>
 
+#define TEST(bit, op, c_op, val)				\
+do {								\
+	atomic##bit##_set(&v, v0);				\
+	r = v0;							\
+	atomic##bit##_##op(val, &v);				\
+	r c_op val;						\
+	WARN(atomic##bit##_read(&v) != r, "%Lx != %Lx\n",	\
+		(unsigned long long)atomic##bit##_read(&v),	\
+		(unsigned long long)r);				\
+} while (0)
+
+static __init void test_atomic(void)
+{
+	int v0 = 0xaaa31337;
+	int v1 = 0xdeadbeef;
+	int onestwos = 0x11112222;
+	int one = 1;
+
+	atomic_t v;
+	int r;
+
+	TEST(, add, +=, onestwos);
+	TEST(, add, +=, -one);
+	TEST(, sub, -=, onestwos);
+	TEST(, sub, -=, -one);
+	TEST(, or, |=, v1);
+	TEST(, and, &=, v1);
+	TEST(, xor, ^=, v1);
+	TEST(, andnot, &= ~, v1);
+}
+
 #define INIT(c) do { atomic64_set(&v, c); r = c; } while (0)
-static __init int test_atomic64(void)
+static __init void test_atomic64(void)
 {
 	long long v0 = 0xaaa31337c001d00dLL;
 	long long v1 = 0xdeadbeefdeafcafeLL;
@@ -34,15 +66,14 @@ static __init int test_atomic64(void)
 	BUG_ON(v.counter != r);
 	BUG_ON(atomic64_read(&v) != r);
 
-	INIT(v0);
-	atomic64_add(onestwos, &v);
-	r += onestwos;
-	BUG_ON(v.counter != r);
-
-	INIT(v0);
-	atomic64_add(-one, &v);
-	r += -one;
-	BUG_ON(v.counter != r);
+	TEST(64, add, +=, onestwos);
+	TEST(64, add, +=, -one);
+	TEST(64, sub, -=, onestwos);
+	TEST(64, sub, -=, -one);
+	TEST(64, or, |=, v1);
+	TEST(64, and, &=, v1);
+	TEST(64, xor, ^=, v1);
+	TEST(64, andnot, &= ~, v1);
 
 	INIT(v0);
 	r += onestwos;
@@ -55,16 +86,6 @@ static __init int test_atomic64(void)
 	BUG_ON(v.counter != r);
 
 	INIT(v0);
-	atomic64_sub(onestwos, &v);
-	r -= onestwos;
-	BUG_ON(v.counter != r);
-
-	INIT(v0);
-	atomic64_sub(-one, &v);
-	r -= -one;
-	BUG_ON(v.counter != r);
-
-	INIT(v0);
 	r -= onestwos;
 	BUG_ON(atomic64_sub_return(onestwos, &v) != r);
 	BUG_ON(v.counter != r);
@@ -147,6 +168,12 @@ static __init int test_atomic64(void)
 	BUG_ON(!atomic64_inc_not_zero(&v));
 	r += one;
 	BUG_ON(v.counter != r);
+}
+
+static __init int test_atomics(void)
+{
+	test_atomic();
+	test_atomic64();
 
 #ifdef CONFIG_X86
 	pr_info("passed for %s platform %s CX8 and %s SSE\n",
@@ -166,4 +193,4 @@ static __init int test_atomic64(void)
 	return 0;
 }
 
-core_initcall(test_atomic64);
+core_initcall(test_atomics);
