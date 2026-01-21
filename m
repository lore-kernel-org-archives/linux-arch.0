Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F9046AF08;
	Wed, 21 Jan 2026 14:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007488; cv=none; b=D3t3ZXRXr1ZazuhKl8XcfcrGuEeEw31RpFjFJLUmJIPhW6LeLVWZDf+tQoboYwEhqhE4uIP7AlevCOchwwvKN4XqgnqSQwZVSFv6U+ahr0UXDbu6tbQC2tIEtm+gZfAwGl2uJ9CMy/Q4XIEuXC8vkY3uFXDKr8FU0sg/84e5sGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007488; c=relaxed/simple;
	bh=OA02ELFmnpBDdrGrXQuvFuiTkYOKMCAqIO8bG+Pl/e4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iSQHQM4D4B0goLSxV4R6xUTzYPkp4Y12WxFrIdzu+kYiqxQ7Ffcc5kWJYKAjI3eA7dSUhtr4XS5BPi1QtgtyD0nDT5l0PlSosbSNyNGDQilMCQKIhRqEkOhMdXUg7wVy2T3DkunigO17iQR8+FOYwxyYadAjGZG/WgmuAB06WrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=bwCgj4UW; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="bwCgj4UW"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1viZeV-008Pd7-QC; Wed, 21 Jan 2026 15:57:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=DxIhPg/CrbU4/R5zWg9CgbE9VAZfvxZOQr4uB5RIp+Y=; b=bwCgj4UWCr20Pxcet9xGPzvypg
	+FG6Vowg31CoGVzLsFmzg2bfeYiVSbUioPFODND4CYg3RaFQ2U8W5eGeuHvkUeNSpHQ9gNFm0JiSA
	KB9EydKlS6hMTlAJVMsxsp71OFE0+eo1S2p/EqVnlExVTz0NE9yqMkuigo/nlN0KMimQONboeJIqO
	/lCOsCHR6jl9pzizM7Jtm1jI8nxXHYMV254l1UnM1CY1iE2SFWOKCxXsbS0xbnBBN/y0PhGG2P9SZ
	nkBIAbcSXpPUHCJBDi+XeieoT3FSskZiTer2osCLW3evkvRCzYO8jKeADssVvy9H3bREo7xRGGgJP
	jmP9tE9w==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1viZeV-0006kf-Bf; Wed, 21 Jan 2026 15:57:47 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1viZeS-00GH6h-IM; Wed, 21 Jan 2026 15:57:44 +0100
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
Subject: [PATCH next 01/14] overflow: Reduce expansion of __type_max()
Date: Wed, 21 Jan 2026 14:57:18 +0000
Message-Id: <20260121145731.3623-2-david.laight.linux@gmail.com>
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

Change '(x - 1) + x' to '2 * (x - 1) + 1' to avoid expanding the
non-trivial __type_half_max() twice.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 include/linux/overflow.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 736f633b2d5f..4f014d55ab25 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -31,7 +31,7 @@
  * credit to Christian Biere.
  */
 #define __type_half_max(type) ((type)1 << (8*sizeof(type) - 1 - is_signed_type(type)))
-#define __type_max(T) ((T)((__type_half_max(T) - 1) + __type_half_max(T)))
+#define __type_max(T) ((T)(2 * (__type_half_max(T) - 1) + 1))
 #define type_max(t)	__type_max(typeof(t))
 #define __type_min(T) ((T)((T)-type_max(T)-(T)1))
 #define type_min(t)	__type_min(typeof(t))
-- 
2.39.5

