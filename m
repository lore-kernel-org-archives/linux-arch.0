Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06284DB545
	for <linux-arch@vger.kernel.org>; Wed, 21 Jan 2026 14:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007500; cv=none; b=BNHjx0/Y4evGj5Iv7Scta507RcOwlStenbLLrJ3TtMjfrDEEJTdamZ5vDre2DyYLr7B7PnrotUCaPhuW7TKbF1mlkTUI8X/UOzehbQGHUeApOVrx+Y6f51QcBr4AQoRWAjbx7mb72ZvbBFfKUK58LUdOj74+EAetE8YMUtBOzcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007500; c=relaxed/simple;
	bh=FCdBQZWdHf1xz/vTnMEdIXZEqr+wf1tzdzM9W6byHso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CcM8l1tGxapQZjQHnNfo0z+ubqLOLmz2v2/4+Q4X13Pwr+c+uv8tqYZjkldLpnRf6boNF6lL1Yw8axhm9iJFbSwf5LNJSKY+N61FFYe2Oi28bRDZ66souXC9TwDW8geKJV3KaPp5pF7YSna6aae+Ma8pce/qBXXWTF3vmTf9vLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=XSDNZIi5; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="XSDNZIi5"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1viZes-008XEe-8C; Wed, 21 Jan 2026 15:58:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=hJGbMvfP6awI5d5SmhxetgsrjF7ICeJkS4xNExqiD7w=; b=XSDNZIi52k9PTUjt93fTkefYnJ
	aRIMMgME/yim+sQhk6KpuvIpQp4TkTNSW2w2DfwvdC9s403+iQTgHVIjvYbnf4oN0T4HXznKDTcem
	UyOdZwrD06TyvMvQnoFFWzDl8DEUO5Acn9s7ezfgivXBTP29/i41IofrMuoHI0y6nb9b+2Yb/nyT8
	j7vE9k1g+WHCv01oIdpssVIwD7q46jeaAvhiOIQv3UCQdiGOXknmPWCPi21sJZ0GUnkWYrFl0D10c
	hAltNDFvzR5PqFjQCqaeSWYiJfEUeaed3pL4I1dJWQFPLFBBUUUc98T2uxkNDzhvpzcTfjkZaXrD5
	8KOKrDRA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1viZer-0006qk-NJ; Wed, 21 Jan 2026 15:58:09 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1viZeV-00GH6h-Mc; Wed, 21 Jan 2026 15:57:47 +0100
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
Subject: [PATCH next 06/14] asm-generic: include linux/bits.h not vdso/bits.h
Date: Wed, 21 Jan 2026 14:57:23 +0000
Message-Id: <20260121145731.3623-7-david.laight.linux@gmail.com>
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

thread_info_tif.h isn't part of the vdso, use the linux/bits.h header.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 include/asm-generic/thread_info_tif.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/thread_info_tif.h b/include/asm-generic/thread_info_tif.h
index da1610a78f92..afdc23204674 100644
--- a/include/asm-generic/thread_info_tif.h
+++ b/include/asm-generic/thread_info_tif.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_GENERIC_THREAD_INFO_TIF_H_
 #define _ASM_GENERIC_THREAD_INFO_TIF_H_
 
-#include <vdso/bits.h>
+#include <linux/bits.h>
 
 /* Bits 16-31 are reserved for architecture specific purposes */
 
-- 
2.39.5

