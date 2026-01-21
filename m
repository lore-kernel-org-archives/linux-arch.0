Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BEC4D8DBF
	for <linux-arch@vger.kernel.org>; Wed, 21 Jan 2026 14:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007494; cv=none; b=e+6FFDKr1HE0mckvwaXLG3rniojv9MiAaYI/v01glNDAs+zzraZ1p7GfPr44LU/Yk/V3R1DtM6u8/nW8H+g4Lpv1QU13UlFycN5fyACFUA/6JykTTN9zQAxZSgKGBrJ3PV7LQk1Sg5d0st2xvd08+cbfiF/NmwGajF3SdW+2TkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007494; c=relaxed/simple;
	bh=1cHBQHEyqWPZ51YmiIdEAZN+oAUWjME/Gol7MEr4hLs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f1ISfjPVv2cYGBrS0VBmSviP4WHDXInVCao1XTFQwHd3g3NfPb7qa3UVHmqi7+75wGqx+1fBpePgidYPQzKktVtHLqDPjOMijxvebDKruOEZUAVDa9TplF6aE4IQ1Bga1mTTIthKVBBZK/MkspC22ui24qhbzpSl7D6QQi5ruRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=AE2Gu1iC; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="AE2Gu1iC"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1viZeo-008PiG-6m; Wed, 21 Jan 2026 15:58:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=fkOOOuXIe68/qJN84cF/oemnl/qDhRt1xPrfHh5OqwM=; b=AE2Gu1iCc38H1M0Sf1ZKgxKcXZ
	m5W7ZH6mq7c80J6MXuZqiN0uJJioaT1hz3NK1P5ld17IEA16Ub2c41zUuLnnUiD+jKOfp9nDTrWCL
	iZLusyFpegMsW26woqI5HlOgBp8ksxtdtXBzuqVTtvUotn3Uy/yhOFw4KzutSFEtm+TRi/IXCCpOl
	xI8qAORrnb/xZJOrz0OLlQ/ZUM7tGScjSuPPQvrbYpsSgcLssYGFrocoCV5C8466F+3KQnSgSmsoc
	txWtIkMxHUIR4NKv7d4RAXObX8iAIAF6dcaCrNwLekRfBBZ+HMs6m7J98YXZbHS9Qy+zdfVORCr1l
	PskC2bZg==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1viZen-0001sK-QY; Wed, 21 Jan 2026 15:58:05 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1viZeX-00GH6h-EQ; Wed, 21 Jan 2026 15:57:49 +0100
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
Subject: [PATCH next 09/14] bits: Change BIT_U8/16() and GENMASK_U8/16() to have unsigned values
Date: Wed, 21 Jan 2026 14:57:26 +0000
Message-Id: <20260121145731.3623-10-david.laight.linux@gmail.com>
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

Casting the value of BIT_U*() and GENMASK_U8() to (u8) is pointless.
Although it changes what typeof(BIT_U8()) returns the value will
always be promoted to 'signed int' before it is used.
Instead force the expression to be an unsigned type.

Avoids unexpected sign extension from, for example:
	u64 v = BIT_U8(7) << 24;

Fix the KUNIT tests to match.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 include/linux/bits.h  |  6 +++---
 lib/tests/test_bits.c | 12 ++++++------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/bits.h b/include/linux/bits.h
index 697318f2a47d..23bc94815569 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -44,8 +44,8 @@
  * - GENMASK_U32(33, 15): doesn't fit in a u32
  */
 #define GENMASK_TYPE(t, h, l)					\
-	((t)(GENMASK_INPUT_CHECK(h, l) +			\
-	     ((t)-1 << (l) & (t)-1 >> (BITS_PER_TYPE(t) - 1 - (h)))))
+	((unsigned int)GENMASK_INPUT_CHECK(h, l) +		\
+	 ((t)-1 << (l) & (t)-1 >> (BITS_PER_TYPE(t) - 1 - (h))))
 
 #define GENMASK(h, l)		GENMASK_TYPE(unsigned long, h, l)
 #define GENMASK_ULL(h, l)	GENMASK_TYPE(unsigned long long, h, l)
@@ -67,7 +67,7 @@
 #define BIT_INPUT_CHECK(type, nr) \
 	BUILD_BUG_ON_ZERO(const_true((nr) >= BITS_PER_TYPE(type)))
 
-#define BIT_TYPE(type, nr) ((type)(BIT_INPUT_CHECK(type, nr) + BIT_ULL(nr)))
+#define BIT_TYPE(type, nr) ((unsigned int)BIT_INPUT_CHECK(type, nr) + ((type)1 << (nr)))
 
 #define BIT_U8(nr)	BIT_TYPE(u8, nr)
 #define BIT_U16(nr)	BIT_TYPE(u16, nr)
diff --git a/lib/tests/test_bits.c b/lib/tests/test_bits.c
index ab88e50d2edf..55be8230f9e7 100644
--- a/lib/tests/test_bits.c
+++ b/lib/tests/test_bits.c
@@ -9,20 +9,20 @@
 
 #define assert_type(t, x) _Generic(x, t: x, default: 0)
 
-static_assert(assert_type(u8, BIT_U8(0)) == 1u);
-static_assert(assert_type(u16, BIT_U16(0)) == 1u);
+static_assert(assert_type(unsigned int, BIT_U8(0)) == 1u);
+static_assert(assert_type(unsigned int, BIT_U16(0)) == 1u);
 static_assert(assert_type(u32, BIT_U32(0)) == 1u);
 static_assert(assert_type(u64, BIT_U64(0)) == 1ull);
 
-static_assert(assert_type(u8, BIT_U8(7)) == 0x80u);
-static_assert(assert_type(u16, BIT_U16(15)) == 0x8000u);
+static_assert(assert_type(unsigned int, BIT_U8(7)) == 0x80u);
+static_assert(assert_type(unsigned int, BIT_U16(15)) == 0x8000u);
 static_assert(assert_type(u32, BIT_U32(31)) == 0x80000000u);
 static_assert(assert_type(u64, BIT_U64(63)) == 0x8000000000000000ull);
 
 static_assert(assert_type(unsigned long, GENMASK(31, 0)) == U32_MAX);
 static_assert(assert_type(unsigned long long, GENMASK_ULL(63, 0)) == U64_MAX);
-static_assert(assert_type(u8, GENMASK_U8(7, 0)) == U8_MAX);
-static_assert(assert_type(u16, GENMASK_U16(15, 0)) == U16_MAX);
+static_assert(assert_type(unsigned int, GENMASK_U8(7, 0)) == U8_MAX);
+static_assert(assert_type(unsigned int, GENMASK_U16(15, 0)) == U16_MAX);
 static_assert(assert_type(u32, GENMASK_U32(31, 0)) == U32_MAX);
 static_assert(assert_type(u64, GENMASK_U64(63, 0)) == U64_MAX);
 
-- 
2.39.5

