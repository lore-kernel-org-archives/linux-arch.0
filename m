Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5D94766AB;
	Mon, 12 Oct 2026 16:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791823409; cv=none; b=HhGaCnUqdwCUQvdXD/ybDjoOiL90V/dODvsCYQ410wurKR1hGW6fviPIGrm+tZL0q2p3r1XvcghaudlY2OojOnxCZhDF0Evk0JqA4WNhUMuwUXPQBCcVXEdbW0Eao5Y8W87sFF+CIT90fBcdn+hQtYLN8HRxUtM7fmn5rKLhmq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791823409; c=relaxed/simple;
	bh=3pFcRLkZVN6ELENgKajurMX3fLP9P/C1SQ9iKSWON64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LS69TFvoLXyCV/nberlsthb3GFxJsJgk8XdFqIBNvImTBHI6VnXNpMfJCsMxNZe7oCKng8Gysf/HkcFPGXWCbUxKvnp4FkA+dh6E1yEt72O4q+eGeMlCkaqk4Ffyz9cwJp75XUGzRdiLrHTzUhrwb6U8fHzKIb/QGzqZvT5FN94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VQJZpQev; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VQJZpQev"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=870eKMajB2DYx6K/7FSEPbIv9AYfZpTly12wWbb1oM4=; b=VQJZpQevV5g7uKJAmsBcUv9ob4
	sgoAspNXDzInLaAiCxR6GWNsZqnN9eMrevf8yXZDYa7gryDD7D7s1dMG5pV6Rlh4MsIYeTNJxb+cy
	IldG6TDgttjwV6AHUKfU8ATaNhVVtPY+FhJBAnNVDn01HjcZIVoJY8/wDi2uulztxNKWKBP2bJv3X
	YGJRgvq7LWbWYPksw0I+GYFL+yjQ15+Ly9MeahjyIQBf0rZi9qICmW8lr96tkk8Of/zSjzbKWsTIc
	Ly0Hc9J1H+P+CFPW1RgpCmqWGC7ywZ4ihLuX0QZPRLrOug3WgqSzJH7JyOQ4/KuvLPrZIo3Hw3hqr
	S3I3Rv+Q==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGJ7X-0000000Azr5-0TY7;
	Mon, 12 Oct 2026 16:43:27 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v4] asm-generic/io.h: fix grammar typos
Date: Mon, 12 Oct 2026 09:43:25 -0700
Message-ID: <20261012164325.680091-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.56.0
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
v4: rebase & resend

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>

 include/asm-generic/io.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linext-2026-1007.orig/include/asm-generic/io.h
+++ linext-2026-1007/include/asm-generic/io.h
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
