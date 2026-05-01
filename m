Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB3229D294;
	Fri,  1 May 2026 04:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777611570; cv=none; b=LS9dLptB2s0CTeIfaig08YJNLorGVY+clGDieOoxbLoiSI4xEMFd8/ByYEMDALJx01e58kTvTFjzN4+U9gw9OSmc8j82kKQzOduRCZ3lw9i54gXj8VfWxcq4PlKpZRS9mXscjcKGrrGbzWIlAQ2vr+f8cu5R5XXfPCR/JRbfaCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777611570; c=relaxed/simple;
	bh=q18MgZXkzPCQselh8E5Gw5GHZWvjMRNbdsYg7/5SvX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r27J/far+9fwH+SNV3Gqti+LTsLPPuuU15VS91NQVOgCE4V97rbPbhx1LBa2chaHjceJdrTFBsZW185Gj42E6JBHXVmaT3v5WHn7y64i7fEqo9r876YsGqpgS3rvzf697WfUrLlzv1FY8XLb2kNCf/6SgsdL1BRjZm44gbklY/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yTpp4Ydx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yTpp4Ydx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=LZMg6Qbsj7uEhIm9EBNqA6YyeGfEU2zdSZJeWENi0AE=; b=yTpp4YdxRQJ/QT5wtuh8648V0X
	80NwsPtTigp9YaPzMSDRB/VI2riqf7e2rMdJ6cZ57C3t9zxvflCOpY/0kHPmOoADSJcCcxtuTLB9Q
	kMrnSYPPzfxQBPdefyQ9oe62KqbVUVsxZbPm3J2+wU38KecutEgWuMCFnSHPHEzmuIxexlckK3VVw
	kYukuYXDJXK1JeXUEEGSjA1NoFyxyjAzGkmmP+GeAnpRLM2D/T0iyB8T6ifop0pZYPWnuRW/zEfbQ
	q3On6TgtoGy4/rjwpNlzA8koIq09QkLS75QheNDbhWYDJ44V/C5TMquBoO7FYewjkFmJFHTs6moEM
	XZQybGJw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIfyG-00000006MZT-3W94;
	Fri, 01 May 2026 04:59:24 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org
Subject: [PATCH v3] bitops: use common function parameter names
Date: Thu, 30 Apr 2026 21:59:23 -0700
Message-ID: <20260501045923.2884548-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the function prototypes to use the common parameter name 'addr'
instead of 'p' (common to arch-specific implementations of these
functions).
This avoids the kernel-doc warnings:

Warning: include/asm-generic/bitops/lock.h:19 function parameter 'p'
 not described in 'arch_test_and_set_bit_lock'
Warning: include/asm-generic/bitops/lock.h:41 function parameter 'p'
 not described in 'arch_clear_bit_unlock'
Warning: include/asm-generic/bitops/lock.h:59 function parameter 'p'
 not described in 'arch___clear_bit_unlock'

Fixes: 84c6591103db ("locking/atomics, asm-generic/bitops/lock.h: Rewrite using atomic_fetch_*()")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
v2: rebase & resend
v3: change the function parameter names instead of the kernel-doc
    comments (Yury) (Fixes: can be kept or dropped at maintainer discretion.)

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
@@ -16,7 +16,7 @@
  * It can be used to implement bit locks.
  */
 static __always_inline int
-arch_test_and_set_bit_lock(unsigned int nr, volatile unsigned long *p)
+arch_test_and_set_bit_lock(unsigned int nr, volatile unsigned long *addr)
 {
 	long old;
 	unsigned long mask = BIT_MASK(nr);
@@ -38,7 +38,7 @@ arch_test_and_set_bit_lock(unsigned int
  * This operation is atomic and provides release barrier semantics.
  */
 static __always_inline void
-arch_clear_bit_unlock(unsigned int nr, volatile unsigned long *p)
+arch_clear_bit_unlock(unsigned int nr, volatile unsigned long *addr)
 {
 	p += BIT_WORD(nr);
 	raw_atomic_long_fetch_andnot_release(BIT_MASK(nr), (atomic_long_t *)p);
@@ -56,7 +56,7 @@ arch_clear_bit_unlock(unsigned int nr, v
  * See for example x86's implementation.
  */
 static inline void
-arch___clear_bit_unlock(unsigned int nr, volatile unsigned long *p)
+arch___clear_bit_unlock(unsigned int nr, volatile unsigned long *addr)
 {
 	unsigned long old;
 
