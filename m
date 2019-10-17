Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vs1-f74.google.com ([209.85.217.74]:45987 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439928AbfJQONq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Oct 2019 10:13:46 -0400
Received: by mail-vs1-f74.google.com with SMTP id v23so482074vsc.12
        for <linux-arch@vger.kernel.org>; Thu, 17 Oct 2019 07:13:45 -0700 (PDT)
Date: Thu, 17 Oct 2019 16:13:03 +0200
In-Reply-To: <20191017141305.146193-1-elver@google.com>
Message-ID: <20191017141305.146193-7-elver@google.com>
Mime-Version: 1.0
References: <20191017141305.146193-1-elver@google.com>
Subject: [PATCH v2 6/8] asm-generic, kcsan: Add KCSAN instrumentation for bitops
From: Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: elver@google.com
Cc: akiyks@gmail.com, stern@rowland.harvard.edu, glider@google.com, parri.andrea@gmail.com, andreyknvl@google.com, luto@kernel.org, ard.biesheuvel@linaro.org, arnd@arndb.de, boqun.feng@gmail.com, bp@alien8.de, dja@axtens.net, dlustig@nvidia.com, dave.hansen@linux.intel.com, dhowells@redhat.com, dvyukov@google.com, hpa@zytor.com, mingo@redhat.com, j.alglave@ucl.ac.uk, joel@joelfernandes.org, corbet@lwn.net, jpoimboe@redhat.com, luc.maranget@inria.fr, mark.rutland@arm.com, npiggin@gmail.com, paulmck@linux.ibm.com, peterz@infradead.org, tglx@linutronix.de, will@kernel.org, kasan-dev@googlegroups.com, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Message-ID: <20191017141303.NAMHJLn86UX8BAFubxI8SU5eryhCZUd4HpQnQ0jlm8Q@z>

Add explicit KCSAN checks for bitops.

Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Use kcsan_check{,_atomic}_{read,write} instead of
  kcsan_check_{access,atomic}.
---
 include/asm-generic/bitops-instrumented.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/asm-generic/bitops-instrumented.h b/include/asm-generic/bitops-instrumented.h
index ddd1c6d9d8db..864d707cdb87 100644
--- a/include/asm-generic/bitops-instrumented.h
+++ b/include/asm-generic/bitops-instrumented.h
@@ -12,6 +12,7 @@
 #define _ASM_GENERIC_BITOPS_INSTRUMENTED_H
 
 #include <linux/kasan-checks.h>
+#include <linux/kcsan-checks.h>
 
 /**
  * set_bit - Atomically set a bit in memory
@@ -26,6 +27,7 @@
 static inline void set_bit(long nr, volatile unsigned long *addr)
 {
 	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	arch_set_bit(nr, addr);
 }
 
@@ -41,6 +43,7 @@ static inline void set_bit(long nr, volatile unsigned long *addr)
 static inline void __set_bit(long nr, volatile unsigned long *addr)
 {
 	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_write(addr + BIT_WORD(nr), sizeof(long));
 	arch___set_bit(nr, addr);
 }
 
@@ -54,6 +57,7 @@ static inline void __set_bit(long nr, volatile unsigned long *addr)
 static inline void clear_bit(long nr, volatile unsigned long *addr)
 {
 	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	arch_clear_bit(nr, addr);
 }
 
@@ -69,6 +73,7 @@ static inline void clear_bit(long nr, volatile unsigned long *addr)
 static inline void __clear_bit(long nr, volatile unsigned long *addr)
 {
 	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_write(addr + BIT_WORD(nr), sizeof(long));
 	arch___clear_bit(nr, addr);
 }
 
@@ -82,6 +87,7 @@ static inline void __clear_bit(long nr, volatile unsigned long *addr)
 static inline void clear_bit_unlock(long nr, volatile unsigned long *addr)
 {
 	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	arch_clear_bit_unlock(nr, addr);
 }
 
@@ -97,6 +103,7 @@ static inline void clear_bit_unlock(long nr, volatile unsigned long *addr)
 static inline void __clear_bit_unlock(long nr, volatile unsigned long *addr)
 {
 	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_write(addr + BIT_WORD(nr), sizeof(long));
 	arch___clear_bit_unlock(nr, addr);
 }
 
@@ -113,6 +120,7 @@ static inline void __clear_bit_unlock(long nr, volatile unsigned long *addr)
 static inline void change_bit(long nr, volatile unsigned long *addr)
 {
 	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	arch_change_bit(nr, addr);
 }
 
@@ -128,6 +136,7 @@ static inline void change_bit(long nr, volatile unsigned long *addr)
 static inline void __change_bit(long nr, volatile unsigned long *addr)
 {
 	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_write(addr + BIT_WORD(nr), sizeof(long));
 	arch___change_bit(nr, addr);
 }
 
@@ -141,6 +150,7 @@ static inline void __change_bit(long nr, volatile unsigned long *addr)
 static inline bool test_and_set_bit(long nr, volatile unsigned long *addr)
 {
 	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch_test_and_set_bit(nr, addr);
 }
 
@@ -155,6 +165,7 @@ static inline bool test_and_set_bit(long nr, volatile unsigned long *addr)
 static inline bool __test_and_set_bit(long nr, volatile unsigned long *addr)
 {
 	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch___test_and_set_bit(nr, addr);
 }
 
@@ -170,6 +181,7 @@ static inline bool __test_and_set_bit(long nr, volatile unsigned long *addr)
 static inline bool test_and_set_bit_lock(long nr, volatile unsigned long *addr)
 {
 	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch_test_and_set_bit_lock(nr, addr);
 }
 
@@ -183,6 +195,7 @@ static inline bool test_and_set_bit_lock(long nr, volatile unsigned long *addr)
 static inline bool test_and_clear_bit(long nr, volatile unsigned long *addr)
 {
 	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch_test_and_clear_bit(nr, addr);
 }
 
@@ -197,6 +210,7 @@ static inline bool test_and_clear_bit(long nr, volatile unsigned long *addr)
 static inline bool __test_and_clear_bit(long nr, volatile unsigned long *addr)
 {
 	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch___test_and_clear_bit(nr, addr);
 }
 
@@ -210,6 +224,7 @@ static inline bool __test_and_clear_bit(long nr, volatile unsigned long *addr)
 static inline bool test_and_change_bit(long nr, volatile unsigned long *addr)
 {
 	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch_test_and_change_bit(nr, addr);
 }
 
@@ -224,6 +239,7 @@ static inline bool test_and_change_bit(long nr, volatile unsigned long *addr)
 static inline bool __test_and_change_bit(long nr, volatile unsigned long *addr)
 {
 	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch___test_and_change_bit(nr, addr);
 }
 
@@ -235,6 +251,7 @@ static inline bool __test_and_change_bit(long nr, volatile unsigned long *addr)
 static inline bool test_bit(long nr, const volatile unsigned long *addr)
 {
 	kasan_check_read(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_atomic_read(addr + BIT_WORD(nr), sizeof(long));
 	return arch_test_bit(nr, addr);
 }
 
@@ -254,6 +271,7 @@ static inline bool
 clear_bit_unlock_is_negative_byte(long nr, volatile unsigned long *addr)
 {
 	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch_clear_bit_unlock_is_negative_byte(nr, addr);
 }
 /* Let everybody know we have it. */
-- 
2.23.0.866.gb869b98d4c-goog
