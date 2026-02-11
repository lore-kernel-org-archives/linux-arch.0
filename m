Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1425827E7DA;
	Wed, 11 Feb 2026 17:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770829893; cv=none; b=U8bXoOudB+GsYsxwEzTBtikyAR/ANZTsBRsZfvnjfs8kbmdX/be/JHtYm+BgAKoVSP/2475L2vjDLv/bIbqQPBi1bEuIm4hzgx7mig3/wGGTmBe4+1CghZuheuF4UzX3jXNSBbAvqUl6NAk+nl3amQdj3sEGqbajCHjFq9wP9kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770829893; c=relaxed/simple;
	bh=DLPBqAujgbh9EAMG405Yd/9jPNpxTQSiiEmEZTbrxZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+jkIXr5Z2JsqFtSHQCnUNZ5kgM3+cZYArwV71Lf5AV06H9TifmV4bs2Jtj413nK8O3CCV6wtEaZYw68k7y/Haby6syQY8hoV/GQ5HMe7LEYjRJiO3rsDCVQRQfF9fVDnX67zlgWOTKruzI+shEGjA1TOfuBwT4luBcfR4kqRQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D305E339;
	Wed, 11 Feb 2026 09:11:23 -0800 (PST)
Received: from arm.com (arrakis.cambridge.arm.com [10.1.197.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E37E3F63F;
	Wed, 11 Feb 2026 09:11:26 -0800 (PST)
Date: Wed, 11 Feb 2026 17:11:23 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	bpf@vger.kernel.org, arnd@arndb.de, will@kernel.org,
	peterz@infradead.org, akpm@linux-foundation.org,
	mark.rutland@arm.com, harisokn@amazon.com, cl@gentwo.org,
	ast@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
	memxor@gmail.com, zhenglifeng1@huawei.com,
	xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v9 04/12] arm64: support WFET in
 smp_cond_load_relaxed_timeout()
Message-ID: <aYy4O66B6T63tRaa@arm.com>
References: <20260209023153.2661784-1-ankur.a.arora@oracle.com>
 <20260209023153.2661784-5-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209023153.2661784-5-ankur.a.arora@oracle.com>

On Sun, Feb 08, 2026 at 06:31:45PM -0800, Ankur Arora wrote:
> diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
> index d7a540736741..dfb7d10a18be 100644
> --- a/arch/arm64/include/asm/cmpxchg.h
> +++ b/arch/arm64/include/asm/cmpxchg.h
> @@ -12,6 +12,7 @@
>  
>  #include <asm/barrier.h>
>  #include <asm/lse.h>
> +#include <asm/delay-const.h>
>  
>  /*
>   * We need separate acquire parameters for ll/sc and lse, since the full
> @@ -208,9 +209,13 @@ __CMPXCHG_GEN(_mb)
>  	__cmpxchg128((ptr), (o), (n));						\
>  })
>  
> +/* Re-declared here to avoid include dependency. */
> +extern u64 (*arch_timer_read_counter)(void);

We have a bug in udelay() because the above might read the physical
counter while WFET uses the virtual one. See this thread:

https://lore.kernel.org/all/ktosachvft2cgqd5qkukn275ugmhy6xrhxur4zqpdxlfr3qh5h@o3zrfnsq63od/

We could use __arch_counter_get_cntvct_stable() as in Marc's suggestion
for the udelay() fix (or just wait to see the outcome of the above
thread).

The rest looks fine.

-- 
Catalin
