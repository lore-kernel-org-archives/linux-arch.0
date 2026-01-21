Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8ADA4D90C5
	for <linux-arch@vger.kernel.org>; Wed, 21 Jan 2026 14:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007495; cv=none; b=ulOwinpt8c3ellf1qKteEroS8aFvboSWpVS9TCZ5DsivJOg5WyxNOep7bdcRroZg8U3ZgHCASwLoFhNro41VVHCiInIZrbTqLH1Kyt1ovkRvlXpSdlNDRrWYhbZuamOWuGlNnLR4L85M/DtkdU6HV0XebdubWPaTMCtNCpmzx7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007495; c=relaxed/simple;
	bh=gi0nk5NkqUvAm05qNBkzD1OrZj3hVKAmw95hlk8CKFY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p5JzIF4Hkqf7dkompZD8otnq4tmjnC3fu+yMzgLBHwPSUdx/pYN2lE80wk3jMa32eQlUZAIuyE1prFvLrPu3LOVobF2KwtXbINYejt8sDD/ZsbPEhUfes6iBIYZKsX3njreOah75CevBjlUXTyQMGXcPc1gJtNyB14N1MUz5DM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=kguTAMzC; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="kguTAMzC"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1viZep-008XDo-6f; Wed, 21 Jan 2026 15:58:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=Ru1DgE8CQ/ycviFbDjOYAl+7Lss1ZyJkmQPVcZDGOIc=; b=kguTAMzC3fq+S8TPapXM6ZaOS6
	Pg9VKbJZpPW30odB+GQfnTAnyAYFlKtMApqAsyJQVLul9QrisKRbwFcTOp47TW+wFS4Lw9ErTEw9o
	o3Iobf5eLgCT8N2PcJMtaRwAbYESGZ712bksDUo8kSIcDNr8/H4iZKsf89SfE84++guL/TlHBRUk2
	nWPmIDpZoHBmG6oCNr4Hz5KHXA3W2h2jpx1uS0oA6nmllfSfZyLQXfgdOlFuSoYoFasQlE7drNVmo
	f2brUkybeJqdezD5MXVJx5CB2TcRLHqSyWhynl+SgdAV1keBRdICGvg2Yq5ntULmcL7X6dsxozWXC
	A1xS7iFQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1viZeo-0006qW-O4; Wed, 21 Jan 2026 15:58:06 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1viZea-00GH6h-CT; Wed, 21 Jan 2026 15:57:52 +0100
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
Subject: [PATCH next 14/14] test_bits: include some invalid input tests for GENMASK_INPUT_CHECK()
Date: Wed, 21 Jan 2026 14:57:31 +0000
Message-Id: <20260121145731.3623-15-david.laight.linux@gmail.com>
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

The check for invalid 'compile time constant' parameters can easily be
changed to return 'failed' rather than generating a compile time error.
Add some tests for negative, swapped and overlarge values.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 lib/tests/test_bits.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/lib/tests/test_bits.c b/lib/tests/test_bits.c
index 4d3a895f490c..9642c55f5487 100644
--- a/lib/tests/test_bits.c
+++ b/lib/tests/test_bits.c
@@ -144,6 +144,22 @@ static void genmask_input_check_test(struct kunit *test)
 	BUILD_BUG_ON(GENMASK_INPUT_CHECK(100, 80, 128) != 0);
 	BUILD_BUG_ON(GENMASK_INPUT_CHECK(110, 65, 128) != 0);
 	BUILD_BUG_ON(GENMASK_INPUT_CHECK(127, 0, 128) != 0);
+
+	/*
+	 * Invalid input
+	 * Change GENMASK_INPUT_CHECK() return 'fail' rather than
+	 * generating a compile-time error.
+	 */
+#define GENMASK_INPUT_CHECK_FAIL() 1
+	z = 0;
+	BUILD_BUG_ON(GENMASK_INPUT_CHECK(z + 31, -1, 32) == 0);
+	BUILD_BUG_ON(GENMASK_INPUT_CHECK(z + 0, 1, 32) == 0);
+	BUILD_BUG_ON(GENMASK_INPUT_CHECK(z + 8, 0, 8) == 0);
+	BUILD_BUG_ON(GENMASK_INPUT_CHECK(z + 16, 0, 16) == 0);
+	BUILD_BUG_ON(GENMASK_INPUT_CHECK(z + 32, 0, 32) == 0);
+	BUILD_BUG_ON(GENMASK_INPUT_CHECK(z + 64, 0, 64) == 0);
+	BUILD_BUG_ON(GENMASK_INPUT_CHECK(z + 128, 0, 128) == 0);
+#undef GENMASK_INPUT_CHECK_FAIL
 }
 
 
-- 
2.39.5

