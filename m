From: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH v3 2/2] bits: Add tests of GENMASK
Date: Tue,  9 Jun 2020 00:18:23 +0200
Message-ID: <20200608221823.35799-2-rikard.falkeborn@gmail.com>
References: <20200608184222.GA899@rikard>
 <20200608221823.35799-1-rikard.falkeborn@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbgFHWSd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Jun 2020 18:18:33 -0400
In-Reply-To: <20200608221823.35799-1-rikard.falkeborn@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: rikard.falkeborn@gmail.com
Cc: akpm@linux-foundation.org, andy.shevchenko@gmail.com, arnd@arndb.de, emil.l.velikov@gmail.com, geert@linux-m68k.org, keescook@chromium.org, linus.walleij@linaro.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, lkp@intel.com, syednwaris@gmail.com, vilhelm.gray@gmail.com, yamada.masahiro@socionext.com

Add tests of GENMASK and GENMASK_ULL.

A few test cases that should fail compilation are provided
under #ifdef TEST_GENMASK_FAILURES

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
I did not move it to test_bitops.c, because I think it makes more sense
that test_bitops.c tests bitops.h and test_bits.c tests bits.h, but if
you disagree, I can move it.

v2-v3
Updated commit message and ifdef after suggestion fron Geert. Also fixed
a typo in the description of the file.

v1-v2
New patch.

 lib/Kconfig.debug | 11 +++++++
 lib/Makefile      |  1 +
 lib/test_bits.c   | 73 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+)
 create mode 100644 lib/test_bits.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 333e878d8af9..9557cb570fb9 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2182,6 +2182,17 @@ config LINEAR_RANGES_TEST
 
 	  If unsure, say N.
 
+config BITS_TEST
+	tristate "KUnit test for bits.h"
+	depends on KUNIT
+	help
+	  This builds the bits unit test.
+	  Tests the logic of macros defined in bits.h.
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 config TEST_UDELAY
 	tristate "udelay test driver"
 	help
diff --git a/lib/Makefile b/lib/Makefile
index 315516fa4ef4..2ce9892e3e63 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -314,3 +314,4 @@ obj-$(CONFIG_OBJAGG) += objagg.o
 # KUnit tests
 obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
 obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
+obj-$(CONFIG_BITS_TEST) += test_bits.o
diff --git a/lib/test_bits.c b/lib/test_bits.c
new file mode 100644
index 000000000000..e2fcf24463bf
--- /dev/null
+++ b/lib/test_bits.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Test cases for functions and macros in bits.h
+ */
+
+#include <kunit/test.h>
+#include <linux/bits.h>
+
+
+void genmask_test(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, 1ul, GENMASK(0, 0));
+	KUNIT_EXPECT_EQ(test, 3ul, GENMASK(1, 0));
+	KUNIT_EXPECT_EQ(test, 6ul, GENMASK(2, 1));
+	KUNIT_EXPECT_EQ(test, 0xFFFFFFFFul, GENMASK(31, 0));
+
+#ifdef TEST_GENMASK_FAILURES
+	/* these should fail compilation */
+	GENMASK(0, 1);
+	GENMASK(0, 10);
+	GENMASK(9, 10);
+#endif
+
+
+}
+
+void genmask_ull_test(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, 1ull, GENMASK_ULL(0, 0));
+	KUNIT_EXPECT_EQ(test, 3ull, GENMASK_ULL(1, 0));
+	KUNIT_EXPECT_EQ(test, 0x000000ffffe00000ull, GENMASK_ULL(39, 21));
+	KUNIT_EXPECT_EQ(test, 0xffffffffffffffffull, GENMASK_ULL(63, 0));
+
+#ifdef TEST_GENMASK_FAILURES
+	/* these should fail compilation */
+	GENMASK_ULL(0, 1);
+	GENMASK_ULL(0, 10);
+	GENMASK_ULL(9, 10);
+#endif
+}
+
+void genmask_input_check_test(struct kunit *test)
+{
+	unsigned int x, y;
+	int z, w;
+
+	/* Unknown input */
+	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(x, 0));
+	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(0, x));
+	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(x, y));
+
+	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(z, 0));
+	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(0, z));
+	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(z, w));
+
+	/* Valid input */
+	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(1, 1));
+	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(39, 21));
+}
+
+
+static struct kunit_case bits_test_cases[] = {
+	KUNIT_CASE(genmask_test),
+	KUNIT_CASE(genmask_ull_test),
+	KUNIT_CASE(genmask_input_check_test),
+	{}
+};
+
+static struct kunit_suite bits_test_suite = {
+	.name = "bits-test",
+	.test_cases = bits_test_cases,
+};
+kunit_test_suite(bits_test_suite);
-- 
2.27.0
