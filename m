Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577891F03D2
	for <linux-arch@vger.kernel.org>; Sun, 22 Mar 2026 14:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774190436; cv=none; b=Sw1QlokW4P49XV0mlpqB/oor20fktrahqf7ULcK+nrG5HhpzsEfo4WwTS+CiBerWW5f1+l0QKCcwAauXBC2jVV9DJCsEq7wO+BTjoKvXo8HrGMrgTSxpdurYsZu9DW+VlnbPVaCnS7QYncwcylOLxmDwG/2t6zJyU9DexaTUqXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774190436; c=relaxed/simple;
	bh=0BSCjzDruNP/AyDLj5vJICRGek2k34dplxcY5S/Zdlw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mx3va0lKRJPGfE79ujOccjf3UiZ+kmqvMJjRqwK4ezZX1+n0qSnQjlDVtZarHnIVY1lY75ETRS0QNIv39FMydYWiZoZd0rSDtE/12n82ypYZi3Gq8lnwbl2nuWuZ7HGidpu5D4OX2KLBOntIhMla2I1iKHU1UiNIbWBTNPP3i5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0C0wDo8; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0C0wDo8"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-486fb112c09so17413315e9.1
        for <linux-arch@vger.kernel.org>; Sun, 22 Mar 2026 07:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774190434; x=1774795234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/IWr5vfvomOdGiQWFAG7XW5alVFwR3rmlBztzuDjME=;
        b=X0C0wDo87jPB95VtQJcgUKB0qiDbhzo4bJFIQSGUy56qGcKSNwvQs3+p5tyxIS2KBi
         8oLu2zMzRjecoL+BNbQYhWyQT5oT3ohJ5w1NM9i19Y/om8MJZuB5UwH6WQbr+VbvoTIN
         nVTVdx1X23kAh8JIrgZWAVGSwldQVdm3+pm3RWA3bAUoDuLyCSujqHArx/9AdnQ/+3n2
         bB7Vqznta2g2wHv7XwX34kvf08uPG3TDYpBjYgugg+egg/wKqwY5gDP/MT+urC6ZT9S4
         SxAbrfT0d06LjU1VKtJVl77uT7wMKqT0j3VYhUE/nvcyBsqvsJrQ+QpatxuXIALBVzwr
         gi2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774190434; x=1774795234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5/IWr5vfvomOdGiQWFAG7XW5alVFwR3rmlBztzuDjME=;
        b=cpu0myJYd0mutAGAKvqUPVd7U8lxO7lBX/Ei/uYfPWaGv/y+5afFnZKuMmaGnF0pen
         ujlGqLRj73KxvhZ0UJCWjEvI1dbzqZheORAy0Fv+YW87qM5IbBeiZvhqOl8K9oED34WU
         DHwxyUVpnEHh+2UiD5j4p+08c/VU3rN+Q04F2b1f2QHvrVtSpaGNwAVRJtx0ZozSHapB
         2oA7X4vczGUPYZHLeo7JSyL1lRu0seC31lARKwsfBBp0iEh07PQCr/0/kJLvhrjnrKk/
         w77MiBWMS2MC5OZ2Mzhfj5PeYE7MngrLgb1yGTajbJpKXc7EOYXui6GdlTMuxQ5enIvY
         wN1A==
X-Forwarded-Encrypted: i=1; AJvYcCV81P3qyVseLIS2TLkAhCK80lQ0AVhGNvUshyJD4wGwWlKwIYYoa3QzWwEboQWE11NMFWjeXpNsYwc7@vger.kernel.org
X-Gm-Message-State: AOJu0YyrZRiXlmhIB+4RIUaEyevQzuU1jf0l7HsxsP7mlDesSP7/d5fR
	YaqMXSneuvFELsJDj2xqHrsjeLCZ4IaFglrKmkrJrq38fz1ZuaP97a+p
X-Gm-Gg: ATEYQzxsNbDzC12NnEAVCmj8Bituln9g8eLT9SdvWkmXNiqgLHpfsR1tavNonDuYJ04
	er6HJiBtD53RG1JSVHzVlkKl703fJF7Di1aIv3Um0TvMptskljyb/S94GGIkZWWTpeBdhRER8fW
	YUUFthDXOQGhRi4OoxgfzSUVskr9VH/PYFulGNpBsqI1nKvJgHefEbmiWave+H15SDE3HjFY8x/
	tOhi6b7u9CUS9uGUHIFb2rt9jv4qI9fHheXulRRRzShn9eQMLJ9pImwuEOBnJ4PkgTLN+akbhQX
	s2ZosyJEE1yjFWa4RV2dZC+8gfI7fmmt8olK5i25MSfInk58RKZUeKX7QxnmnBAlnMI5xJ/bWEF
	/qwl4xV54wP8fBNFRvLphVm0woLsUBIYj64OfRtqj3a5rY1ia1tvkeFjhdHUSFhFF8zThu8+wai
	/CKEYS3S5T3LFM1EC9RkllDlNEFpKv/olhyWG15R43mhnjx3P3cXVOXmDNysoYUdfm
X-Received: by 2002:a05:600c:4aaa:b0:477:7af8:c8ad with SMTP id 5b1f17b1804b1-4870306720emr48296925e9.31.1774190433483;
        Sun, 22 Mar 2026 07:40:33 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe68ec05sm319287775e9.0.2026.03.22.07.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 07:40:33 -0700 (PDT)
Date: Sun, 22 Mar 2026 14:40:32 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Min-Hsun Chang <chmh0624@gmail.com>
Cc: arnd@arndb.de, msalter@redhat.com, akpm@linux-foundation.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm-generic: replace ________addr with
 __UNIQUE_ID(addr)
Message-ID: <20260322144032.7353997c@pumpkin>
In-Reply-To: <20260307092119.20733-1-chmh0624@gmail.com>
References: <20260307092119.20733-1-chmh0624@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  7 Mar 2026 17:21:19 +0800
Min-Hsun Chang <chmh0624@gmail.com> wrote:

> The macro __set_fixmap_offset() uses a hardcoded identifier ________addr,
> which can lead to variable name shadowing if a caller happens to use the
> same name in its scope.
> 
> Following the pattern in commit 44238e82670e ("rcu: Replace ________p1 and
> _________p1 with __UNIQUE_ID(rcu)") and commit 589a9785ee3a ("min/max:
> remove sparse warnings when they're nested"), replace the hardcoded
> identifier with __UNIQUE_ID(addr).
> 
> Since __UNIQUE_ID() must be expanded once to remain consistent across
> declaration, assignment, and return within the statement expression,
> introduce a nested helper macro ___set_fixmap_offset.

I'm not sure that is really relevant here - nested use is probably
impossible.
It is almost certainly enough to prefix locals with an leading _
and an abbreviation of the macro name.

But see below. 


> 
> Signed-off-by: Min-Hsun Chang <chmh0624@gmail.com>
> ---
>  include/asm-generic/fixmap.h | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/include/asm-generic/fixmap.h b/include/asm-generic/fixmap.h
> index 29cab7947980..2d1e9a2c6a3b 100644
> --- a/include/asm-generic/fixmap.h
> +++ b/include/asm-generic/fixmap.h
> @@ -16,6 +16,7 @@
>  #define __ASM_GENERIC_FIXMAP_H
>  
>  #include <linux/bug.h>
> +#include <linux/compiler.h>
>  #include <linux/mm_types.h>
>  
>  #define __fix_to_virt(x)	(FIXADDR_TOP - ((x) << PAGE_SHIFT))
> @@ -71,14 +72,17 @@ static inline unsigned long virt_to_fix(const unsigned long vaddr)
>  #endif
>  
>  /* Return a pointer with offset calculated */
> -#define __set_fixmap_offset(idx, phys, flags)				\
> -({									\
> -	unsigned long ________addr;					\
> -	__set_fixmap(idx, phys, flags);					\
> -	________addr = fix_to_virt(idx) + ((phys) & (PAGE_SIZE - 1));	\
> -	________addr;							\
> +#define ___set_fixmap_offset(idx, phys, flags, uniq)            \
> +({                                                              \
> +	unsigned long uniq;                                         \
> +	__set_fixmap(idx, phys, flags);                             \
> +	uniq = fix_to_virt(idx) + ((phys) & (PAGE_SIZE - 1));       \
> +	uniq;                                                       \

You don't need a variable to hold the result at all.

The real problem with this define is that both idx and phys are
expanded twice.
So you either need to copy those to locals or use a static inline
function - which should be ok here because the types are fixed.
(Assuming neither __set_fixmap() or fix_to_virt() are #defines
that modify their arguments.)

	David


>  })
>  
> +#define __set_fixmap_offset(idx, phys, flags)                   \
> +	___set_fixmap_offset(idx, phys, flags, __UNIQUE_ID(addr))
> +
>  #define set_fixmap_offset(idx, phys) \
>  	__set_fixmap_offset(idx, phys, FIXMAP_PAGE_NORMAL)
>  

