Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344D739B970;
	Mon, 31 Aug 2026 21:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211013; cv=none; b=l2RI40BbmkMTxDVOjVMvAI8sBV5/cF+Km0PKUy0Cn4UPSWDeVx/SCWlkhb4HJBDVPAudJBjFEJzeX20vql8zq1IYp6NgqL3dgtTF6SB3/oTiyy2x4QgaZ0vf2AoNcA3s/yjqjUa20lCzSZeSM81UdS71nN9G4yMIJQPp83hAZbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211013; c=relaxed/simple;
	bh=HDzH4BfkFfYF2HiJOyMC0U8jlmXAPDOVIzI6ratRymQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=a4NAo4ycayFGPNVLFEkPQeWfM6fajlTEwAWdjZdml9RCxE0iP+ZiC/3fIorLud1KLnzPQ0yWIOWUT5w8AFL5KRG9kCenAoda8Q2w/VmhgpVEntYX2OZS1DruiQIs4sEvQZp+gYtynOt2qfTPMZirjuBL1iTmWXxlY3BxhasEeJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=itq7NxD7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="itq7NxD7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 737E01F00A3D;
	Mon, 31 Aug 2026 21:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788211011;
	bh=IdM1XWvxdz+i+Rsaxc9nZdXh9vkCMN0AcdrsPyDFCUM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=itq7NxD7qwmq1xmxdpookRc81QBC5kaIq8xQaBqCGgKusKyX2UJgkoUdS86Ea5Y1Y
	 svlYC+us9vhfKNusMI8tEE3IHtPuS2yu7yiQJQ+1z4bPAKz4w2cl+5qJCtkHHReQl5
	 RtppBRcJHxPRciXfV+EFnfPp/ukpJ2oYu8+Zh75I2UWhNTJELVBg5dYzrzz9ve5smt
	 bSYu9lE1pod27Ip0LVB4IzQdAWgUt3xW2xCTyD8TgbiYGbLALVoe5IxNIZLe7Qbh1o
	 2uv63aw8LMQL8EJ6BRhxM3WOOmzgl1QZtjQFXr7fRaDq/+IEEFKlAv7fqclKqsiDdV
	 EEbV/VwFFaBvQ==
Content-Type: multipart/mixed; boundary="===============5519600281003427931=="
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <dff2cd4bf7142cbeeb7030ffda447910f42a67c49ac91021c09c0c3a24a80553@mail.kernel.org>
In-Reply-To: <20260831202251.305046-10-ankur.a.arora@oracle.com>
References: <20260831202251.305046-10-ankur.a.arora@oracle.com>
Subject: Re: [PATCH v15 09/16] bpf/rqspinlock: switch check_timeout() to a clock interface
From: bot+bpf-ci@kernel.org
To: ankur.a.arora@oracle.com,linux-kernel@vger.kernel.org,linux-arch@vger.kernel.org,linux-arm-kernel@lists.infradead.org,linux-pm@vger.kernel.org,bpf@vger.kernel.org
Cc: arnd@arndb.de,catalin.marinas@arm.com,will@kernel.org,peterz@infradead.org,akpm@linux-foundation.org,mark.rutland@arm.com,harisokn@amazon.com,cl@gentwo.org,ast@kernel.org,rafael@kernel.org,daniel.lezcano@linaro.org,memxor@gmail.com,zhenglifeng1@huawei.com,xueshuai@linux.alibaba.com,rdunlap@infradead.org,david.laight.linux@gmail.com,broonie@kernel.org,joao.m.martins@oracle.com,boris.ostrovsky@oracle.com,konrad.wilk@oracle.com,ashok.bhat@arm.com,ankur.a.arora@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 31 Aug 2026 21:16:50 +0000 (UTC)

--===============5519600281003427931==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
> index 111ec80ea958..1b249c6f0674 100644
> --- a/kernel/bpf/rqspinlock.c
> +++ b/kernel/bpf/rqspinlock.c

[ ... ]

> @@ -196,8 +196,12 @@ static noinline int check_deadlock_ABBA(rqspinlock_t *lock, u32 mask)
>  	return 0;
>  }
>
> -static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
> -				  struct rqspinlock_timeout *ts)
> +/*
> + * Returns current monotonic time in ns on success or, negative errno
> + * value on failure due to timeout expiration or detection of deadlock.
> + */
> +static noinline s64 clock_deadlock(rqspinlock_t *lock, u32 mask,
> +				   struct rqspinlock_timeout *ts)
>  {

This isn't a bug, but could the commit message mention that
check_timeout() is renamed to clock_deadlock()? The subject and body
still refer to check_timeout(), but readers of the patch will see
clock_deadlock() in the diff.

Also, the changelog describes what the new interface does but not why
it's needed. Could it note that the clock return value is what the
following patch feeds to smp_cond_load_acquire_timeout()?

[ ... ]

> @@ -231,15 +239,22 @@ static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
>   * as the macro does internal amortization for us.
>   */
>  #ifndef res_smp_cond_load_acquire
> -#define RES_CHECK_TIMEOUT(ts, ret, mask)                              \
> -	({                                                            \
> -		if (!(ts).spin++)                                     \
> -			(ret) = check_timeout((lock), (mask), &(ts)); \
> -		(ret);                                                \
> +#define RES_CHECK_TIMEOUT(ts, ret, mask)					\
> +	({									\
> +		s64 __timeval_err = 0;						\
> +		if (!(ts).spin++)						\
> +			__timeval_err = clock_deadlock((lock), (mask), &(ts));	\
> +		(ret) = __timeval_err < 0 ? __timeval_err : 0;			\
> +		__timeval_err;							\
>  	})
>  #else
> -#define RES_CHECK_TIMEOUT(ts, ret, mask)			      \
> -	({ (ret) = check_timeout((lock), (mask), &(ts)); })
> +#define RES_CHECK_TIMEOUT(ts, ret, mask)					\
> +	({									\
> +		s64 __timeval_err;						\
> +		__timeval_err = clock_deadlock((lock), (mask), &(ts));		\
> +		(ret) = __timeval_err < 0 ? __timeval_err : 0;			\
> +		__timeval_err;							\
> +	})
>  #endif

This isn't a bug, but since the previous patch removed the last
definition of res_smp_cond_load_acquire, is the #else arm still
reachable, or could it be dropped here rather than updated?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33438155296
--===============5519600281003427931==--
