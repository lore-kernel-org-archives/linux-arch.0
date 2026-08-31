Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1DB3ADB9A;
	Mon, 31 Aug 2026 03:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788145751; cv=none; b=WHNNsBR+oD4FlIzLYg7HR2W7GEWQB2DCOoz01YLhh/9yCiFlwGxGXcHKEfUwAlh5nOOpX2J2SL9G5R9K3UAhDpNRLODdes2B1fklIg2/bIe0hfZzvBXxYoE16gGKTmVGvCzZCjDLu9wvz45BdPiufY0+U4G5gesHRLgx0C1Bye0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788145751; c=relaxed/simple;
	bh=CUbQfdbyq7R23MeWnNEu1E8xlWBPZJQYk2JgegOi2To=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a5i4u1pZKaAiSbYiGDjtHHR3C/X1fn+0XoiNaeneVtoc+I3nazjb7GuI86vDZrGkGvQQP/cBhRR/F0zcrdJkDSCPcLHG9mDq+zu1xH61xFuxUTvCeOxYFHUodkKCKErK/wTOFAr6USRNrxyMP91pb1Y20zpwrMRrjoLPgtDSliE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xDq0EOax; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xDq0EOax"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=QMfqfKuTpQEi9KIbPFYLpP5i5zJwVhqd8NZNDa3+KrE=; b=xDq0EOax4RU/QfajlbFem0utHv
	/wahVyDg0npB8FJoczjJoJOeEYjwRTlaRKs+dAt7a423NTPZlP6nKauE6szo9eOLVoYWmLd9xDdo/
	3uccUv0L/75BK8zpHuTY/FvCaw1RKyYC231CCn8qW1zzpsooqYU+6lCkUpH0I6GzhWYgJL2WctBRS
	FvwnX/Grgxn90kaIakV6rIZLHKyuWRYCN18+OxeCqm0m9MNLgHyNAYamIISIE59+psw73U6c+6RO9
	bAgtCUS3cF9NjHUEl4U2KrkKe+rpzZt1flnGtGs9n8xy3z83Hjcjihm7Mno5h2fFUpqbgg7mqAtng
	nx/jTCNg==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0sOI-00000008O2i-0vla;
	Mon, 31 Aug 2026 03:08:58 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3] asm-generic/io.h: fix grammar typos
Date: Sun, 30 Aug 2026 20:08:57 -0700
Message-ID: <20260831030857.3399070-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct grammar mistakes.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
v2: rebase & resend
v3: rebase & resend; add Andrew to Cc: list

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>

 include/asm-generic/io.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20260828.orig/include/asm-generic/io.h
+++ linux-next-20260828/include/asm-generic/io.h
@@ -1113,12 +1113,12 @@ static inline void *phys_to_virt(unsigne
  *
  * Architectures with an MMU are expected to provide ioremap() and iounmap()
  * themselves or rely on GENERIC_IOREMAP.  For NOMMU architectures we provide
- * a default nop-op implementation that expect that the physical address used
+ * a default nop-op implementation that expects that the physical addresses used
  * for MMIO are already marked as uncached, and can be used as kernel virtual
  * addresses.
  *
  * ioremap_wc() and ioremap_wt() can provide more relaxed caching attributes
- * for specific drivers if the architecture choses to implement them.  If they
+ * for specific drivers if the architecture chooses to implement them.  If they
  * are not implemented we fall back to plain ioremap. Conversely, ioremap_np()
  * can provide stricter non-posted write semantics if the architecture
  * implements them.
