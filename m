Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D826F4D90D3
	for <linux-arch@vger.kernel.org>; Wed, 21 Jan 2026 14:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007498; cv=none; b=A2jUzT4fe1V4rTkI+WQmiBAFfzr7XB3DzRVHUSDb4Cpu5wF6frgkglvS7oxoZuGjjoSXDEC2bONRwAi895XGf54ztn4Pp2vMk02284g6gIZeeW7anbQNEblj9KLu7aEM2reGDbVmGbTaYT3FOPu4I8/PhBcH8j4PZhOtdwiGeUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007498; c=relaxed/simple;
	bh=OuoX9rZ0eSyjPgtxw+7n9VkSoFoOdOkSZxjyKEbJrlc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TAM8ZuSgHfrgENdi4SbNWc1bP2t+vJ+lbxKgUSXD+vBvyJXi09/Ju28ULDr947K6jwXz84RTq94PBH6WcAPJxTt7vLFDoH+FFjp56S6TiPR5Mjlrv9080LMQYW8UD7YMz+nNwjfzctMjJ1IEhEajeYCr9j0D6Gjd3+d43fZlLr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=HNAKmRJA; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="HNAKmRJA"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1viZet-008Pjw-TQ; Wed, 21 Jan 2026 15:58:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=/ToXfeXh3OPuvD0iNKmVcu+YVeCSv/mDVOYNbMhE++U=; b=HNAKmRJAX0l0p8ILIbUcsRcn7m
	PHCbvFoW1SX91LbL+trQBUEQdshO58/rQ6TvPnLbUCz8mFhxEJPonSM0uj9gTeUWpcO43FIMsusj3
	6YNSn6t1o2MwV7vQ4aEMOyMs9HB5PC7plzImRnYAmLB25+4qX6GVUzInGb+Ov/ep+SZO+CYFYFOUM
	qUnaLsCL6bCn0MWLtivbqF6QmfciRMkktsFFz+bzEo6HQBSTwn3jYGXRTBAmNswjE3rVtwhvOf50D
	txbqmIToXte4S5sQmitgsmZ5hzAZF68aPCzPvh7cjVdz5O/at3v8DSjAtLpoN5C9huqS/DMk0lr8i
	MTQfFeCw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1viZet-0001tU-Aq; Wed, 21 Jan 2026 15:58:11 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1viZeZ-00GH6h-79; Wed, 21 Jan 2026 15:57:51 +0100
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
Subject: [PATCH next 12/14] bits: move the defitions of BIT() and BIT_ULL() back to linux/bits.h
Date: Wed, 21 Jan 2026 14:57:29 +0000
Message-Id: <20260121145731.3623-13-david.laight.linux@gmail.com>
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

The definition of BIT() was moved from linux/bits.h to vdso/bits.h to
isolate the vdso from 'normal' kernel headers.
BIT_ULL() was then moved to be defined in the same place for consistency.

Since then linux/bits.h had gained BIT_Unn() and it really makes sense
for BIT() and BIT_ULL() to be defined in the same place.

Move BIT_ULL() and make code that include both headers use the definition
of BIT() from linux/bits.h
Add BIT_U128() for completness.

This lets BIT() pick up the extra compile time checks for W=[1c] builds
that detect errors like:
	long foo(void) { int x = 64; return BIT(x); }
For which clang (silently) just generates a 'return' instruction.

Note that nothing the the x86-64 build relies on the definition in
vdso/bits.h, linux/bits.h is always included.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 include/linux/bits.h | 7 ++++++-
 include/vdso/bits.h  | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/bits.h b/include/linux/bits.h
index 0f559038981d..3dd32b9eef35 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -2,7 +2,6 @@
 #ifndef __LINUX_BITS_H
 #define __LINUX_BITS_H
 
-#include <vdso/bits.h>
 #include <uapi/linux/bits.h>
 
 #define BIT_MASK(nr)		(UL(1) << ((nr) % BITS_PER_LONG))
@@ -89,10 +88,16 @@ int BIT_INPUT_CHECK_FAIL(void) __compiletime_error("Bit number out of range");
 	((unsigned int)BIT_INPUT_CHECK(+(nr), BITS_PER_TYPE(type)) + ((type)1 << (nr)))
 #endif /* defined(__ASSEMBLY__) */
 
+/* Prefer this definition of BIT() to the one in vdso/bits.h */
+#undef BIT
+#define __VDSO_BITS_H
+#define BIT(nr)		BIT_TYPE(unsigned long, nr)
+#define BIT_ULL(nr)	BIT_TYPE(unsigned long long, nr)
 #define BIT_U8(nr)	BIT_TYPE(u8, nr)
 #define BIT_U16(nr)	BIT_TYPE(u16, nr)
 #define BIT_U32(nr)	BIT_TYPE(u32, nr)
 #define BIT_U64(nr)	BIT_TYPE(u64, nr)
+#define BIT_U128(nr)	BIT_TYPE(u128, nr)
 
 #if defined(__ASSEMBLY__)
 
diff --git a/include/vdso/bits.h b/include/vdso/bits.h
index 388b212088ea..a6ac1e6b637c 100644
--- a/include/vdso/bits.h
+++ b/include/vdso/bits.h
@@ -4,7 +4,7 @@
 
 #include <vdso/const.h>
 
+/* Most code picks up BIT() from linux/bits.h */
 #define BIT(nr)			(UL(1) << (nr))
-#define BIT_ULL(nr)		(ULL(1) << (nr))
 
 #endif	/* __VDSO_BITS_H */
-- 
2.39.5

