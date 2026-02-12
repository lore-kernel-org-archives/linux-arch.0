Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7D52BEC44
	for <linux-arch@vger.kernel.org>; Thu, 12 Feb 2026 09:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770890186; cv=none; b=ieRm5WCuXsCfghwk+lB9XWU4TYCFOtUmxmazfI7Z4R88w6Q7qIG8bpccdnUyUMjLZph+L4Gj6wcAUJ2eyryeWU7Z41TqGn7Ii12JmU6dpo8sbJh74EwZ0040A+JaCj9m9Y9Qg+yPqEUpa1YdTek9MGcA6PxiO2ykIW09FaA+tvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770890186; c=relaxed/simple;
	bh=bm5c2DB94uUyrmyglOpsvupAxM8sAv2B1xXqGM1GJFs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=skOf7fj9ismJY498zTDM9JdPRkskkfkeFeA3kju2G4G2rbh+YDtsnbLeqiC48gxYVSZ8vHrjEDzHm2lfaYytRmU6Gt3PevWPLYopamh+6SRtO9165fzgMQwTOUqu0s2ryjZCFREh3tbDuiBAyDN4+jb8CRao5t44A6/6174tDwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBX1+q3s; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBX1+q3s"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47ee0291921so60194795e9.3
        for <linux-arch@vger.kernel.org>; Thu, 12 Feb 2026 01:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770890183; x=1771494983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Phtp8Z4ei388aKllZFARYn5zwlBsIT6J1/fUx6EVP8E=;
        b=NBX1+q3sG3mz5yo+4PTok6RS0Rp9dEpR09+Y/JRk3u6e/64D04ue1Vm9XVkCusdVXu
         NU3WJvXA/Q+dK+oBZz+2re44DDJ0aNRgUR8oq0glWiZvELc11mKMFW0ZNXaRiz1FwbDl
         3kum0bbwFJHel7oltVfP+rxyeZEgtlPDoU9m4kCOJ1mKK/Rx/N9WnOd74jf+d8M7g2au
         yscatCcL8N2Ntt7JN2wdoT5baluHz8sx6Y751dwHYyRknl84qrPr/ABBiYzpydA2evGn
         5l4w9ak5lIPOuSfe8gbBTLD9GwhQ7CX8KHMX2+xVE9uTBBISVe4xnzhgArj9Ln1esdZF
         yFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770890183; x=1771494983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Phtp8Z4ei388aKllZFARYn5zwlBsIT6J1/fUx6EVP8E=;
        b=rIenYTtNze9cijnf/qR+sNDal6nl5+WqQDEW6M1HsX1T+K8ezbh0+2ueFJSsH1LXju
         NaPtGcDekyVBJ28kzafAxw4Hj96hK50lzRUPi4al/0AjnLErCanV3/cJWBXxEeW2MDoG
         S4gAF6FzujsTFhwSrF+UItIxj2hL6qpvQGlWFwWSoggauL8qTcW/5YG262mrc9Y7nXtz
         6GlPRftGB+PKFhPCdWvaOqYAZUNnI16CTOl+92WHxoM8rdFNsVd6Ems3GQYiu8Gn0cev
         lDHea0Ss4t6X6qdDn4B6U65umHVRepfdwvazXL11ZeV93tOyMPDqVLoOi1QoBWtpSIeA
         CT7A==
X-Forwarded-Encrypted: i=1; AJvYcCXlqkMzEClCkVbN8J+rUKr35wiKpEsW/xl4gGSMBVbtpdZ1Kth5Bckn2vr7ahcHAX41Xpv1A/DOl2sK@vger.kernel.org
X-Gm-Message-State: AOJu0YzGQplJIBXKovuTeIFUZqZLuiCAfVg1e2+wXOXZY6wyY7JexxUI
	n77+t7d8qSvaxAvW7BjPwtWo/vo4R3nExspYI7KtvfSZGWqhBdlR7kNt
X-Gm-Gg: AZuq6aIjySc3kIm7cTafBanknmhjXRkqHl1kHDFRE+1NNMMMknuXAlDBHiIJE8m1fy9
	OdceW3DhZjFL52+ktF1e14uiQoyB5+tgkIfdsqCb9mNA7P+0dvp47I+02Iq+RxekirOyNYDlv+2
	6BBqLJxiS539HiLG+SYoOZJAshrsf0BOzGBindfuqBzP8qfQbbuHHq07yj73IOWmbB7qmoNw3dn
	1Zn9BA0fF1nFhoCoMPrvI3X4ecILFoN+iakf8QKDkAVQLD1od4qTzTovzfCnZc4VGPBIGfeBwlW
	z1sF1Vd5M5XsDgYOc24DSrXLoZ+cP7dWy9pklz0cuSxeXBtTaWwg2WhVwzDSX2vJEvr5Fc48TP7
	6k5iHn/ylZ8I4RjuSSSDlgBRLbHIXUoLkfrHpk//oKeNvkpxfjoTPDYE1Czu01M49NTXqabPoYQ
	GGBmB2iNECrj/YKGvH5FVcQVSngtJgGJBZHhby+skzH2ElPnWPvWaWSiSioxTRFOLr
X-Received: by 2002:a05:600c:4fcb:b0:480:1a9a:e571 with SMTP id 5b1f17b1804b1-4836570e48amr25658585e9.22.1770890183038;
        Thu, 12 Feb 2026 01:56:23 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d82a4c4sm330608855e9.10.2026.02.12.01.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 01:56:22 -0800 (PST)
Date: Thu, 12 Feb 2026 09:56:21 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 bpf@vger.kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
 will@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
 mark.rutland@arm.com, harisokn@amazon.com, cl@gentwo.org, ast@kernel.org,
 rafael@kernel.org, daniel.lezcano@linaro.org, memxor@gmail.com,
 zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
 konrad.wilk@oracle.com
Subject: Re: [PATCH v9 01/12] asm-generic: barrier: Add
 smp_cond_load_relaxed_timeout()
Message-ID: <20260212095621.4d99317b@pumpkin>
In-Reply-To: <20260209023153.2661784-2-ankur.a.arora@oracle.com>
References: <20260209023153.2661784-1-ankur.a.arora@oracle.com>
	<20260209023153.2661784-2-ankur.a.arora@oracle.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  8 Feb 2026 18:31:42 -0800
Ankur Arora <ankur.a.arora@oracle.com> wrote:

> Add smp_cond_load_relaxed_timeout(), which extends
> smp_cond_load_relaxed() to allow waiting for a duration.
> 
> We loop around waiting for the condition variable to change while
> peridically doing a time-check. The loop uses cpu_poll_relax() to slow
> down the busy-waiting, which, unless overridden by the architecture
> code, amounts to a cpu_relax().
> 
> Note that there are two ways for the time-check to fail: the usual
> timeout case or, @time_expr_ns returning an invalid value (negative
> or zero). The second failure mode allows for clocks attached to the
> clock-domain of @cond_expr, which might cease to operate meaningfully
> once some state internal to @cond_expr has changed.
> 
> Evaluation of @time_expr_ns: in the fastpath we want to keep the
> performance close to smp_cond_load_relaxed(). To do that we defer
> evaluation of the potentially costly @time_expr_ns to when we hit
> the slowpath.
> 
> This also means that there will always be some hardware dependent
> duration that has passed in cpu_poll_relax() iterations at the time of
> first evaluation. Additionally cpu_poll_relax() is not guaranteed to
> return at timeout boundary. In sum, expect timeout overshoot when we
> exit due to expiration of the timeout.
> 
> The number of spin iterations before time-check, SMP_TIMEOUT_POLL_COUNT
> is chosen to be 200 by default. With a cpu_poll_relax() iteration
> taking ~20-30 cycles (measured on a variety of x86 platforms), we expect
> a tim-check every ~4000-6000 cycles.
    ^ time-check

Plus the cost of evaluating cond_expr 200 times.
I guess that isn't expected to contain a PCIe read :-)

	David

> 
> The outer limit of the overshoot is double that when working with the
> parameters above. This might be higher or lower depending on the
> implementation of cpu_poll_relax() across architectures.
> 
> Lastly, config option ARCH_HAS_CPU_RELAX indicates availability of a
> cpu_poll_relax() that is cheaper than polling. This might be relevant
> for cases with a prolonged timeout.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
> Notes:
>   - Defer evaluation of @time_expr_ns to when we hit the slowpath.
>   - This also helps get rid of the labelled gotos which were used to
>     handle the early failure case (since now there's no early init
>     to be concerned with.)
>   - Add a comment mentioning that the cpu_poll_relax() implementation
>     is better than polling if ARCH_HAS_CPU_RELAX.
> 
>  include/asm-generic/barrier.h | 72 +++++++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
> 
> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> index d4f581c1e21d..2738fe35c1df 100644
> --- a/include/asm-generic/barrier.h
> +++ b/include/asm-generic/barrier.h
> @@ -273,6 +273,68 @@ do {									\
>  })
>  #endif
>  
> +/*
> + * Number of times we iterate in the loop before doing the time check.
> + */
> +#ifndef SMP_TIMEOUT_POLL_COUNT
> +#define SMP_TIMEOUT_POLL_COUNT		200
> +#endif
> +
> +/*
> + * Platforms with ARCH_HAS_CPU_RELAX have a cpu_poll_relax() implementation
> + * that is expected to be cheaper (lower power) than pure polling.
> + */
> +#ifndef cpu_poll_relax
> +#define cpu_poll_relax(ptr, val, timeout_ns)	cpu_relax()
> +#endif
> +
> +/**
> + * smp_cond_load_relaxed_timeout() - (Spin) wait for cond with no ordering
> + * guarantees until a timeout expires.
> + * @ptr: pointer to the variable to wait on.
> + * @cond: boolean expression to wait for.
> + * @time_expr_ns: expression that evaluates to monotonic time (in ns) or,
> + *  on failure, returns a negative value.
> + * @timeout_ns: timeout value in ns
> + * Both of the above are assumed to be compatible with s64; the signed
> + * value is used to handle the failure case in @time_expr_ns.
> + *
> + * Equivalent to using READ_ONCE() on the condition variable.
> + *
> + * Callers that expect to wait for prolonged durations might want to
> + * take into account the availability of ARCH_HAS_CPU_RELAX.
> + */
> +#ifndef smp_cond_load_relaxed_timeout
> +#define smp_cond_load_relaxed_timeout(ptr, cond_expr,			\
> +				      time_expr_ns, timeout_ns)		\
> +({									\
> +	typeof(ptr) __PTR = (ptr);					\
> +	__unqual_scalar_typeof(*ptr) VAL;				\
> +	u32 __n = 0, __spin = SMP_TIMEOUT_POLL_COUNT;			\
> +	s64 __timeout = (s64)timeout_ns;				\
> +	s64 __time_now, __time_end = 0;					\
> +									\
> +	for (;;) {							\
> +		VAL = READ_ONCE(*__PTR);				\
> +		if (cond_expr) 						\
> +			break;						\
> +		cpu_poll_relax(__PTR, VAL, (u64)__timeout);		\
> +		if (++__n < __spin)					\
> +			continue;					\
> +		__time_now = (s64)(time_expr_ns);			\
> +		if (unlikely(__time_end == 0))				\
> +			__time_end = __time_now + __timeout;		\
> +		__timeout = __time_end - __time_now;			\
> +		if (__time_now <= 0 || __timeout <= 0) {		\
> +			VAL = READ_ONCE(*__PTR);			\
> +			break;						\
> +		}							\
> +		__n = 0;						\
> +	}								\
> +	(typeof(*ptr))VAL;						\
> +})
> +#endif
> +
>  /*
>   * pmem_wmb() ensures that all stores for which the modification
>   * are written to persistent storage by preceding instructions have

