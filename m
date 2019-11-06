Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33197 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbfKFON0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Nov 2019 09:13:26 -0500
Received: by mail-wr1-f65.google.com with SMTP id w30so3273322wra.0
        for <linux-arch@vger.kernel.org>; Wed, 06 Nov 2019 06:13:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 01/10] x86: Remove arch_has_random, arch_has_random_seed
Date: Wed,  6 Nov 2019 15:12:59 +0100
Message-ID: <20191106141308.30535-2-rth@twiddle.net>
In-Reply-To: <20191106141308.30535-1-rth@twiddle.net>
References: <20191106141308.30535-1-rth@twiddle.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-crypto@vger.kernel.org
Cc: herbert@gondor.apana.org.au, linux-arch@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20191106141259.yo97qQkTGp8KUWgDBnMExecmR4ahIu5qMVwNj_JdTKg@z>

Use the expansion of these macros directly in arch_get_random_*.

These symbols are currently part of the generic archrandom.h
interface, but are currently unused and can be removed.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 arch/x86/include/asm/archrandom.h | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/archrandom.h b/arch/x86/include/asm/archrandom.h
index af45e1452f09..feb59461046c 100644
--- a/arch/x86/include/asm/archrandom.h
+++ b/arch/x86/include/asm/archrandom.h
@@ -73,10 +73,6 @@ static inline bool rdseed_int(unsigned int *v)
 	return ok;
 }
 
-/* Conditional execution based on CPU type */
-#define arch_has_random()	static_cpu_has(X86_FEATURE_RDRAND)
-#define arch_has_random_seed()	static_cpu_has(X86_FEATURE_RDSEED)
-
 /*
  * These are the generic interfaces; they must not be declared if the
  * stubs in <linux/random.h> are to be invoked,
@@ -86,22 +82,22 @@ static inline bool rdseed_int(unsigned int *v)
 
 static inline bool arch_get_random_long(unsigned long *v)
 {
-	return arch_has_random() ? rdrand_long(v) : false;
+	return static_cpu_has(X86_FEATURE_RDRAND) ? rdrand_long(v) : false;
 }
 
 static inline bool arch_get_random_int(unsigned int *v)
 {
-	return arch_has_random() ? rdrand_int(v) : false;
+	return static_cpu_has(X86_FEATURE_RDRAND) ? rdrand_int(v) : false;
 }
 
 static inline bool arch_get_random_seed_long(unsigned long *v)
 {
-	return arch_has_random_seed() ? rdseed_long(v) : false;
+	return static_cpu_has(X86_FEATURE_RDSEED) ? rdseed_long(v) : false;
 }
 
 static inline bool arch_get_random_seed_int(unsigned int *v)
 {
-	return arch_has_random_seed() ? rdseed_int(v) : false;
+	return static_cpu_has(X86_FEATURE_RDSEED) ? rdseed_int(v) : false;
 }
 
 extern void x86_init_rdrand(struct cpuinfo_x86 *c);
-- 
2.17.1
