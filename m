Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF14D3396EE
	for <linux-arch@vger.kernel.org>; Thu, 22 Jan 2026 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769084710; cv=none; b=adkbIE9qIzzHpIGOE8zE8WlG2xh3hDz1mvL7WUKdFCIYAjkL74sjWAqsMfdBKYfLOqlz7IVebIy9L3LhXEFTWfy35BU1WM2PYZhN7jpDaHrDxj0RHJe8rl6yshTZYYaxenxWEaj0ovuQLZINZFFvwa72PceD9F8KYB2QMrzbEbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769084710; c=relaxed/simple;
	bh=Luz8B2TwJRarH7eRwBAhfKkOBXwfgblGcy0Dgye670E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lMWREBifY2VY0vctHUam8Dk2CPUg2/9wd5hInvzi1g2QEs7FlwzLCUDOcKt3fXcZT3O2aXsMv6NkXRG06MzSohebcP3irzXvKa0dB3xt+rYOrOQsN1CCs6E91sgwpzjAZQpI3Wc/Te909nUHmr0XRGezEOu1PCd7WFIAFsOBi5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kp+w34uA; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kp+w34uA"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-65807a2012fso1540063a12.0
        for <linux-arch@vger.kernel.org>; Thu, 22 Jan 2026 04:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769084704; x=1769689504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30EptBzNKREQjciAE94dkKi4CBlW2pcTBovWP9se6eo=;
        b=Kp+w34uAtcYrEhCqYDioEhtcL8czNgzV2alt5oBX7puHp/ZO5uZPyA7eT9LWM3Wd/I
         MyQnSpfp2SsxY/GMmeQjZaQiJ15nxcrh2B0i26QS60CbfmH3Xldh1ijKVnmj7rnZMQBA
         vtxFeR3+XBcQmsRDHwGCd+NvA1SgNAUJdAPOwXe0aHQqNAcWJorC9VxVmW+6c+ydD3lF
         TgY3+iUq9OYpPhf6Fz0+qSLQsqAT+n3qcCnQB97sqZluMINvof/ROCYokWzRX5OHfOFZ
         5eQE3sdk0LceHIoeAmYjwEAIqHoTP6HFaS0d2yJn0y/hdE8CNn/0n2cQKj6pHmDWeuKA
         QuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769084704; x=1769689504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=30EptBzNKREQjciAE94dkKi4CBlW2pcTBovWP9se6eo=;
        b=tFPLW5ysjCC9nTQyOZvUIRUjT0c/VZxY9u04f5kF1T3nEpp0JHROBLLHCVJ4KVF0he
         oekoMQffIm63VjTJFVQBwxpsUWEMOjmXfAqLVVI7mLB3oldB13qi26q6ICMCEDrBUAIj
         XmSTxbzfZTnHn/eEKpgBkjPgln+i7m5Jq1ofkpvkjFsa8DHkRKkfW/1cvQNXnfDBIVIr
         ew+cjOFd2BepRW+a9P3Ys/wLgE8z+3mzs9p0LDPopY0QGo1jAENSxB4lz40asnQVwEZP
         zR9QCOyytNYOERxkJLVUy3dJB5IsgCF6wXSnFxJm8jbA+RgoQYhjGmk89KzEApZHZL45
         JiEA==
X-Forwarded-Encrypted: i=1; AJvYcCVnQ/dKrk1Fylrsc2qMeLzvcS8OVGOjDeA0DNPtJbUp6bgAuXts3JoskZvjqNbu59opgT2jtwzSvlUy@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv1pqTv7dGJvurUkwXywbogRiQuWgwkNaF4gZMrjEKv1cIc++b
	ze5PCkw0RAEA/NGQrPHSnhGW7eXKm88R+QV9QsNXaUUk33kB/86oXvx522gYpw==
X-Gm-Gg: AZuq6aLJbBO3lxEsXltsGayLm3ozDdJAnO1wOYUgxlBo5P+r6C596ZY4WqCnoxp6Pqe
	3MJyPdwbN1DIPPsiepzTKklUlZizZkB4PR7WmfJ9vmgikZg97uUguDD0Tp/IW3ZFu69hBIj9VaQ
	djDRPphL1ramyM9AkNcN8+NP618p9QCJKbiEvLaKfQkpu9rlb2bRZyy2YZ4NXke1pRA8dksC80i
	MEss8ImWfiKQ1IfDfjQ1xrlTsOIA5rmmpHavOLwvMKKxVimAo9KGZXjHnw4aGDhsetT/INWyk3k
	3BhGJ5vmlD0X4DMfsAnUaZpa0ORyJiDVHUSXMQVzBZyrYP88O9R0aTzdDTZi/SicXjsfMOkVdJK
	kJs9iL30bDTtEGqTHAt/F0xDugO0C0orwTSDpf9yFEGlQeyHOFtUF42FXKi3aWq7YtLpKMVL9Un
	dVegubzePs4zjF3UYQfAzpBWH5gCpItzNiE5E8fmb7hl5zkuxXydOw
X-Received: by 2002:a05:600c:5299:b0:477:a9e:859a with SMTP id 5b1f17b1804b1-4803e7e859dmr122557745e9.22.1769077556776;
        Thu, 22 Jan 2026 02:25:56 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804706ef6csm51088835e9.15.2026.01.22.02.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 02:25:56 -0800 (PST)
Date: Thu, 22 Jan 2026 10:25:54 +0000
From: David Laight <david.laight.linux@gmail.com>
To: kernel test robot <lkp@intel.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Yury Norov
 <yury.norov@gmail.com>, Jani Nikula <jani.nikula@intel.com>, Vincent
 Mailhol <mailhol.vincent@wanadoo.fr>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Kees Cook <keescook@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>, oe-kbuild-all@lists.linux.dev,
 Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH next 11/14] bit: Strengthen compile-time tests in
 GENMASK() and BIT()
Message-ID: <20260122102554.1cc7a2a3@pumpkin>
In-Reply-To: <202601220829.MgTMeqqN-lkp@intel.com>
References: <20260121145731.3623-12-david.laight.linux@gmail.com>
	<202601220829.MgTMeqqN-lkp@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Jan 2026 09:11:53 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on next-20260120]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/david-laight-linux-gmail-com/overflow-Reduce-expansion-of-__type_max/20260122-013456
> base:   next-20260120
> patch link:    https://lore.kernel.org/r/20260121145731.3623-12-david.laight.linux%40gmail.com
> patch subject: [PATCH next 11/14] bit: Strengthen compile-time tests in GENMASK() and BIT()
> config: s390-randconfig-001-20260122 (https://download.01.org/0day-ci/archive/20260122/202601220829.MgTMeqqN-lkp@intel.com/config)
> compiler: s390-linux-gcc (GCC) 8.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260122/202601220829.MgTMeqqN-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202601220829.MgTMeqqN-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from arch/s390/include/asm/bug.h:60,
>                     from include/linux/bug.h:5,
>                     from include/linux/mmdebug.h:5,
>                     from arch/s390/include/asm/cmpxchg.h:11,
>                     from arch/s390/include/asm/atomic.h:16,
>                     from include/linux/atomic.h:7,
>                     from include/asm-generic/bitops/atomic.h:5,
>                     from arch/s390/include/asm/bitops.h:75,
>                     from include/linux/bitops.h:67,
>                     from include/linux/kernel.h:23,
>                     from net/core/page_pool.c:10:
>    In function 'netmem_clear_pp_magic',
>        inlined from 'page_pool_clear_pp_info' at net/core/page_pool.c:721:2:
> >> include/linux/bits.h:35:4: error: call to 'GENMASK_INPUT_CHECK_FAIL' declared with attribute error: Invalid bit numbers  
...
>    include/linux/mm.h:4641:27: note: in expansion of macro 'GENMASK'
>     #define PP_DMA_INDEX_MASK GENMASK(PP_DMA_INDEX_BITS + PP_DMA_INDEX_SHIFT - 1, \

This might be a real bug.

The bit of mm.h is:

#define PP_DMA_INDEX_SHIFT (1 + __fls(PP_SIGNATURE - POISON_POINTER_DELTA))
#if POISON_POINTER_DELTA > 0
/* PP_SIGNATURE includes POISON_POINTER_DELTA, so limit the size of the DMA
 * index to not overlap with that if set
 */
#define PP_DMA_INDEX_BITS MIN(32, __ffs(POISON_POINTER_DELTA) - PP_DMA_INDEX_SHIFT)
#else
/* Use the lowest bit of PAGE_OFFSET if there's at least 8 bits available; see above */
#define PP_DMA_INDEX_MIN_OFFSET (1 << (PP_DMA_INDEX_SHIFT + 8))
#define PP_DMA_INDEX_BITS ((__builtin_constant_p(PAGE_OFFSET) && \
			    PAGE_OFFSET >= PP_DMA_INDEX_MIN_OFFSET && \
			    !(PAGE_OFFSET & (PP_DMA_INDEX_MIN_OFFSET - 1))) ? \
			      MIN(32, __ffs(PAGE_OFFSET) - PP_DMA_INDEX_SHIFT) : 0)

#endif

#define PP_DMA_INDEX_MASK GENMASK(PP_DMA_INDEX_BITS + PP_DMA_INDEX_SHIFT - 1, \
				  PP_DMA_INDEX_SHIFT)

I've no idea what the values are, but the 'hi' bit number must exceed that
of 'long'.
The __ffs() probably stop it being an 'integer constant expression'
making it just a 'compile time constant' - which I added a test for.

	David


