Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641133;
	b=0dcW0hYWcn7kJG1qsCM7kCoRoFYBacCdJzRfUneqWm4Ga5XZylQklbxvafsSo92zbrjM
	 besQiPr9w+ue9hFEhezj5L8NlgK7IIjLYraNdINslz/IIfHZz3LmYiu+4Fbgxgqj3bAi9
	 I+e+2TPpuh4ke/yHSTmwlqdb7MutWg8BuOAEd/0OLQSKwAY8CnEoA0H9TM1DUPUZDetZ2
	 jtcu1xW5yUQylkgcW5jyYN1ptNvCpSGTTIAqx1Uyn7SPSmLqFeT/ZXrNfaz3gO3sI3J8U
	 AyBj577AnyVT6QS/D/8LAN+coKhKXsl+VXC/96x61hcCwd4rZBbr8ab3yfhpMYMbL4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641133;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=870eKMajB2DYx6K/7FSEPbIv9AYfZpTly12wWbb1oM4=;
	b=ML0g+nKNE+xT9Vrn0Rkxez3qFh9xm/H4HOAhJ1N7tsNfwyjmlCJH0MWEVRPPIabnPId8
	 J+8ZTJOj6ku+LAuU0OCSnQydjxN3bTi1eK35neoPh2LHW0vF26fIv2pI1zi1bWKFvPje3
	 tDokhzNx50Ybm31X+WyVK2lY1dMGB+BSNVLaqKW8bYZm5fhKRAPu92bmgGJQHombnJcWv
	 db51hFEdp8vXuI39f9EQD8Iscs+ACKhTgULPnYo6hrQnzObFt3iHb1jiW9QK1CHTbAkcz
	 eQ20ZPVyAbLzZOS+7uGF+W7NcZUixKj/qNuJbYyE/2bithoJF1HuyyT/9AlrWbyJqaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=S0ADRpOH;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D575E606A90B;
	Mon,  2 Nov 2026 17:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D575E606A90B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=S0ADRpOH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=870eKMajB2DYx6K/7FSEPbIv9AYfZpTly12wWbb1oM4=; b=S0ADRpOHweom0GvuJE4YabJH8D
	9G6hlvYYPRmBZuM3yDl2p4Q215EabzEhUkcw0IRmKxQp6vH+1p3mTKsLc8fivHX8o3bN4NQ4Ukrrv
	VFlwDQmzxT6DAFh7LQnQcxSQX07tMbNK3fVtJSrLzVZIF7DeBxN2Osky829fPz5izt1upo9CUuqUm
	5zcif4eqEeu3Wgj1MC9SRsjabmqfR9Q84rMY83Jkeminnw4PX1NOlBHy49McUBm5HtRXDMwU5pKh0
	tqpJVnwZWZK/5RvJXTdQHhmDprMDbSJ34RciBgts+sAgjbHj+1OnTFScGek6kfQpTZWXDnH2XKMIL
	XCAf8PpA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNvzg-0000000HUL3-1178;
	Mon, 02 Nov 2026 17:38:52 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v4] asm-generic/io.h: fix grammar typos
Date: Mon,  2 Nov 2026 09:38:51 -0800
Message-ID: <20261102173851.2232734-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
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
