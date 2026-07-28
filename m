Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61945224AFA;
	Tue, 28 Jul 2026 00:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785199593; cv=none; b=d/o5hXoNKzjQiNrO4EGSmd92ZTDaKU3AgBQpCmg4b2uB5geMhkEp7OR1DVduHxbE2bKqoZw2W/uxKQRXvd+d3b85DPhetpxbABU8TX5IF880yb/6J0rZnZy4AYdHtn90cWXUrOvHp7JXJRlj6eboqQc0a1hnvkFoa64jJ4YAtY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785199593; c=relaxed/simple;
	bh=fMKND5BIm92sO0cyQtth5HiVTYAezzOca8/SChQyr98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EylAxfn1oVEv036axQsUMMw0J550WOtjlgvPg0n4hR6j4Sp//9NUeb31s3iBqGStCUlp2N0Mg+eoZCiDQgr0VLepo95CPJbW3JqmFAC50iL3xqnvGvbZ4Fll0YSz8dA0jfhtDhAFAboP+PkOl1wt4xKMOCL8D3QUtVndtGo4N/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=J8mPcxD/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J8mPcxD/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=kvuVCndANX+6VEDxoV2y1xNquhZ/XZOHsz9GsGWGdJg=; b=J8mPcxD/01U5E/CzYC3AX5U0py
	E1VvAYrNtOnr+yuFky0AqNXjaWhT99EvLpSOpEZQ5/6wz01FqV0exbd5WoofsZ0RVV1W4VRYikS7P
	MAQYeOH6tOY9o2ybjSw1tbPkbe//gEaALqWK/7XGEVGYAHCTrJyYPaSM+LCV3jLK9QKBiMmCrlR5h
	QmM4nJCPj6U9LnL2t8/rTUNqsmyZx/hHJvrdUx2s6v8uyoJbzOD284utbRlmYC9i1QVVs1Z0KFtgO
	R+I52h6srnvLFLwVDYrdlI79n4vWp5AFYzvyun2cuP9V7R5vXr5L8Lo6kZ6g73b7lkre6pwHnuQTM
	b1PjhP6g==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woVxl-000000049Rb-48Fw;
	Tue, 28 Jul 2026 00:46:30 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org
Subject: [PATCH v2] asm-generic/io.h: fix grammar typos
Date: Mon, 27 Jul 2026 17:46:29 -0700
Message-ID: <20260728004629.899157-1-rdunlap@infradead.org>
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
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
---
v2: rebase & resend

 include/asm-generic/io.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20260727.orig/include/asm-generic/io.h
+++ linux-next-20260727/include/asm-generic/io.h
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
