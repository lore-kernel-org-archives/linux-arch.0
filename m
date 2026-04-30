Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8366F3D6CAE;
	Thu, 30 Apr 2026 23:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777592380; cv=none; b=dJ0+XLNMGEk4bBzu4pLWk6mV1kfT8dL+odslYasMw5f0KrEIZDP+yOmZrkBK2GyIALdilHI5VphGo0ocHC/aDsHCu48D4PoMskB8Fy3P8Z9Jc/iKvkL2IVdItLd5jiqKNr17X6UZGSXVQRZ0hNfboNNngJBSS8OCFNeifvuz/Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777592380; c=relaxed/simple;
	bh=w7sITRJXrdtrqTFn5FjekZXOiGw33Jp6K1v2vyzBQSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O0GPv7xq27iPYlSX7OANRi3QyI420GmQInAF4CFtUJrCoYLPEbUH2ptPHjeJxG50yEDX5wNuiWg+HJQ6onBVrZ03hWvWkL3mF9eOZWypqT8bXes14J6W8fydgti4MUA4KzCr8qFNXd6VCETQwIPMQlZzw2ewO9Mv4vYGqIqK2h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4wJUhorq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4wJUhorq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=KO6xczKA3VO16CM6MCAtvQylSl4/QZwMXh0Oyb6pyWY=; b=4wJUhorqasg1u+86KEJqcbxfv0
	xssdEJ3nKfPFInwBlFbkyj52r/1SgkMAVhBtF1z6PLYZps49mRGo7QhI5wcAo4jcoyQtZZpgobbiG
	95shIoNeBk4mUDUXdAJxYBpoNdLCgmcXEwUizLGh6uAwARAOTceuCF7l70YupdwVxMUgqIa2ZfRuY
	wLdOjy3oZcMkD5nduy2EgXsubv6kpUmoMKIItePVR+aFwYqZsu+8dLpfhpMyPT9/C4X0SVwgbyed+
	1hUDWgZDV3Hp5BPPZsNxddVKcEseMBS6wIHbOgbfvwWyMvw2DFeNuxGW4VU7MewYPrYhXT3ZxB28O
	1sXSFrag==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIayk-000000067vC-3iqO;
	Thu, 30 Apr 2026 23:39:35 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org
Subject: [PATCH v2] bitops: use correct parameter names in kernel-doc
Date: Thu, 30 Apr 2026 16:39:34 -0700
Message-ID: <20260430233934.2620065-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.54.0
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
v2: rebase & resend

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

--- linux-next-20260429.orig/include/asm-generic/bitops/lock.h
+++ linux-next-20260429/include/asm-generic/bitops/lock.h
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
