Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BEA4D90C6
	for <linux-arch@vger.kernel.org>; Wed, 21 Jan 2026 14:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007495; cv=none; b=uZO08O8ekgD7HLrb+5YHRLl455ohJEIMYt6qOZNi3t1TjHnJgf3UFtEG2Yf6yHOrhfYe2ZJsoijilB/S6OKP6jM+TZPTMX8geOse6GjEfNVI207Z1Hh2jLgfnghqXPSzjZFO9pi+iXdsTI728iLb3TyReC806jG4rmEQ5FQUcsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007495; c=relaxed/simple;
	bh=WLWZVpeZhx+DAeWbAnRY6lcMK6WxhnXbv31m9woOk6g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eFRy68I4s9H7sSKwC/4N9QjNupXI0Npfil4jpVQvBltuyIEbBsX/NUFBBxOZy99gPc9BJJykS6v3N97TRTTl5a2wW3gsLeRhZv8LBclxXd17R0srKFl0D0QWngf7xaBo4ztPuOKYh5mCKzzgWxRAA26e/lzMIoZBPqaoJNz13fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=vr0CBPMR; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="vr0CBPMR"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1viZen-008XDM-QJ; Wed, 21 Jan 2026 15:58:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=cF43fDD/g1BgXHMaIGGBWzL2e37s8+SbQXJh1FJtOkY=; b=vr0CBPMRBRE+lctEWWosrDIQZG
	z3juNwE4hOINU5wiKjyzCNEMuKgO09OkDRks9znM75u5Ne7WXSFdoPzwIuQlwVhV6jkAsdPvxslTg
	gTgWnzPznfOW0OlPzmhiTK69V0hki0sI873zqRx+H2RrQY88brR14ATnQuo2GLEH2odmKsOiwUPZq
	39O9HEEPdo+SRgnCkA1PvvV7GbShnjFOjWY5eEmFlueEXWCGAYsJH/EpgdqSABBXJHQRbdw2vu7QA
	tTlFEfNva1z7tEvGneXL9RmhW+nAlmeoPantOXbe+Fo1HYO4dvRwh8JIsCXf7kEWNwrJn+ORg8MXL
	bLelEwsA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1viZen-0006qK-BQ; Wed, 21 Jan 2026 15:58:05 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1viZeW-00GH6h-Rn; Wed, 21 Jan 2026 15:57:48 +0100
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
Subject: [PATCH next 08/14] bits: simplify GENMASK_TYPE()
Date: Wed, 21 Jan 2026 14:57:25 +0000
Message-Id: <20260121145731.3623-9-david.laight.linux@gmail.com>
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

Since the type is always unsigned (T)-1 is always the correct value
so there is no need to use type_max().

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 include/linux/bits.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/bits.h b/include/linux/bits.h
index a40cc861b3a7..697318f2a47d 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -45,8 +45,7 @@
  */
 #define GENMASK_TYPE(t, h, l)					\
 	((t)(GENMASK_INPUT_CHECK(h, l) +			\
-	     (type_max(t) << (l) &				\
-	      type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
+	     ((t)-1 << (l) & (t)-1 >> (BITS_PER_TYPE(t) - 1 - (h)))))
 
 #define GENMASK(h, l)		GENMASK_TYPE(unsigned long, h, l)
 #define GENMASK_ULL(h, l)	GENMASK_TYPE(unsigned long long, h, l)
-- 
2.39.5

