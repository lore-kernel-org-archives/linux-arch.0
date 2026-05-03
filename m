Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35EB25F984;
	Sun,  3 May 2026 05:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777785914; cv=none; b=YnFS7TvPTJ/KMu5rTc17rq1D2aldZFwaL0WnOLjOvf66xkKku/4toXZu80AD5MddJoRBzuqrsZZBw8v3CMU7Ewe2vJkct/dGok4UEdbUqB/78UDHKD2Pg5W5MJCvdL1z/hVvaylpV+T5Z7EPoZCV00d2ei221tYs9OcCwPta9tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777785914; c=relaxed/simple;
	bh=2R/X/yGOb2g1RCxoPORKDtkpCKRpygiETg/AiB2UPpc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LA92sSHXWO/TGJ3O9kG8eK9FSJKka5d9tzZruUysLKyAer3HKE5qDqQimVNG/7kJXymrSWq6YmK6G+Hvdw7ax3PFtYdCRVfvb+AWcJ/FvI5PNCuBI/okqFuDLiIOEcBsNxCcfjv2BviNntzSDamlUDG4cJSdL91T9RKFSZhCwIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mVhud02r; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mVhud02r"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=dP+8X4+6jfrMuMYnb+9WQZ/C3APo+0dV2iScDIn8ly0=; b=mVhud02rZ+QjzLl+XL11Ktr9Y1
	5cw+H/GYQtk2baRlVWBA7R6EStwB+pYDzdiLQnyVymD4ppoZcJ1Vzcmm9/DBUwW0P324wPQz61Rvs
	TEud1GyMtdiaB6g/CYcDOTGUEwHyjznAzk3VVzAC7b+cuVE/OujHSnfsBpSc4s4bX6tG1NOZaWUCO
	s9XF0ezFLLVG7dCfZ2ewhEYNbnqfjMy9pEClsiO8oOlle6alYpVa1y0OBnaD+CRygaDDc2XC8HVhX
	a335KZwTwcofR6ZyNKymQO75dck09esUEUfepw2fgF8bmjI4c1Gi0pTuntjuVlChMzPeZnPF9ccln
	OOox1tVQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJPKH-0000000AOLx-2EPX;
	Sun, 03 May 2026 05:25:09 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org
Subject: [PATCH v4] bitops: use common function parameter names
Date: Sat,  2 May 2026 22:25:08 -0700
Message-ID: <20260503052508.3166614-1-rdunlap@infradead.org>
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
v4: convert function usage of p to addr (thanks, Yury)

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org

Note: Shouldn't this line in the MAINTAINERS file:
F:	include/asm-generic/bitops
instead be
F:	include/asm-generic/bitops/

 include/asm-generic/bitops/lock.h |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

--- linux-next-20260429.orig/include/asm-generic/bitops/lock.h
+++ linux-next-20260429/include/asm-generic/bitops/lock.h
@@ -16,16 +16,16 @@
  * It can be used to implement bit locks.
  */
 static __always_inline int
-arch_test_and_set_bit_lock(unsigned int nr, volatile unsigned long *p)
+arch_test_and_set_bit_lock(unsigned int nr, volatile unsigned long *addr)
 {
 	long old;
 	unsigned long mask = BIT_MASK(nr);
 
-	p += BIT_WORD(nr);
-	if (READ_ONCE(*p) & mask)
+	addr += BIT_WORD(nr);
+	if (READ_ONCE(*addr) & mask)
 		return 1;
 
-	old = raw_atomic_long_fetch_or_acquire(mask, (atomic_long_t *)p);
+	old = raw_atomic_long_fetch_or_acquire(mask, (atomic_long_t *)addr);
 	return !!(old & mask);
 }
 
@@ -38,10 +38,10 @@ arch_test_and_set_bit_lock(unsigned int
  * This operation is atomic and provides release barrier semantics.
  */
 static __always_inline void
-arch_clear_bit_unlock(unsigned int nr, volatile unsigned long *p)
+arch_clear_bit_unlock(unsigned int nr, volatile unsigned long *addr)
 {
-	p += BIT_WORD(nr);
-	raw_atomic_long_fetch_andnot_release(BIT_MASK(nr), (atomic_long_t *)p);
+	addr += BIT_WORD(nr);
+	raw_atomic_long_fetch_andnot_release(BIT_MASK(nr), (atomic_long_t *)addr);
 }
 
 /**
@@ -56,14 +56,14 @@ arch_clear_bit_unlock(unsigned int nr, v
  * See for example x86's implementation.
  */
 static inline void
-arch___clear_bit_unlock(unsigned int nr, volatile unsigned long *p)
+arch___clear_bit_unlock(unsigned int nr, volatile unsigned long *addr)
 {
 	unsigned long old;
 
-	p += BIT_WORD(nr);
-	old = READ_ONCE(*p);
+	addr += BIT_WORD(nr);
+	old = READ_ONCE(*addr);
 	old &= ~BIT_MASK(nr);
-	raw_atomic_long_set_release((atomic_long_t *)p, old);
+	raw_atomic_long_set_release((atomic_long_t *)addr, old);
 }
 
 #ifndef arch_xor_unlock_is_negative_byte
