Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245FB4A2E18;
	Wed, 21 Jan 2026 14:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007492; cv=none; b=IYhkaxUt0VBjrE+PmyTpgJJgJFKydsyux6g8y2h+ew9jVPCYMc5cz3hj3XnAkc3z0pnkakuj/tm1wJgtuEKkFEr7s07eVBhSAm2G55NiFB+Ut349Vm2LA8Zv7NDv15M12c+Q1jOJNBPb3BZC+KhVquNdlpEldQE+cHZxuTXfDpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007492; c=relaxed/simple;
	bh=JlyCbBO/oW/tetnWdx5yD/0V4biAgpc2VSyHl/0RTW0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X2U4dBl/zc+f1FFg090usXYXYZcYL7hAqZxXLzBSPtBATgCbu9X2GdLtC6PGOewe7O1r2kyVtoLDUdEz7oklikSMdbkZokVU1+5tkYRSFiUNFRrzdapqYGYwr19WBK2iN+5bs3pMnvIi+EK0xUHA9uhHutTG/U+vXoVJ2ayh8UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=TQpTqX20; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="TQpTqX20"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1viZeo-008PiQ-Mt; Wed, 21 Jan 2026 15:58:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=WM4AW6T2eDyt9U4IgVqebjKOg5YLOCiW8yPgHypoOSI=; b=TQpTqX206asVFeUievc6JJj2Ek
	wqM7hs9wGnUIBcVPffkgPJu35kJBxxzsR6ggD4iCy8WkxMilxNWKv+q0fl22fysXKLxuLkDUEej3Y
	2hDCPBx0icb4re8+5jeccNdZ/26VGRObehh/+WDHThfk8Q824W8M3ulRBNKEx5mn3si3Pbh4MifXH
	tcFJB3rT6sHgFWa3yTGmxxWpiGX7K8XJmhqNwe+xpsdDh5J/E8HZiqe9hRZeN+t5LMoKnoJOSUUJH
	75XjD6uzEhHqsYD/zEeIIPTOEi4GJHc5kZFD85Rx0SxFOXnX4Rk8ZLcdJlDTnCtlh2hikrq7v21KN
	PtqXaVcw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1viZeo-0006qQ-8M; Wed, 21 Jan 2026 15:58:06 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1viZeU-00GH6h-CH; Wed, 21 Jan 2026 15:57:46 +0100
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
Subject: [PATCH next 04/14] media: atomisp: Use static_assert() for sanity check
Date: Wed, 21 Jan 2026 14:57:21 +0000
Message-Id: <20260121145731.3623-5-david.laight.linux@gmail.com>
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

Compile-time tests being added to BIT() make it an 'integer constant
expression' rather than a pre-processor expression for W=1 builds.

Change the FRAC_ACC != BDS_UNIT test to use static_assert() so the code
compiles.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 .../kernels/fixedbds/fixedbds_1.0/ia_css_fixedbds_param.h    | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/isp/kernels/fixedbds/fixedbds_1.0/ia_css_fixedbds_param.h b/drivers/staging/media/atomisp/pci/isp/kernels/fixedbds/fixedbds_1.0/ia_css_fixedbds_param.h
index f7e5669d5125..31bce7b2650e 100644
--- a/drivers/staging/media/atomisp/pci/isp/kernels/fixedbds/fixedbds_1.0/ia_css_fixedbds_param.h
+++ b/drivers/staging/media/atomisp/pci/isp/kernels/fixedbds/fixedbds_1.0/ia_css_fixedbds_param.h
@@ -13,9 +13,8 @@
 #define BDS_UNIT 8
 #define FRAC_LOG 3
 #define FRAC_ACC BIT(FRAC_LOG)
-#if FRAC_ACC != BDS_UNIT
-#error "FRAC_ACC and BDS_UNIT need to be merged into one define"
-#endif
+static_assert(FRAC_ACC == BDS_UNIT,
+	"FRAC_ACC and BDS_UNIT need to be merged into one define");
 
 struct sh_css_isp_bds_params {
 	int baf_strength;
-- 
2.39.5

