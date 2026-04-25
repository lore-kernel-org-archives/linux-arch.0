Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C41937F8B6
	for <linux-arch@vger.kernel.org>; Sat, 25 Apr 2026 22:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777154499; cv=none; b=WnhDXWqz7Z4Ah2fatl5h+IXCD0Y4fuCOHRv4cvmdlcnprxav9dDV6KmbsfOMjQlzRRinTZcCM7wlzv3ORIcOAs9IambEI/Ur4qCdSvX7Umc4LZN2WH140ESQzFhyCAX5uz08u4vUx6KGF3St09yzUmhkbGiCidwP2y/HStroRnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777154499; c=relaxed/simple;
	bh=FvfmTlhuK6I9N0WGVzAxup5fR6stQ8THjqI82Gupv1U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZVX2KQGgOJ8HPD5wxxs5KqUszEcwNDg1T0BALhbt9fPfEOw/9PWG1hOhNi3spHM9o7LygkpGnps7u4cf6rZk5tm/1bIBnXdt1vnsTJPYfjoWd/z6FdupbmAkPqGDb8YvgH5RfVJq/c0s/t4xvgPh3u26oieMZPttpW+WD/VKmes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FhYbUlrL; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhYbUlrL"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488d2079582so105112865e9.2
        for <linux-arch@vger.kernel.org>; Sat, 25 Apr 2026 15:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777154496; x=1777759296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35JI4T42UkEo4Y0KyaDcg3Nod1MWEvkh5LAwsg4s+/s=;
        b=FhYbUlrLdsqpsHKLZ7StTeyuN5F/4FMmUrVBzNpSbEn6I24q+v0BOP71UIgGq9MJrj
         TumLy7Z7tOtktVC1iXIiaBvpwVwppo4ggiaXMs74LLiUEO9+ZLoGm9a5xCjTBHLroJ4h
         aZzIRMhxGsHEwpISFlohTOJNLdyu0OiRKMl9jY3kU01IE9Uge/eX/bNgjSmAp9gWTPJr
         3isZMXJ740OSJMHt6T2GBXzhArKA7IipDR25Xpcjf1Kxd0mGp3RgXJIlbQK1npLurROn
         8LC0c/FiyW/UxKoKbLp27hf0gszfSaeN/68wm4kE1UuNm0XVF0wsTUoiBOrMDZi34+M6
         a6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777154496; x=1777759296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=35JI4T42UkEo4Y0KyaDcg3Nod1MWEvkh5LAwsg4s+/s=;
        b=mIRILAqcr2bqdD4LqhsyXvIrFlANHbqRPj/5rL9/1Q5UBemuHVIX2kjm6+vq51ymJH
         dAsyf2YddJqyaonzxgKREHt6vmpgNAxjrBl+A010iK8CAFFjNc471LLWgNlvVAvMd7xu
         DLG1g+T1nfUIaIXMsr2gvmTIgns15lRVC79Muz/zbT0MOjCSrtqPeRXfg1HyttwZSPtr
         S3zW/nRVbIwsIYxCgMGaoXnz4OV3KPAtKjNHR51ArAmLnK/gFBhjLirGshvQJPFEssQ0
         gjNsoOQbFkSUea/maVaPfMbkljBVoi9PQcedaSRmRBoyKyhpTYr8Z/dNGhwOtO3o39io
         vdRg==
X-Forwarded-Encrypted: i=1; AFNElJ9lrENDAV0hIZZFLwEBTK9c0pgebclzv8kxZhAfRle/xacSkuQO55XKsQCvbB8TFElKda6OMK/0/1H9@vger.kernel.org
X-Gm-Message-State: AOJu0YwnhtR/LU1hJwnR/4YlranBRFsu77CrM9r7h1lSVeOhk6FHTpga
	1dwNgeGWTwd1Clcl8EQQD5+8r9N2ZQrGM2gIeAMPIygqucKueIQKDFqp
X-Gm-Gg: AeBDiesc16CE0CNpPI6crZDOWPE01LlOlduG0oT+MgRpQnh47lLuXFQrmhQ2yC1pXDK
	qpbetCiXFpgNmLuSx1voA5TNSuQOrZwOBjPozo1/cPQFIzMQxUcHlzbcoHV2RT7neVPYftKQC8n
	MpjoC7LPNVaJ0IBwxcxIr/CPPDiaTEoYRPgCfpfFSh6EBS5AF0wQmcDR0R0zftK05jPg5D77pnK
	fEWHr6nuynzPbltbuK1b+l+oJI1JzbBVPo0mffw6TVBZgQH9KHnwQT2YWAkznCFx3whrBZF+y9h
	T2DBFaBStxgG2hePLmaib0IWtrMjonP9pmVHScw8nbvUA/hfJjgTWHshDGq0NN8V1juP8ad4k7I
	45aVLMisHe3Y4aMuqhgJnwJbfWi6cO0WIF3ibb15gh8cg/7EztoNCVZbL5GLiOiRPuSHidFlmxH
	HyU4xcmJwOr/0EzvzGF3DnZIucAxs64UeOqXVDoni6VAmMzbzKxio8uMzCg90IQ/FltutD9GbDh
	90=
X-Received: by 2002:a05:600c:c10e:b0:488:8185:e672 with SMTP id 5b1f17b1804b1-488fb792e84mr425930625e9.30.1777154495710;
        Sat, 25 Apr 2026 15:01:35 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a4b329542sm704004115e9.3.2026.04.25.15.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 15:01:35 -0700 (PDT)
Date: Sat, 25 Apr 2026 23:01:34 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Min-Hsun Chang <chmh0624@gmail.com>, arnd@arndb.de, msalter@redhat.com,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm-generic: replace ________addr with
 __UNIQUE_ID(addr)
Message-ID: <20260425230134.5449498a@pumpkin>
In-Reply-To: <20260425135737.e79c4b546d22b5ebfd96c0b5@linux-foundation.org>
References: <20260307092119.20733-1-chmh0624@gmail.com>
	<20260322144032.7353997c@pumpkin>
	<20260425135737.e79c4b546d22b5ebfd96c0b5@linux-foundation.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 25 Apr 2026 13:57:37 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Sun, 22 Mar 2026 14:40:32 +0000 David Laight <david.laight.linux@gmail.com> wrote:
> 
> > > -#define __set_fixmap_offset(idx, phys, flags)				\
> > > -({									\
> > > -	unsigned long ________addr;					\
> > > -	__set_fixmap(idx, phys, flags);					\
> > > -	________addr = fix_to_virt(idx) + ((phys) & (PAGE_SIZE - 1));	\
> > > -	________addr;							\
> > > +#define ___set_fixmap_offset(idx, phys, flags, uniq)            \
> > > +({                                                              \
> > > +	unsigned long uniq;                                         \
> > > +	__set_fixmap(idx, phys, flags);                             \
> > > +	uniq = fix_to_virt(idx) + ((phys) & (PAGE_SIZE - 1));       \
> > > +	uniq;                                                       \  
> > 
> > You don't need a variable to hold the result at all.
> > 
> > The real problem with this define is that both idx and phys are
> > expanded twice.  
> 
> The real problem with this define is that it's a define.  Why oh why do
> we keep doing this to ourselves?

Sometimes #defines generate better code because they are expanded earlier,
and sometimes you want type-agnostic 'functions'.
But neither is true here.

But I think I'd go for 'always_inline'.
Sometimes the compilers make silly decisions.

	David

> 
> 
> What's wrong with the below?
> 
> /* Return a pointer with offset calculated */
> static inline unsigned long
> __set_fixmap_offset(enum fixed_addresses idx, phys_addr_t phys, pgprot_t flags)
> {
> 	__set_fixmap(idx, phys, flags);
> 	return fix_to_virt(idx) + (phys & (PAGE_SIZE - 1));
> }
> 
> static inline unsigned long
> set_fixmap_offset(enum fixed_addresses idx, phys_addr_t phys)
> {
> 	return __set_fixmap_offset(idx, phys, FIXMAP_PAGE_NORMAL);
> }
> 
> /*
>  * Some hardware wants to get fixmapped without caching.
>  */
> static inline void
> set_fixmap_nocache(enum fixed_addresses idx, phys_addr_t phys)
> {
> 	__set_fixmap(idx, phys, FIXMAP_PAGE_NOCACHE);
> }
> 
> static inline void
> set_fixmap_offset_nocache(enum fixed_addresses idx, phys_addr_t phys)
> {
> 	__set_fixmap_offset(idx, phys, FIXMAP_PAGE_NOCACHE);
> }
> 
> 
> I'll toss the below into mm.git, shall send it to Arnd if nothing blows
> up.
> 
> 
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: include/asm-generic/fixmap.h: reimplement nasty macros in C
> Date: Sat Apr 25 01:42:28 PM PDT 2026
> 
> Min-Hsun Chang reports[1] "the macro __set_fixmap_offset() uses a
> hardcoded identifier ________addr, which can lead to variable name
> shadowing if a caller happens to use the same name in its scope."
> 
> As is usual with macro messes, the answer is to reimplement everything in
> C.
> 
> Reported-by: Min-Hsun Chang <chmh0624@gmail.com>
> Closes: https://lore.kernel.org/20260307092119.20733-1-chmh0624@gmail.com [1]
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Mark Salter <msalter@redhat.com>
> Cc: David Laight <david.laight.linux@gmail.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  include/asm-generic/fixmap.h |   34 ++++++++++++++++++++-------------
>  1 file changed, 21 insertions(+), 13 deletions(-)
> 
> --- a/include/asm-generic/fixmap.h~a
> +++ a/include/asm-generic/fixmap.h
> @@ -71,25 +71,33 @@ static inline unsigned long virt_to_fix(
>  #endif
>  
>  /* Return a pointer with offset calculated */
> -#define __set_fixmap_offset(idx, phys, flags)				\
> -({									\
> -	unsigned long ________addr;					\
> -	__set_fixmap(idx, phys, flags);					\
> -	________addr = fix_to_virt(idx) + ((phys) & (PAGE_SIZE - 1));	\
> -	________addr;							\
> -})
> +static inline unsigned long
> +__set_fixmap_offset(enum fixed_addresses idx, phys_addr_t phys, pgprot_t flags)
> +{
> +	__set_fixmap(idx, phys, flags);
> +	return fix_to_virt(idx) + (phys & (PAGE_SIZE - 1));
> +}
>  
> -#define set_fixmap_offset(idx, phys) \
> -	__set_fixmap_offset(idx, phys, FIXMAP_PAGE_NORMAL)
> +static inline unsigned long
> +set_fixmap_offset(enum fixed_addresses idx, phys_addr_t phys)
> +{
> +	return __set_fixmap_offset(idx, phys, FIXMAP_PAGE_NORMAL);
> +}
>  
>  /*
>   * Some hardware wants to get fixmapped without caching.
>   */
> -#define set_fixmap_nocache(idx, phys) \
> -	__set_fixmap(idx, phys, FIXMAP_PAGE_NOCACHE)
> +static inline void
> +set_fixmap_nocache(enum fixed_addresses idx, phys_addr_t phys)
> +{
> +	__set_fixmap(idx, phys, FIXMAP_PAGE_NOCACHE);
> +}
>  
> -#define set_fixmap_offset_nocache(idx, phys) \
> -	__set_fixmap_offset(idx, phys, FIXMAP_PAGE_NOCACHE)
> +static inline void
> +set_fixmap_offset_nocache(enum fixed_addresses idx, phys_addr_t phys)
> +{
> +	__set_fixmap_offset(idx, phys, FIXMAP_PAGE_NOCACHE);
> +}
>  
>  /*
>   * Some fixmaps are for IO
> _
> 

