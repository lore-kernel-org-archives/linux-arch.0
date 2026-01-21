Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C714A33F9;
	Wed, 21 Jan 2026 14:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007500; cv=none; b=OwPsyxPnFjw7MnCHBFMdg5HQm/frv5aPFAlAM5130uufB0470xWrZSG3ezl0yDnPF7+bnG8KmYNfP3pKmkOm+e12LR2KmymvQax4P9DNe2XA6xfvv4OEVzF8ZVijDMkZytH6+k35JKk4Zsx9Fng3SMyfpwaykx1c3VEB5ucX3Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007500; c=relaxed/simple;
	bh=GrU5G25/P99RLLNQ7KSbxlvGQaNMjUwXFB4EvQMlbdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hCYJpqQPjVrjMy5ESACaFoxEOzan6HX3ByEnM1C3rSgf8O9hIIrfpWd7OGSc9CdEzQ88IGVRREzG4XpAidgx5Xw0p8v2bHE3WxnBanGYrforWa8QT+5XQaouMBdOeRo2MLs5R2EPbYh/L9sMOeGnUdze+i6WygLLGMrBW5Ni8Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=mumsnJE3; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="mumsnJE3"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1viZet-008Pjm-DL; Wed, 21 Jan 2026 15:58:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=IMLT+9LEWzpcaNrLe+KYWU3xSE5AFfmLcg7xui5sLPw=; b=mumsnJE3uG328eoTonga0q7XW6
	YfxKMj4TyOcRNmcEom1hQhXoXBkDtQJu67uXD+e6W/e3KOT/1MalE7MCaGuQK/8u/AEkbuxda2HHT
	LZfVxqkJIlusPga7K1VSy/+CuaFF+ZiA4GfpPYtAgnVNcCG9/WEZ5yGVRzcgdyaG6rY+G1wK2Jf7w
	78dhBKJBBpTGGbdUyGJ3tfUzOdyJDMtcXt5+N6AMhNCsqGPBSIN7Pn76W+JivjdCDplOkc11JweDB
	NbWmJf6JRbCnVRg0slt8LFoU+ehGPwqntj1KNg+urxtMk28oyxwHFvC3eK+dCu+jr+BNAK5xm0nC/
	3m/rHDYg==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1viZes-0001sq-Lm; Wed, 21 Jan 2026 15:58:11 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1viZeZ-00GH6h-QD; Wed, 21 Jan 2026 15:57:51 +0100
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
Subject: [PATCH next 13/14] test_bits: Change all the tests to be compile-time tests
Date: Wed, 21 Jan 2026 14:57:30 +0000
Message-Id: <20260121145731.3623-14-david.laight.linux@gmail.com>
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

Since all the GENMASK() values are compile-time constants they can
be tested with BUILD_BUG_ON() rather than KUNIT_EXPECT_EQ().

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 lib/tests/test_bits.c | 90 +++++++++++++++++++++----------------------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/lib/tests/test_bits.c b/lib/tests/test_bits.c
index 36eb4661e78b..4d3a895f490c 100644
--- a/lib/tests/test_bits.c
+++ b/lib/tests/test_bits.c
@@ -32,30 +32,30 @@ static_assert(assert_type(u64, GENMASK_U64(63, 0)) == U64_MAX);
 
 static void __genmask_test(struct kunit *test)
 {
-	KUNIT_EXPECT_EQ(test, 1ul, __GENMASK(0, 0));
-	KUNIT_EXPECT_EQ(test, 3ul, __GENMASK(1, 0));
-	KUNIT_EXPECT_EQ(test, 6ul, __GENMASK(2, 1));
-	KUNIT_EXPECT_EQ(test, 0xFFFFFFFFul, __GENMASK(31, 0));
+	BUILD_BUG_ON(__GENMASK(0, 0) != 1ul);
+	BUILD_BUG_ON(__GENMASK(1, 0) != 3ul);
+	BUILD_BUG_ON(__GENMASK(2, 1) != 6ul);
+	BUILD_BUG_ON(__GENMASK(31, 0) != 0xFFFFFFFFul);
 }
 
 static void __genmask_ull_test(struct kunit *test)
 {
-	KUNIT_EXPECT_EQ(test, 1ull, __GENMASK_ULL(0, 0));
-	KUNIT_EXPECT_EQ(test, 3ull, __GENMASK_ULL(1, 0));
-	KUNIT_EXPECT_EQ(test, 0x000000ffffe00000ull, __GENMASK_ULL(39, 21));
-	KUNIT_EXPECT_EQ(test, 0xffffffffffffffffull, __GENMASK_ULL(63, 0));
+	BUILD_BUG_ON(__GENMASK_ULL(0, 0) != 1ull);
+	BUILD_BUG_ON(__GENMASK_ULL(1, 0) != 3ull);
+	BUILD_BUG_ON(__GENMASK_ULL(39, 21) != 0x000000ffffe00000ull);
+	BUILD_BUG_ON(__GENMASK_ULL(63, 0) != 0xffffffffffffffffull);
 }
 
 static void genmask_test(struct kunit *test)
 {
-	KUNIT_EXPECT_EQ(test, 1ul, GENMASK(0, 0));
-	KUNIT_EXPECT_EQ(test, 3ul, GENMASK(1, 0));
-	KUNIT_EXPECT_EQ(test, 6ul, GENMASK(2, 1));
-	KUNIT_EXPECT_EQ(test, 0xFFFFFFFFul, GENMASK(31, 0));
+	BUILD_BUG_ON(GENMASK(0, 0) != 1ul);
+	BUILD_BUG_ON(GENMASK(1, 0) != 3ul);
+	BUILD_BUG_ON(GENMASK(2, 1) != 6ul);
+	BUILD_BUG_ON(GENMASK(31, 0) != 0xFFFFFFFFul);
 
-	KUNIT_EXPECT_EQ(test, 1u, GENMASK_U8(0, 0));
-	KUNIT_EXPECT_EQ(test, 3u, GENMASK_U16(1, 0));
-	KUNIT_EXPECT_EQ(test, 0x10000, GENMASK_U32(16, 16));
+	BUILD_BUG_ON(GENMASK_U8(0, 0) != 1u);
+	BUILD_BUG_ON(GENMASK_U16(1, 0) != 3u);
+	BUILD_BUG_ON(GENMASK_U32(16, 16) != 0x10000);
 
 #ifdef TEST_GENMASK_FAILURES
 	/* these should fail compilation */
@@ -75,10 +75,10 @@ static void genmask_test(struct kunit *test)
 
 static void genmask_ull_test(struct kunit *test)
 {
-	KUNIT_EXPECT_EQ(test, 1ull, GENMASK_ULL(0, 0));
-	KUNIT_EXPECT_EQ(test, 3ull, GENMASK_ULL(1, 0));
-	KUNIT_EXPECT_EQ(test, 0x000000ffffe00000ull, GENMASK_ULL(39, 21));
-	KUNIT_EXPECT_EQ(test, 0xffffffffffffffffull, GENMASK_ULL(63, 0));
+	BUILD_BUG_ON(GENMASK_ULL(0, 0) != 1ull);
+	BUILD_BUG_ON(GENMASK_ULL(1, 0) != 3ull);
+	BUILD_BUG_ON(GENMASK_ULL(39, 21) != 0x000000ffffe00000ull);
+	BUILD_BUG_ON(GENMASK_ULL(63, 0) != 0xffffffffffffffffull);
 
 #ifdef TEST_GENMASK_FAILURES
 	/* these should fail compilation */
@@ -92,23 +92,23 @@ static void genmask_u128_test(struct kunit *test)
 {
 #ifdef CONFIG_ARCH_SUPPORTS_INT128
 	/* Below 64 bit masks */
-	KUNIT_EXPECT_EQ(test, 0x0000000000000001ull, GENMASK_U128(0, 0));
-	KUNIT_EXPECT_EQ(test, 0x0000000000000003ull, GENMASK_U128(1, 0));
-	KUNIT_EXPECT_EQ(test, 0x0000000000000006ull, GENMASK_U128(2, 1));
-	KUNIT_EXPECT_EQ(test, 0x00000000ffffffffull, GENMASK_U128(31, 0));
-	KUNIT_EXPECT_EQ(test, 0x000000ffffe00000ull, GENMASK_U128(39, 21));
-	KUNIT_EXPECT_EQ(test, 0xffffffffffffffffull, GENMASK_U128(63, 0));
+	BUILD_BUG_ON(GENMASK_U128(0, 0) != 0x0000000000000001ull);
+	BUILD_BUG_ON(GENMASK_U128(1, 0) != 0x0000000000000003ull);
+	BUILD_BUG_ON(GENMASK_U128(2, 1) != 0x0000000000000006ull);
+	BUILD_BUG_ON(GENMASK_U128(31, 0) != 0x00000000ffffffffull);
+	BUILD_BUG_ON(GENMASK_U128(39, 21) != 0x000000ffffe00000ull);
+	BUILD_BUG_ON(GENMASK_U128(63, 0) != 0xffffffffffffffffull);
 
 	/* Above 64 bit masks - only 64 bit portion can be validated once */
-	KUNIT_EXPECT_EQ(test, 0xffffffffffffffffull, GENMASK_U128(64, 0) >> 1);
-	KUNIT_EXPECT_EQ(test, 0x00000000ffffffffull, GENMASK_U128(81, 50) >> 50);
-	KUNIT_EXPECT_EQ(test, 0x0000000000ffffffull, GENMASK_U128(87, 64) >> 64);
-	KUNIT_EXPECT_EQ(test, 0x0000000000ff0000ull, GENMASK_U128(87, 80) >> 64);
-
-	KUNIT_EXPECT_EQ(test, 0xffffffffffffffffull, GENMASK_U128(127, 0) >> 64);
-	KUNIT_EXPECT_EQ(test, 0xffffffffffffffffull, (u64)GENMASK_U128(127, 0));
-	KUNIT_EXPECT_EQ(test, 0x0000000000000003ull, GENMASK_U128(127, 126) >> 126);
-	KUNIT_EXPECT_EQ(test, 0x0000000000000001ull, GENMASK_U128(127, 127) >> 127);
+	BUILD_BUG_ON(GENMASK_U128(64, 0) >> 1 != 0xffffffffffffffffull);
+	BUILD_BUG_ON(GENMASK_U128(81, 50) >> 50 != 0x00000000ffffffffull);
+	BUILD_BUG_ON(GENMASK_U128(87, 64) >> 64 != 0x0000000000ffffffull);
+	BUILD_BUG_ON(GENMASK_U128(87, 80) >> 64 != 0x0000000000ff0000ull);
+
+	BUILD_BUG_ON(GENMASK_U128(127, 0) >> 64 != 0xffffffffffffffffull);
+	BUILD_BUG_ON((u64)GENMASK_U128(127, 0) != 0xffffffffffffffffull);
+	BUILD_BUG_ON(GENMASK_U128(127, 126) >> 126 != 0x0000000000000003ull);
+	BUILD_BUG_ON(GENMASK_U128(127, 127) >> 127 != 0x0000000000000001ull);
 #ifdef TEST_GENMASK_FAILURES
 	/* these should fail compilation */
 	GENMASK_U128(0, 1);
@@ -129,21 +129,21 @@ static void genmask_input_check_test(struct kunit *test)
 	OPTIMIZER_HIDE_VAR(w);
 
 	/* Unknown input */
-	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(x, 0, 32));
-	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(0, x, 32));
-	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(x, y, 32));
+	BUILD_BUG_ON(GENMASK_INPUT_CHECK(x, 0, 32) != 0);
+	BUILD_BUG_ON(GENMASK_INPUT_CHECK(0, x, 32) != 0);
+	BUILD_BUG_ON(GENMASK_INPUT_CHECK(x, y, 32) != 0);
 
-	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(z, 0, 32));
-	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(0, z, 32));
-	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(z, w, 32));
+	BUILD_BUG_ON(GENMASK_INPUT_CHECK(z, 0, 32) != 0);
+	BUILD_BUG_ON(GENMASK_INPUT_CHECK(0, z, 32) != 0);
+	BUILD_BUG_ON(GENMASK_INPUT_CHECK(z, w, 32) != 0);
 
 	/* Valid input */
-	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(1, 1, 32));
-	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(39, 21, 64));
+	BUILD_BUG_ON(GENMASK_INPUT_CHECK(1, 1, 32) != 0);
+	BUILD_BUG_ON(GENMASK_INPUT_CHECK(39, 21, 64) != 0);
 
-	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(100, 80, 128));
-	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(110, 65, 128));
-	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(127, 0, 128));
+	BUILD_BUG_ON(GENMASK_INPUT_CHECK(100, 80, 128) != 0);
+	BUILD_BUG_ON(GENMASK_INPUT_CHECK(110, 65, 128) != 0);
+	BUILD_BUG_ON(GENMASK_INPUT_CHECK(127, 0, 128) != 0);
 }
 
 
-- 
2.39.5

