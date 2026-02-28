Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD88364E95;
	Sat, 28 Feb 2026 07:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772263073; cv=none; b=LsMG+vvFrYFoGyGOrR1DdpfQmC32S07qKRe1/tWZixPi0KfwFy5D1AAEcNWvIHt7XLG6n6Xg9a0NwTepzlTmZbaPEdD3tiiOo7RiNretkWKftp1tZ2DYiRdoQMGo2PaQG9B2e0ajbBMtgycxpsqlqDF/wlQB1igEXx9VGk00xgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772263073; c=relaxed/simple;
	bh=UO6MrxOlZbFkWth1QqRjrpd7uVJ0zXvU1AD2+8QH6tk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N8kOOJ7ciHgBI7SVuPJ8eo5qmQqRkn3ZkHzHZa/tX+7tUbPrLRw0BqMkWSZM1RnIopiu17uR13SJWu1DTJo76bUXunm5F68BAjZHZ+BKRokF5DVjO8DWZgAhLoSD1eNhGy5bUZ0HslXoWAPDV97TOPDbp7Oudr6ODRLRGaeqdvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OCKkX2mz; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OCKkX2mz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=KK7uSiBcvrLCDEPkOoYlLSm4mGeUwH1oWVxPEVDRlK4=; b=OCKkX2mzwYcYwMKgbvxZqCJth8
	U4IbSAHKGSTccC+f1nlWlewNiC2SsVVPbibWePG7rajQ6cvJZdolzPksNrdoQlYk1cbS1cEsvw4Z8
	36+1XgBgAEgmXM+iImMbj/5gY3PVjc5+mYTepelBrlV6to2WCPhXl7HBIZ4FhxzcxfdBz9tFDxZyn
	buIaYI5rTmjnk6TPYUl4g2elrNznAc5cqGjfYqcbhCS/X8kCvd2yjQyfKLdFUqR+bL4XVt3klM2mE
	X0UZePxzVi5QXRTEWYkV6T4Lwm2zVUIsC9oz8bs0SUOc7zFDu/LA3VbW82IK1GLImfm3qgU+rt4kS
	RzOlUy1w==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwEaE-00000009bhT-2gJc;
	Sat, 28 Feb 2026 07:17:50 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org
Subject: [PATCH] bitops: use correct parameter names in kernel-doc
Date: Fri, 27 Feb 2026 23:17:50 -0800
Message-ID: <20260228071750.2663889-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the kernel-doc comments to use the correct parameter names to
avoid kernel-doc warnings:

Warning: include/asm-generic/bitops/lock.h:19 function parameter 'p'
 not described in 'arch_test_and_set_bit_lock'
Warning: include/asm-generic/bitops/lock.h:41 function parameter 'p'
 not described in 'arch_clear_bit_unlock'
Warning: include/asm-generic/bitops/lock.h:59 function parameter 'p'
 not described in 'arch___clear_bit_unlock'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org

Note: Shouldn't this line in the MAINTAINERS file:
F:	include/asm-generic/bitops
instead be
F:	include/asm-generic/bitops/

 include/asm-generic/bitops/lock.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-next-20260211.orig/include/asm-generic/bitops/lock.h
+++ linux-next-20260211/include/asm-generic/bitops/lock.h
@@ -9,7 +9,7 @@
 /**
  * arch_test_and_set_bit_lock - Set a bit and return its old value, for lock
  * @nr: Bit to set
- * @addr: Address to count from
+ * @p: Address to count from
  *
  * This operation is atomic and provides acquire barrier semantics if
  * the returned value is 0.
@@ -33,7 +33,7 @@ arch_test_and_set_bit_lock(unsigned int
 /**
  * arch_clear_bit_unlock - Clear a bit in memory, for unlock
  * @nr: the bit to set
- * @addr: the address to start counting from
+ * @p: the address to start counting from
  *
  * This operation is atomic and provides release barrier semantics.
  */
@@ -47,7 +47,7 @@ arch_clear_bit_unlock(unsigned int nr, v
 /**
  * arch___clear_bit_unlock - Clear a bit in memory, for unlock
  * @nr: the bit to set
- * @addr: the address to start counting from
+ * @p: the address to start counting from
  *
  * A weaker form of clear_bit_unlock() as used by __bit_lock_unlock(). If all
  * the bits in the word are protected by this lock some archs can use weaker
