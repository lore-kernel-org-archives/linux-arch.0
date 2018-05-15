From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v4 2/8] lib/test_bitmap.c: Add for_each_set_clump test cases
Date: Tue, 15 May 2018 12:22:36 -0400
Message-ID: <d31ab2199903f0771a008d3845d5146604c46db9.1526400945.git.vilhelm.gray@gmail.com>
References: <cover.1526400945.git.vilhelm.gray@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1526400945.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linus.walleij@linaro.org
Cc: linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, William Breathitt Gray <vilhelm.gray@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: linux-arch.vger.kernel.org

The introduction of the for_each_set_clump macro warrants test cases to
verify the implementation. This patch adds test case checks for whether
an out-of-bounds clump index is returned, a zero clump is returned, or
the returned clump value differs from the expected clump value. A 4-bit
clump size is chosen in order to verify non-8-bit iteration.

Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 lib/test_bitmap.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index de16f7869fb1..fd1b9f0d5eda 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -88,6 +88,39 @@ __check_eq_u32_array(const char *srcfile, unsigned int line,
 	return true;
 }
 
+static bool __init __check_eq_clump(const char *srcfile, unsigned int line,
+				    const size_t clump_index, const size_t size,
+				    const unsigned char *const clump_exp,
+				    const unsigned long *const bits,
+				    const size_t index,
+				    const unsigned int offset)
+{
+	unsigned long clump;
+	unsigned long exp;
+
+	if (clump_index >= size) {
+		pr_warn("[%s:%u] clump index out-of-bounds: expected less than %zu, got %zu\n",
+			srcfile, line, size, clump_index);
+		return false;
+	}
+
+	exp = clump_exp[clump_index];
+	if (!exp) {
+		pr_warn("[%s:%u] clump index for zero clump: expected nonzero clump, got clump index %zu with clump value 0",
+			srcfile, line, clump_index);
+		return false;
+	}
+
+	clump = (bits[index] >> offset) & 0xF;
+	if (clump != exp) {
+		pr_warn("[%s:%u] expected 0x%lX, got 0x%lX",
+			srcfile, line, exp, clump);
+		return false;
+	}
+
+	return true;
+}
+
 #define __expect_eq(suffix, ...)					\
 	({								\
 		int result = 0;						\
@@ -104,6 +137,7 @@ __check_eq_u32_array(const char *srcfile, unsigned int line,
 #define expect_eq_bitmap(...)		__expect_eq(bitmap, ##__VA_ARGS__)
 #define expect_eq_pbl(...)		__expect_eq(pbl, ##__VA_ARGS__)
 #define expect_eq_u32_array(...)	__expect_eq(u32_array, ##__VA_ARGS__)
+#define expect_eq_clump(...)		__expect_eq(clump, ##__VA_ARGS__)
 
 static void __init test_zero_clear(void)
 {
@@ -352,6 +386,42 @@ static void noinline __init test_mem_optimisations(void)
 	}
 }
 
+static const unsigned char clump_exp[] __initconst = {
+	0x1,	/* 1 bit set */
+	0x2,	/* non-edge 1 bit set */
+	0x0,	/* zero bits set */
+	0xE,	/* 3 bits set */
+	0xE,	/* Repeated clump */
+	0xF,	/* 4 bits set */
+	0x3,	/* 2 bits set */
+	0x5,	/* non-adjacent 2 bits set */
+};
+
+static void __init test_for_each_set_clump(void)
+{
+	size_t clump;
+	size_t index;
+	unsigned int offset;
+#define CLUMP_BITMAP_NUMBITS 32
+	DECLARE_BITMAP(bits, CLUMP_BITMAP_NUMBITS);
+#define CLUMP_SIZE 4
+	const size_t size = DIV_ROUND_UP(CLUMP_BITMAP_NUMBITS, CLUMP_SIZE);
+
+	/* set bitmap to test case */
+	bitmap_zero(bits, CLUMP_BITMAP_NUMBITS);
+	bitmap_set(bits, 0, 1);		/* 0x1 */
+	bitmap_set(bits, 5, 1);		/* 0x2 */
+	bitmap_set(bits, 13, 3);	/* 0xE */
+	bitmap_set(bits, 17, 3);	/* 0xE */
+	bitmap_set(bits, 20, 4);	/* 0xF */
+	bitmap_set(bits, 24, 2);	/* 0x3 */
+	bitmap_set(bits, 28, 1);	/* 0x5 - part 1 */
+	bitmap_set(bits, 30, 1);	/* 0x5 - part 2 */
+
+	for_each_set_clump(clump, index, offset, bits, size, CLUMP_SIZE)
+		expect_eq_clump(clump, size, clump_exp, bits, index, offset);
+}
+
 static int __init test_bitmap_init(void)
 {
 	test_zero_clear();
@@ -360,6 +430,7 @@ static int __init test_bitmap_init(void)
 	test_bitmap_arr32();
 	test_bitmap_parselist();
 	test_mem_optimisations();
+	test_for_each_set_clump();
 
 	if (failed_tests == 0)
 		pr_info("all %u tests passed\n", total_tests);
-- 
2.17.0
