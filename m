Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDDA4D90A6;
	Wed, 21 Jan 2026 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007494; cv=none; b=nfzoDamFEzDHFwl8q5QaYTXDJ+tLYs+DvQNELX4zZc+QDRVFZVHYfVpLGHxovnA9forhEojRYZRmvq3rr75oz0dZRVRfylZPKQfai++gwQ1jBDHOsLAe5E/yd8y8eXDy4HERTBh1WTPZmMuib/9mbqx/vzA/rGbDkOOMTNjK4sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007494; c=relaxed/simple;
	bh=KfKTerWE4WB0dhSUpbGy/FH9has/LNkq3+TZTkpYEn8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jCGgHyd6NJn/qVcS15Ggyjp0j9SxCDdVSfwu752Ws5xmPxzw/fjsl/6SA5rjXpKIfjUOQdIFHJyBzhyj2gSY1BXlJDQ61o8m4F/PFFQam9bolcw+fG8ufLCiis1vgA2Zk9nWE6UL5NAE7gaCvpIm1w1LMvLPCv2T9WbfCGG6Ozk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=hAL/R/1+; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="hAL/R/1+"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1viZen-008Phe-BZ; Wed, 21 Jan 2026 15:58:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=pS7N/XfIeq0Cy6irt5k3pB4HIbS7v7ivLocvksuTg0k=; b=hAL/R/1+gSyvjodvTSSNzdvFYR
	Qq2WbRIF3T6jUB5ahMOwjf6kQvtBwtZgdrctgzh2I1+IALjSiYqqmo/z3KiYBI8OwB0Kvyk2GfO40
	Pj6DjXF1BpIJMCnE4CSa+xu8rIIl+WRFgSoERAqOrtRDhKj0YoJzsJsd5eZQ9CyJg1i3skRiBHp+J
	TlINDErSMOGFWEz7+wK3REZUFC4liAMCpEeUBWeyGdlSOLGPs3PsH090gEN98qlX3xkXF9ziIpwXT
	XrWizY1cDI8ou1VfXNlh57LnFwTkBNOaKYkuFOXKpWfR4nDf/xn2Y/p6if7aLjyf/mpp5xFtnDS0t
	ErJiTTHw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1viZem-0001sE-RS; Wed, 21 Jan 2026 15:58:05 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1viZeW-00GH6h-9G; Wed, 21 Jan 2026 15:57:48 +0100
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
Subject: [PATCH next 07/14] x86/tlb: include linux/bits.h not vdso/bits.h
Date: Wed, 21 Jan 2026 14:57:24 +0000
Message-Id: <20260121145731.3623-8-david.laight.linux@gmail.com>
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

asm/tlb.h isn't part of the vdso, use the linux/bits.h header.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 arch/x86/include/asm/tlb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index 866ea78ba156..e61c6de73e70 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -7,7 +7,7 @@ static inline void tlb_flush(struct mmu_gather *tlb);
 
 #include <asm-generic/tlb.h>
 #include <linux/kernel.h>
-#include <vdso/bits.h>
+#include <linux/bits.h>
 #include <vdso/page.h>
 
 static inline void tlb_flush(struct mmu_gather *tlb)
-- 
2.39.5

