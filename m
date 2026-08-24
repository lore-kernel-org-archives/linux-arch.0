Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2151144E671
	for <linux-arch@vger.kernel.org>; Mon, 24 Aug 2026 15:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787586647; cv=none; b=dzGsWPK35M1BRHdCEJlS37vvCiNptVu4E2tww6YCGhjhIMDAu37PMJTHuNAeDS9sZfJ39PMUDfSXOBkPgAMdhVZzXPF0qdaplUDS3vjPX6b2MfYZKpERG2AQgLWuwp3qerBwcdOC3iZw1hOOnD6IwYsU+ka2r9g06gT3hwKHrgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787586647; c=relaxed/simple;
	bh=O+UlH1d73+sx98gD+jonoek56k6WXXcHy6glAIcE6hw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mI6cEDGvry8SU23T85M4JGEIufw+ff1mSLyFK56poa4z+nSZl5gKofG6YLwJa+ACKBk0PgmdB+kWokqaI1mpbHytMdzX38dX0Cx7Ax2UBBMzHRdIs9zmscVPJV1S2P/BK33E/9/j+sabSalr5Gu4ujFmjVcYGGT7MMoNp5GFGdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=gzpY5h5W; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gzpY5h5W"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84e04df8c46so4831355b3a.2
        for <linux-arch@vger.kernel.org>; Mon, 24 Aug 2026 08:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1787586639; x=1788191439; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8n2sUFyNkTeeyJ480adWKOU51gCub2/F4WE3r3BRNf0=;
        b=gzpY5h5WE22LnAQ59IZ1aQ4RvBrfX1TLQn3SeYIVWwfWG6YEj9tCVYFWrUXI5/d3Fk
         ILuo5xbw0dVb1q+vkio3LO2q1/7BYar7Kd5kiSrhH/zpU1K6ai1dgXhfcC2bU4BUgpP7
         Q0N6hK6rjCO+W1AsSr1BhsqykjtQISFsHVj6HskgrREPOVxF0BlSLr54YV62XFF35Fe4
         rHfJtt2Pm+mN20xIIEFapc1pnvYItHz7b3meyYbyZAgGU5QRDNt0yIj93oWX9aeRV0yW
         v8tyoX1WzdbToiE2o68NzxuqsIcwGG6oMLnng9z/nrOw6AUsqUwGBuNpHV94z+vHBfbN
         EZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787586639; x=1788191439;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8n2sUFyNkTeeyJ480adWKOU51gCub2/F4WE3r3BRNf0=;
        b=J6nrzlXSKItZplGpQZCmLEPbrIcxP0FU7TLl9xA0fc6q963/x/0EajXZJAHFqsvIfL
         IRhi6itcrosEE3dF32p8WP8jdbfczOjKiwwrtE2ZL5P33AfeO8bwjMKzSgfUnxvjbhoA
         ej6Lqk4eXY0UA3Td9j+TTKPiu5hIjf47drFePOtoi6bAIzMo3KQQcphQVugxlnvVS9kW
         qVWs9huQWUALS3t5FoSZiNbtGRjdhGQtI9NHzWMjTFkUchm5UpCB0tE3wJbSdPuxTqjO
         sGT7CvB3yjpwdNaUYwWvWMfjXs8VWNAa7ZV/oJBzRylVyIZwaL8Se8rQtfowzwDuJaWn
         4Smw==
X-Forwarded-Encrypted: i=1; AHgh+RorxppNUVbVY4i7BntYviOaQrlNAsYYZjHz6phk+tj+C/a5T3aLqikOud7jsDQkSetYFw2Jw+PEKjK2@vger.kernel.org
X-Gm-Message-State: AFuF++l8QIAGmOcvKwaSEfmYr/oYvyf4YD0FuYYlh+yRhe2fyFYjY6IQ
	NnlEn1W6s+pVAiH7QZ6ISe35MYE6oiRpFrEtMmx6U9xPAQjYwXjvp97i27qcwt9eK9w=
X-Gm-Gg: AR+sD12Zw1VgIn2WbXvfBxXGEONBiDILuYQ8K8S/0jGspKQxl19e0JSKNXamj5xfMC2
	D4L2KDgdBzz1sMwySRkVyYTWArguAqZvDPlQB7ftu/ljql5SET4+yPXc8s8V37HIITP0+s68OJn
	KRe2I4oHQI3SpRqWjUttP3Y/jKrsdJdActOTYMuV2yft+/g/o9cZY7y+pRuzrcIHVJ9plj+0O+b
	m1rPVu8NOgpOWKXKOaQ1Eq01X8Qhm0kkUrfjMoe+SXaGbf5DStttkgA6gG/BBTjJ/ivHxUH0d+B
	MMJ0VEnQjNrjeEjlyMB3ww5OD9HA2FqCHtWJhXQta4RMjvV3rhxZw1XzTzAzUoveUTIu+IZuLyi
	t261/CPXh2HmkvAv5DLSReaZEtYXeFqgo7nBzbT5eEF7HMtC6JE8Sga6jUnV1hel10hKeYJY9pg
	qhLEhVNKYBXspAfJOdJIS1udD9O3a77bxpFpx0tUZ4KF+e5OIA0qvXUxVucLqbLyaf
X-Received: by 2002:a05:6a00:10d1:b0:848:5540:2377 with SMTP id d2e1a72fcca58-851fa070c14mr40910400b3a.17.1787586639434;
        Mon, 24 Aug 2026 08:50:39 -0700 (PDT)
Received: from [100.64.0.1] ([165.225.242.163])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520ef36048sm2219670b3a.26.2026.08.24.08.50.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 08:50:38 -0700 (PDT)
Message-ID: <6dae9cae-9665-4dc8-9a49-d6e5acda221b@sifive.com>
Date: Mon, 24 Aug 2026 10:50:37 -0500
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V3 8/8] mm: Drop pxd_ERROR()
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-mm@kvack.org, akpm@linux-foundation.org, david@kernel.org
References: <20260818040041.1891769-1-anshuman.khandual@arm.com>
 <20260818040041.1891769-9-anshuman.khandual@arm.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <20260818040041.1891769-9-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-08-17 11:00 PM, Anshuman Khandual wrote:
> There are no more users left for any pxd_ERROR() either in generic MM or in
> the platform MM. Hence all these platform macros along with their generic
> fallback could be dropped across the tree.
> 
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-snps-arc@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-csky@vger.kernel.org
> Cc: linux-hexagon@vger.kernel.org
> Cc: loongarch@lists.linux.dev
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: linux-mips@vger.kernel.org
> Cc: linux-openrisc@vger.kernel.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> Cc: linux-um@lists.infradead.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> Changes in RFC V3
> 
> - Moved ptrval_to_str() as header in a [PATCH 1/8]
> - Stopped using pxd_ERROR() in generic MM in [PATCH 2/8]
> - Dropped pxd_ERRO() macros from all platforms in this patch
> 
>  arch/alpha/include/asm/pgtable.h               |  7 -------
>  arch/arc/include/asm/pgtable-levels.h          | 11 -----------
>  arch/arm/include/asm/pgtable.h                 |  7 -------
>  arch/arm/kernel/traps.c                        | 17 -----------------
>  arch/arm64/include/asm/pgtable.h               | 15 ---------------
>  arch/csky/include/asm/pgtable.h                |  4 ----
>  arch/hexagon/include/asm/pgtable.h             |  3 ---
>  arch/loongarch/include/asm/pgtable.h           | 11 -----------
>  arch/m68k/include/asm/mcf_pgtable.h            |  6 ------
>  arch/m68k/include/asm/motorola_pgtable.h       |  8 --------
>  arch/m68k/include/asm/sun3_pgtable.h           |  7 -------
>  arch/microblaze/include/asm/pgtable.h          |  7 -------
>  arch/mips/include/asm/pgtable-32.h             | 10 ----------
>  arch/mips/include/asm/pgtable-64.h             | 13 -------------
>  arch/nios2/include/asm/pgtable.h               |  7 -------
>  arch/openrisc/include/asm/pgtable.h            |  7 -------
>  arch/parisc/include/asm/pgtable.h              |  9 ---------
>  arch/powerpc/include/asm/book3s/32/pgtable.h   |  2 --
>  arch/powerpc/include/asm/book3s/64/pgtable.h   |  7 -------
>  arch/powerpc/include/asm/nohash/32/pgtable.h   |  2 --
>  .../powerpc/include/asm/nohash/64/pgtable-4k.h |  3 ---
>  arch/powerpc/include/asm/nohash/64/pgtable.h   |  5 -----
>  arch/riscv/include/asm/pgtable-64.h            |  9 ---------
>  arch/riscv/include/asm/pgtable.h               |  4 ----
>  arch/s390/include/asm/pgtable.h                | 11 -----------
>  arch/sh/include/asm/pgtable-3level.h           |  3 ---
>  arch/sh/include/asm/pgtable_32.h               |  8 --------
>  arch/sparc/include/asm/pgtable_32.h            |  3 ---
>  arch/sparc/include/asm/pgtable_64.h            | 10 ----------
>  arch/um/include/asm/pgtable-2level.h           |  7 -------
>  arch/um/include/asm/pgtable-4level.h           | 13 -------------
>  arch/x86/include/asm/pgtable-2level.h          |  5 -----
>  arch/x86/include/asm/pgtable-3level.h          | 11 -----------
>  arch/x86/include/asm/pgtable_64.h              | 18 ------------------
>  arch/xtensa/include/asm/pgtable.h              |  4 ----
>  include/asm-generic/pgtable-nop4d.h            |  1 -
>  include/asm-generic/pgtable-nopmd.h            |  1 -
>  include/asm-generic/pgtable-nopud.h            |  1 -
>  38 files changed, 277 deletions(-)
> ...
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 5d5756bda82e..993a6505eb8f 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -559,10 +559,6 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>  	return __pte((pte_val(pte) & _PAGE_CHG_MASK) | newprot_val);
>  }
>  
> -#define pgd_ERROR(e) \
> -	pr_err("%s:%d: bad pgd " PTE_FMT ".\n", __FILE__, __LINE__, pgd_val(e))

We can drop the PTE_FMT macro now too.

Regards,
Samuel

