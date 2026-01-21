Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032594A1394
	for <linux-arch@vger.kernel.org>; Wed, 21 Jan 2026 14:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007497; cv=none; b=hSns6r50t2lwuEOyqhhzqhPD76EkuwlpFGNOiLKKNPClv39SeKMPEc86QqkuRv+mvysvpJ9a4vO7mBOZT5IGLLKPM47lhTWC9UAqPTWDOotBLswhnKo2OF7vZG1JLnsVfSSMuV0GOHwFMkecjh3oHaQt6qdjgBcBucKjjUJbc1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007497; c=relaxed/simple;
	bh=9z932AX2THRzZwBiCjTQT1xPsk/txnKGYIBFuNTbx7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IsFkF4jCeMnjf9VleqJNCJw1743hk2FSTM7UoKGbla94H0ksmEzQU9OTFzODDkNNemITajTBi0Tb4dmGR3aB5NEYEGeNLb0FNhEP/ng7xixnQkEAyGviMqxQmZylESguJmuWpOQdInCibQo+/+9up/NUfBSszvIBHgt6qkpmuj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=fsOrgJpJ; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="fsOrgJpJ"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1viZer-008XEU-M2; Wed, 21 Jan 2026 15:58:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=QBokfTpeY0lxQBhpa1t9vMqhCgqf0zlOgr8/cK4ZzTI=; b=fsOrgJpJ+OWxKof8tKg1CULuIU
	RiOlBCcNZdh/QGshYZWiOrLMlIzY0Yi28GgGtZ5EvEnDWfn8r5h5o6usvOuF82Mytsq+ji8XX536b
	c1P63guvEelUI6+NvfQufYMT/4CRVAf+AcUR1McKNKzQ+AUNbc+uXb7JCxMbIgwAmvgesXvspjLRC
	22pjGzx1Qli7bWJ2fXOvObf85SxzKAfoNoIjT0NsJmu4LivO4FNFVaps9GxeydToqc5gqrnPvrXi6
	q6fUrB1aVjNx3dpLi65AJlChUcdFBRSlMmh+CFXC/MpRRFJGoSvNq9p/rxcM09o//UigU6LoiqGs2
	DdtzJItA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1viZer-0006qe-8s; Wed, 21 Jan 2026 15:58:09 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1viZeY-00GH6h-KG; Wed, 21 Jan 2026 15:57:50 +0100
From: david.laight.linux@gmail.com
To: Nathan Chancellor <nathan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next 11/14] bit: Strengthen compile-time tests in GENMASK() and BIT()
Date: Wed, 21 Jan 2026 14:57:28 +0000
Message-Id: <20260121145731.3623-12-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260121145731.3623-1-david.laight.linux@gmail.com>
References: <20260121145731.3623-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

The current checks in GENMASK/BIT (eg reversed high/low) only work
for 'integer constant expressions' not 'compile-time constants'.
This is true for const_true() and -Wshift-count-overflow/negative.
While compile-time constants may be unusual, they can happen through
function inlining.

This isn't too bad with gcc, but if clang detects a negative/over-large
shift it treats it as 'undefined behaviour' and silently discards all
code that would use the result, so:
int f(u32 x) {int n = 32; return x >> n; }
generates a function that just contains a 'return' instruction.
If 'n' was a variable that happened to be 32, most modern cpu mask
the count - so would return 'x', some might return 0.

Add extra checks for arguments that pass __builtin_constant_p()
but are not 'integer constant expressions.
__builtin_choose_expr() isn't strong enough to allow
_Static_assert() or ({ ... }) in the other branch so non-standard
schemes are used to report the errors.

To reduce pre-processor bloat the checks are only enabled for W=c
(implied by W=1) builds (where they are errors).

Update the unit tests to match.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 include/linux/bits.h  | 45 +++++++++++++++++++++++++++++++++----------
 lib/tests/test_bits.c | 34 +++++++++++++++++++-------------
 2 files changed, 56 insertions(+), 23 deletions(-)

diff --git a/include/linux/bits.h b/include/linux/bits.h
index 43631a334314..0f559038981d 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -23,20 +23,35 @@
 #include <linux/compiler.h>
 #include <linux/overflow.h>
 
-#define GENMASK_INPUT_CHECK(h, l) BUILD_BUG_ON_ZERO(const_true((l) > (h)))
+#ifndef KBUILD_EXTRA_WARNc
+#define GENMASK_INPUT_CHECK(h, l, width) 0
+#else
+int GENMASK_INPUT_CHECK_FAIL(void) __compiletime_error("Invalid bit numbers");
+#define GENMASK_INPUT_CHECK(h, l, width)				\
+	(__builtin_choose_expr(__is_constexpr((l) > (h)),		\
+		sizeof(struct { char low_bit_greater_than_high[-((l) > (h))];}), \
+		__builtin_constant_p((l) | (h)) &&			\
+			((l) < 0 || (l) > (h) || (h) >= width) &&	\
+			GENMASK_INPUT_CHECK_FAIL()))
+#endif
 
 /*
- * Generate a mask for the specified type @t. Additional checks are made to
- * guarantee the value returned fits in that type, relying on
- * -Wshift-count-overflow compiler check to detect incompatible arguments.
+ * Generate a mask for the specified type @t.
+ * Checks are made to guarantee the value returned fits in that type.
+ * The compiler's -Wshift-count-overflow/negative check detects invalid values
+ * from 'constant integer expressions' but not other compile time constants.
+ * Clang treats out of value constants as 'undefined behaviour' and stops
+ * generating code - so explicit checks are needed.
+ * Neither BUILD_BUG() nor BUILD_BUG_ON_ZERO() can be used.
+ *
  * For example, all these create build errors or warnings:
  *
  * - GENMASK(15, 20): wrong argument order
  * - GENMASK(72, 15): doesn't fit unsigned long
  * - GENMASK_U32(33, 15): doesn't fit in a u32
  */
-#define GENMASK_TYPE(t, h, l)					\
-	((unsigned int)GENMASK_INPUT_CHECK(h, l) +		\
+#define GENMASK_TYPE(t, h, l)						\
+	((unsigned int)GENMASK_INPUT_CHECK(h, l, BITS_PER_TYPE(t)) +	\
 	 ((t)-1 << (l) & (t)-1 >> (BITS_PER_TYPE(t) - 1 - (h))))
 #endif
 
@@ -52,16 +67,26 @@
 #if !defined(__ASSEMBLY__)
 /*
  * Fixed-type variants of BIT(), with additional checks like GENMASK_TYPE().
- * The following examples generate compiler warnings from BIT_INPUT_CHECK().
+ * The following examples generate compiler errors from BIT_INPUT_CHECK().
  *
  * - BIT_U8(8)
  * - BIT_U32(-1)
  * - BIT_U32(40)
  */
-#define BIT_INPUT_CHECK(type, nr) \
-	BUILD_BUG_ON_ZERO(const_true((nr) >= BITS_PER_TYPE(type)))
 
-#define BIT_TYPE(type, nr) ((unsigned int)BIT_INPUT_CHECK(type, nr) + ((type)1 << (nr)))
+#ifndef KBUILD_EXTRA_WARNc
+#define BIT_INPUT_CHECK(nr, width) 0
+#else
+int BIT_INPUT_CHECK_FAIL(void) __compiletime_error("Bit number out of range");
+#define BIT_INPUT_CHECK(nr, width)						\
+	(__builtin_choose_expr(__is_constexpr(nr),				\
+		sizeof(struct { char bit_number_too_big[-((nr) >= (width))];}),	\
+		__builtin_constant_p(nr) && ((nr) < 0 || (nr) >= width) &&	\
+			BIT_INPUT_CHECK_FAIL()))
+#endif
+
+#define BIT_TYPE(type, nr) \
+	((unsigned int)BIT_INPUT_CHECK(+(nr), BITS_PER_TYPE(type)) + ((type)1 << (nr)))
 #endif /* defined(__ASSEMBLY__) */
 
 #define BIT_U8(nr)	BIT_TYPE(u8, nr)
diff --git a/lib/tests/test_bits.c b/lib/tests/test_bits.c
index 55be8230f9e7..36eb4661e78b 100644
--- a/lib/tests/test_bits.c
+++ b/lib/tests/test_bits.c
@@ -3,6 +3,8 @@
  * Test cases for functions and macros in bits.h
  */
 
+#define KBUILD_EXTRA_WARNc 1
+
 #include <kunit/test.h>
 #include <linux/bits.h>
 #include <linux/types.h>
@@ -118,24 +120,30 @@ static void genmask_u128_test(struct kunit *test)
 
 static void genmask_input_check_test(struct kunit *test)
 {
-	unsigned int x, y;
-	int z, w;
+	unsigned int x = 1, y = 2;
+	int z = 1, w = 2;
+
+	OPTIMIZER_HIDE_VAR(x);
+	OPTIMIZER_HIDE_VAR(y);
+	OPTIMIZER_HIDE_VAR(z);
+	OPTIMIZER_HIDE_VAR(w);
 
 	/* Unknown input */
-	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(x, 0));
-	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(0, x));
-	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(x, y));
+	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(x, 0, 32));
+	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(0, x, 32));
+	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(x, y, 32));
 
-	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(z, 0));
-	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(0, z));
-	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(z, w));
+	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(z, 0, 32));
+	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(0, z, 32));
+	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(z, w, 32));
 
 	/* Valid input */
-	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(1, 1));
-	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(39, 21));
-	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(100, 80));
-	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(110, 65));
-	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(127, 0));
+	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(1, 1, 32));
+	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(39, 21, 64));
+
+	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(100, 80, 128));
+	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(110, 65, 128));
+	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(127, 0, 128));
 }
 
 
-- 
2.39.5

