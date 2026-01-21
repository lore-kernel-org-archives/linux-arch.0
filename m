Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44514D98EF
	for <linux-arch@vger.kernel.org>; Wed, 21 Jan 2026 14:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007496; cv=none; b=uZF9wHcUgVYXuQ5RMnpK4HktMVUlX8MNjSF3VukuYfohcwVof3fw1bWHLPIUVsrAveOJdjt6aCs6hu7+cXEhd9xO8giEWUULhjtuVdfqkIrVohJxNwSPe5vgjN9c7uUd+Wz/Jrxk+gQnCflTGXpdhUeM60Xk9uyroUI2hjfhcZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007496; c=relaxed/simple;
	bh=x2rrcpb/s3mTtuY4bVsmxaUW1vje9Nqmah8JcL8MUHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=erV3Yp0kJXHMvtab52jT4UIgclqJtAAXzEMioDjRH1a2Xum9KztaLEzs1gWBGzmlqyC01s/e0h2hTcAJ2CHugqmHNZOU5Ow4MjJtKBI3HkjPyc+gZ9oalOWWICe86jk7h/X5kmUz+h/Li0YL5s1XKjdOnSiuHneMXCbM4WCTQF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=Cy3l9jVF; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="Cy3l9jVF"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1viZer-008XEN-9f; Wed, 21 Jan 2026 15:58:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=lR0OR/0w0VcAlZlqORMKFUweAPjLQDsHqvIpq/QZ4pI=; b=Cy3l9jVF89F6ACDblSUg/2W7ve
	a2y+ET6ZC7cQ25S/v6wkfuI5QmSAGwZXrHkLqhDl/950/lMtzcbBRW9BhessiMnCygAH2AnkK4fwY
	eSoSkjIP/8SPAfENToSx175Bo6E2paKFi1uEebo0PVJEcBjF/vAOAliOdWu4hOUnc+tPP6Wy05vWl
	8zVcGnSeJoGeJFEdvUZMl+HDD0TRnDQ1K9nTOh/iLpFc/Q/NQ8qbsdN03qVDCEAueeOBfaLlHs2JT
	Q0lv6a2v+oEpO1qxh/FO2JWv6qBvwl/wr6bRDi9duYHNwAlHZj8ZoKnZHcYgbqfwjw28r/neszQr2
	L9Zh/CLg==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1viZeq-0001sa-KN; Wed, 21 Jan 2026 15:58:08 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1viZeY-00GH6h-0s; Wed, 21 Jan 2026 15:57:50 +0100
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
Subject: [PATCH next 10/14] bits: Fix assmebler expansions of GENMASK_Uxx() and BIT_Uxx()
Date: Wed, 21 Jan 2026 14:57:27 +0000
Message-Id: <20260121145731.3623-11-david.laight.linux@gmail.com>
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

The assembler only supports one type of signed integers, so expressions
using BITS_PER_LONG (etc) cannot be guaranteed to be correct.

Use ((2 << (h)) - (1 << (l))) for all assembler GENMASK() expansions and
add definitions of BIT_Uxx() as (1 << (nr)).

Note that 64bit results are (probably) only correct for 64bit builds
and 128bits results will never be valid.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 include/linux/bits.h | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/include/linux/bits.h b/include/linux/bits.h
index 23bc94815569..43631a334314 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -19,14 +19,6 @@
  */
 #if !defined(__ASSEMBLY__)
 
-/*
- * Missing asm support
- *
- * GENMASK_U*() and BIT_U*() depend on BITS_PER_TYPE() which relies on sizeof(),
- * something not available in asm. Nevertheless, fixed width integers is a C
- * concept. Assembly code can rely on the long and long long versions instead.
- */
-
 #include <linux/build_bug.h>
 #include <linux/compiler.h>
 #include <linux/overflow.h>
@@ -46,6 +38,7 @@
 #define GENMASK_TYPE(t, h, l)					\
 	((unsigned int)GENMASK_INPUT_CHECK(h, l) +		\
 	 ((t)-1 << (l) & (t)-1 >> (BITS_PER_TYPE(t) - 1 - (h))))
+#endif
 
 #define GENMASK(h, l)		GENMASK_TYPE(unsigned long, h, l)
 #define GENMASK_ULL(h, l)	GENMASK_TYPE(unsigned long long, h, l)
@@ -56,9 +49,10 @@
 #define GENMASK_U64(h, l)	GENMASK_TYPE(u64, h, l)
 #define GENMASK_U128(h, l)	GENMASK_TYPE(u128, h, l)
 
+#if !defined(__ASSEMBLY__)
 /*
- * Fixed-type variants of BIT(), with additional checks like GENMASK_TYPE(). The
- * following examples generate compiler warnings due to -Wshift-count-overflow:
+ * Fixed-type variants of BIT(), with additional checks like GENMASK_TYPE().
+ * The following examples generate compiler warnings from BIT_INPUT_CHECK().
  *
  * - BIT_U8(8)
  * - BIT_U32(-1)
@@ -68,21 +62,28 @@
 	BUILD_BUG_ON_ZERO(const_true((nr) >= BITS_PER_TYPE(type)))
 
 #define BIT_TYPE(type, nr) ((unsigned int)BIT_INPUT_CHECK(type, nr) + ((type)1 << (nr)))
+#endif /* defined(__ASSEMBLY__) */
 
 #define BIT_U8(nr)	BIT_TYPE(u8, nr)
 #define BIT_U16(nr)	BIT_TYPE(u16, nr)
 #define BIT_U32(nr)	BIT_TYPE(u32, nr)
 #define BIT_U64(nr)	BIT_TYPE(u64, nr)
 
-#else /* defined(__ASSEMBLY__) */
+#if defined(__ASSEMBLY__)
 
 /*
- * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
- * disable the input check if that is the case.
+ * The assmebler only supports one size of signed integer rather than
+ * the fixed width integer types of C.
+ * There is also no method for reported invalid input.
+ * Error in .h files will usually be picked up when compiled into C files.
+ *
+ * Define type-size agnostic definitions that generate the correct value
+ * provided it can be represented by the assembler.
  */
-#define GENMASK(h, l)		__GENMASK(h, l)
-#define GENMASK_ULL(h, l)	__GENMASK_ULL(h, l)
 
-#endif /* !defined(__ASSEMBLY__) */
+#define GENMASK_TYPE(t, h, l)	((2 << (h)) - (1 << (l)))
+#define BIT_TYPE(type, nr)	(1 << (nr))
+
+#endif /* defined(__ASSEMBLY__) */
 
 #endif	/* __LINUX_BITS_H */
-- 
2.39.5

