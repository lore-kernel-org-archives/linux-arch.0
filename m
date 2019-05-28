Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f202.google.com ([209.85.222.202]:40338 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbfE1QdT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 May 2019 12:33:19 -0400
Received: by mail-qk1-f202.google.com with SMTP id n5so28617283qkf.7
        for <linux-arch@vger.kernel.org>; Tue, 28 May 2019 09:33:19 -0700 (PDT)
Date: Tue, 28 May 2019 18:32:56 +0200
Message-ID: <20190528163258.260144-1-elver@google.com>
Mime-Version: 1.0
Subject: [PATCH 1/3] lib/test_kasan: Add bitops tests
From: Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: peterz@infradead.org, aryabinin@virtuozzo.com, dvyukov@google.com, glider@google.com, andreyknvl@google.com
Cc: corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org, arnd@arndb.de, jpoimboe@redhat.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kasan-dev@googlegroups.com, Marco Elver <elver@google.com>
Message-ID: <20190528163256.IifUwLJix-XiX4V8iVWB0d6QtFL_nsAlNPbCU5wqnF8@z>

This adds bitops tests to the test_kasan module. In a follow-up patch,
support for bitops instrumentation will be added.

Signed-off-by: Marco Elver <elver@google.com>
---
 lib/test_kasan.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 3 deletions(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 7de2702621dc..f67f3b52251d 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -11,16 +11,17 @@
 
 #define pr_fmt(fmt) "kasan test: %s " fmt, __func__
 
+#include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/kasan.h>
 #include <linux/kernel.h>
-#include <linux/mman.h>
 #include <linux/mm.h>
+#include <linux/mman.h>
+#include <linux/module.h>
 #include <linux/printk.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/uaccess.h>
-#include <linux/module.h>
-#include <linux/kasan.h>
 
 /*
  * Note: test functions are marked noinline so that their names appear in
@@ -623,6 +624,71 @@ static noinline void __init kasan_strings(void)
 	strnlen(ptr, 1);
 }
 
+static noinline void __init kasan_bitops(void)
+{
+	long bits = 0;
+	const long bit = sizeof(bits) * 8;
+
+	pr_info("within-bounds in set_bit");
+	set_bit(0, &bits);
+
+	pr_info("within-bounds in set_bit");
+	set_bit(bit - 1, &bits);
+
+	pr_info("out-of-bounds in set_bit\n");
+	set_bit(bit, &bits);
+
+	pr_info("out-of-bounds in __set_bit\n");
+	__set_bit(bit, &bits);
+
+	pr_info("out-of-bounds in clear_bit\n");
+	clear_bit(bit, &bits);
+
+	pr_info("out-of-bounds in __clear_bit\n");
+	__clear_bit(bit, &bits);
+
+	pr_info("out-of-bounds in clear_bit_unlock\n");
+	clear_bit_unlock(bit, &bits);
+
+	pr_info("out-of-bounds in __clear_bit_unlock\n");
+	__clear_bit_unlock(bit, &bits);
+
+	pr_info("out-of-bounds in change_bit\n");
+	change_bit(bit, &bits);
+
+	pr_info("out-of-bounds in __change_bit\n");
+	__change_bit(bit, &bits);
+
+	pr_info("out-of-bounds in test_and_set_bit\n");
+	test_and_set_bit(bit, &bits);
+
+	pr_info("out-of-bounds in __test_and_set_bit\n");
+	__test_and_set_bit(bit, &bits);
+
+	pr_info("out-of-bounds in test_and_set_bit_lock\n");
+	test_and_set_bit_lock(bit, &bits);
+
+	pr_info("out-of-bounds in test_and_clear_bit\n");
+	test_and_clear_bit(bit, &bits);
+
+	pr_info("out-of-bounds in __test_and_clear_bit\n");
+	__test_and_clear_bit(bit, &bits);
+
+	pr_info("out-of-bounds in test_and_change_bit\n");
+	test_and_change_bit(bit, &bits);
+
+	pr_info("out-of-bounds in __test_and_change_bit\n");
+	__test_and_change_bit(bit, &bits);
+
+	pr_info("out-of-bounds in test_bit\n");
+	(void)test_bit(bit, &bits);
+
+#if defined(clear_bit_unlock_is_negative_byte)
+	pr_info("out-of-bounds in clear_bit_unlock_is_negative_byte\n");
+	clear_bit_unlock_is_negative_byte(bit, &bits);
+#endif
+}
+
 static int __init kmalloc_tests_init(void)
 {
 	/*
@@ -664,6 +730,7 @@ static int __init kmalloc_tests_init(void)
 	kasan_memchr();
 	kasan_memcmp();
 	kasan_strings();
+	kasan_bitops();
 
 	kasan_restore_multi_shot(multishot);
 
-- 
2.22.0.rc1.257.g3120a18244-goog
