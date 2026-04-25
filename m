Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ADE30C60D;
	Sat, 25 Apr 2026 20:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777150658; cv=none; b=pLn+D4ZiUikr/NRIJZYpI0EzVwoFt9+6oCSafA0ELlTWEz10qsw7kxYUuHD5HH6ih9DcflMWf8fLpU8Ls+X5X26tWWwM06TaM6nqIei9A4QEoz/cIBvpv4LECsuarGFavym68hUATGKpuEC7amFxnlc0xicD2XxBNevgM7JcTFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777150658; c=relaxed/simple;
	bh=IIHdJY9Mqcs/tTjfHhjwHqxSAUCuVo7pSdfX/KVRHjI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kmoxOz2xlhUXqUlLpFm5a5dPGKDdQBTbAph8hLH59g5B8sAIlX6o3AUaF4DL4pa3DzWz132xlRlE4mekWyQfkunri+ziP0bAy0T5+9T1O81nRETvVX90b+HYIr8L2WnCmf0qsz074YszkO97GMEjktptMVV9wM29l+bBZ+K/Ah0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=zBRZEPzv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="zBRZEPzv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0124C2BCB0;
	Sat, 25 Apr 2026 20:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777150658;
	bh=IIHdJY9Mqcs/tTjfHhjwHqxSAUCuVo7pSdfX/KVRHjI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=zBRZEPzvGdko9Avx+qOZfKNY2QcphvXu/wOUa1w1j8RVwiJ5JqFaXIf8jeh2EqVls
	 DWqPNAjUJubu0oer+FNNCS7LIqorqzTtAZ0ndu+tn7OhQUgXGkHPxYidgBRJZqaotp
	 ptVof85rTIe235A5tmqkMtFFgdpDK7qdTgMPVMZg=
Date: Sat, 25 Apr 2026 13:57:37 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Min-Hsun Chang <chmh0624@gmail.com>, arnd@arndb.de, msalter@redhat.com,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm-generic: replace ________addr with
 __UNIQUE_ID(addr)
Message-Id: <20260425135737.e79c4b546d22b5ebfd96c0b5@linux-foundation.org>
In-Reply-To: <20260322144032.7353997c@pumpkin>
References: <20260307092119.20733-1-chmh0624@gmail.com>
	<20260322144032.7353997c@pumpkin>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 22 Mar 2026 14:40:32 +0000 David Laight <david.laight.linux@gmail.com> wrote:

> > -#define __set_fixmap_offset(idx, phys, flags)				\
> > -({									\
> > -	unsigned long ________addr;					\
> > -	__set_fixmap(idx, phys, flags);					\
> > -	________addr = fix_to_virt(idx) + ((phys) & (PAGE_SIZE - 1));	\
> > -	________addr;							\
> > +#define ___set_fixmap_offset(idx, phys, flags, uniq)            \
> > +({                                                              \
> > +	unsigned long uniq;                                         \
> > +	__set_fixmap(idx, phys, flags);                             \
> > +	uniq = fix_to_virt(idx) + ((phys) & (PAGE_SIZE - 1));       \
> > +	uniq;                                                       \
> 
> You don't need a variable to hold the result at all.
> 
> The real problem with this define is that both idx and phys are
> expanded twice.

The real problem with this define is that it's a define.  Why oh why do
we keep doing this to ourselves?


What's wrong with the below?

/* Return a pointer with offset calculated */
static inline unsigned long
__set_fixmap_offset(enum fixed_addresses idx, phys_addr_t phys, pgprot_t flags)
{
	__set_fixmap(idx, phys, flags);
	return fix_to_virt(idx) + (phys & (PAGE_SIZE - 1));
}

static inline unsigned long
set_fixmap_offset(enum fixed_addresses idx, phys_addr_t phys)
{
	return __set_fixmap_offset(idx, phys, FIXMAP_PAGE_NORMAL);
}

/*
 * Some hardware wants to get fixmapped without caching.
 */
static inline void
set_fixmap_nocache(enum fixed_addresses idx, phys_addr_t phys)
{
	__set_fixmap(idx, phys, FIXMAP_PAGE_NOCACHE);
}

static inline void
set_fixmap_offset_nocache(enum fixed_addresses idx, phys_addr_t phys)
{
	__set_fixmap_offset(idx, phys, FIXMAP_PAGE_NOCACHE);
}


I'll toss the below into mm.git, shall send it to Arnd if nothing blows
up.


From: Andrew Morton <akpm@linux-foundation.org>
Subject: include/asm-generic/fixmap.h: reimplement nasty macros in C
Date: Sat Apr 25 01:42:28 PM PDT 2026

Min-Hsun Chang reports[1] "the macro __set_fixmap_offset() uses a
hardcoded identifier ________addr, which can lead to variable name
shadowing if a caller happens to use the same name in its scope."

As is usual with macro messes, the answer is to reimplement everything in
C.

Reported-by: Min-Hsun Chang <chmh0624@gmail.com>
Closes: https://lore.kernel.org/20260307092119.20733-1-chmh0624@gmail.com [1]
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Salter <msalter@redhat.com>
Cc: David Laight <david.laight.linux@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/asm-generic/fixmap.h |   34 ++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

--- a/include/asm-generic/fixmap.h~a
+++ a/include/asm-generic/fixmap.h
@@ -71,25 +71,33 @@ static inline unsigned long virt_to_fix(
 #endif
 
 /* Return a pointer with offset calculated */
-#define __set_fixmap_offset(idx, phys, flags)				\
-({									\
-	unsigned long ________addr;					\
-	__set_fixmap(idx, phys, flags);					\
-	________addr = fix_to_virt(idx) + ((phys) & (PAGE_SIZE - 1));	\
-	________addr;							\
-})
+static inline unsigned long
+__set_fixmap_offset(enum fixed_addresses idx, phys_addr_t phys, pgprot_t flags)
+{
+	__set_fixmap(idx, phys, flags);
+	return fix_to_virt(idx) + (phys & (PAGE_SIZE - 1));
+}
 
-#define set_fixmap_offset(idx, phys) \
-	__set_fixmap_offset(idx, phys, FIXMAP_PAGE_NORMAL)
+static inline unsigned long
+set_fixmap_offset(enum fixed_addresses idx, phys_addr_t phys)
+{
+	return __set_fixmap_offset(idx, phys, FIXMAP_PAGE_NORMAL);
+}
 
 /*
  * Some hardware wants to get fixmapped without caching.
  */
-#define set_fixmap_nocache(idx, phys) \
-	__set_fixmap(idx, phys, FIXMAP_PAGE_NOCACHE)
+static inline void
+set_fixmap_nocache(enum fixed_addresses idx, phys_addr_t phys)
+{
+	__set_fixmap(idx, phys, FIXMAP_PAGE_NOCACHE);
+}
 
-#define set_fixmap_offset_nocache(idx, phys) \
-	__set_fixmap_offset(idx, phys, FIXMAP_PAGE_NOCACHE)
+static inline void
+set_fixmap_offset_nocache(enum fixed_addresses idx, phys_addr_t phys)
+{
+	__set_fixmap_offset(idx, phys, FIXMAP_PAGE_NOCACHE);
+}
 
 /*
  * Some fixmaps are for IO
_

