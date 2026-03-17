Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B684839D6F1;
	Tue, 17 Mar 2026 10:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773745158; cv=none; b=iZKVPcz2bQy3bG6rG1g1m4weN2zaz9VhHfqL/BahvZiiu1nSRKBQFkdTDBQYuFheThROQnxGmQ8rfDorZdXzl4lkV2Tl+kS0UZUsxPm0FTFxKmJPrVk8kYTxQVaNl+gC/j/vDlSK13XWIxUw7dhiL1jbgNDmZrVkz2jmOELqEsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773745158; c=relaxed/simple;
	bh=ALJW+MzngJRBkH704bJXjyUFE5onbGjmmTa9DDthDyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZxL1MLwMV19PUqJATsGZ60UgAXNI6zktQoNvuLaqWyIWYbvmMKVuNTMZ+e8uDFjxrScdhqJSyWbLth2M2OIZQ7GHETCoqBXRUsWUeWjMa96r2mRxG5Y9ErbmIMCxCBbhdqlRlvrGHpvJ1gEme8ftVpIffOrkQXDicSmASQGNqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Gdzb0Y+0; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gdzb0Y+0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pIH1Welsu4HqhnTP7lYnsI/LP0oXaXAice9C+T5Btc4=; b=Gdzb0Y+0oCbkCGe4/yLDEHzx6F
	tFlhQTlL5534grbnzp7V7VBtwNsgeomVEjUvG61C5lsYD002onKantrcyVTWzD3T9IsGRvMz7fBKB
	ZO7jFJRJ2Ukld92aDjHVZ+9g0nZ2ixHkmwiXlYJ/rvD8YRadih6xqI4FRY6T+X658dcTLrz5j8KJi
	vYpDHXWqhSQTVUR4I+eZ3/tG1X8AsIAdzTMfZaH0rWCeEgKVEW82obVGuDo81F5v7E3KWMCgx0MYn
	hPnbZ+fjQ3te3mmauw9Yyo/3fWuE8o5NV7V1OrjaMegmsq9iee6Wxf5PldzURFhnMqxTKxRdg4RZl
	1bHtNRFA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2S8P-00000008lnl-0uCW;
	Tue, 17 Mar 2026 10:58:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B64BB303244; Tue, 17 Mar 2026 11:58:48 +0100 (CET)
Date: Tue, 17 Mar 2026 11:58:48 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oleg@redhat.com,
	chenhuacai@kernel.org, kernel@xen0n.name, hca@linux.ibm.com,
	gor@linux.ibm.com, agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com, svens@linux.ibm.com, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, arnd@arndb.de, luto@kernel.org, shuah@kernel.org,
	kees@kernel.org, wad@chromium.org, kevin.brodsky@arm.com,
	deller@gmx.de, macro@orcam.me.uk, akpm@linux-foundation.org,
	ldv@strace.io, anshuman.khandual@arm.com, ryan.roberts@arm.com,
	mark.rutland@arm.com, thuth@redhat.com, song@kernel.org,
	ada.coupriediaz@arm.com, linusw@kernel.org, broonie@kernel.org,
	pengcan@kylinos.cn, liqiang01@kylinos.cn, ziyao@disroot.org,
	guanwentao@uniontech.com, guoren@kernel.org,
	schuster.simon@siemens-energy.com, jremus@linux.ibm.com,
	david@kernel.org, mathieu.desnoyers@efficios.com,
	edumazet@google.com, kmal@cock.li, dvyukov@google.com,
	reddybalavignesh9979@gmail.com, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-s390@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v13 RESEND 09/14] arm64: entry: Convert to generic entry
Message-ID: <20260317105848.GD3738010@noisy.programming.kicks-ass.net>
References: <20260317082020.737779-1-ruanjinjie@huawei.com>
 <20260317082020.737779-10-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317082020.737779-10-ruanjinjie@huawei.com>

On Tue, Mar 17, 2026 at 04:20:15PM +0800, Jinjie Ruan wrote:

>  include/linux/irq-entry-common.h      |   8 --
>  include/linux/rseq_entry.h            |  18 ---
>  11 files changed, 127 insertions(+), 209 deletions(-)

Excellent,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-common.h
> index d26d1b1bcbfb..6519b4a30dc1 100644
> --- a/include/linux/irq-entry-common.h
> +++ b/include/linux/irq-entry-common.h
> @@ -236,14 +236,6 @@ static __always_inline void __exit_to_user_mode_validate(void)
>  	lockdep_sys_exit();
>  }
>  
> -/* Temporary workaround to keep ARM64 alive */
> -static __always_inline void exit_to_user_mode_prepare_legacy(struct pt_regs *regs)
> -{
> -	__exit_to_user_mode_prepare(regs);
> -	rseq_exit_to_user_mode_legacy();
> -	__exit_to_user_mode_validate();
> -}
> -
>  /**
>   * syscall_exit_to_user_mode_prepare - call exit_to_user_mode_loop() if required
>   * @regs:	Pointer to pt_regs on entry stack
> diff --git a/include/linux/rseq_entry.h b/include/linux/rseq_entry.h
> index c6831c93cd6e..e9c4108ac514 100644
> --- a/include/linux/rseq_entry.h
> +++ b/include/linux/rseq_entry.h
> @@ -743,24 +743,6 @@ static __always_inline void rseq_irqentry_exit_to_user_mode(void)
>  	ev->events = 0;
>  }
>  
> -/* Required to keep ARM64 working */
> -static __always_inline void rseq_exit_to_user_mode_legacy(void)
> -{
> -	struct rseq_event *ev = &current->rseq.event;
> -
> -	rseq_stat_inc(rseq_stats.exit);
> -
> -	if (static_branch_unlikely(&rseq_debug_enabled))
> -		WARN_ON_ONCE(ev->sched_switch);
> -
> -	/*
> -	 * Ensure that event (especially user_irq) is cleared when the
> -	 * interrupt did not result in a schedule and therefore the
> -	 * rseq processing did not clear it.
> -	 */
> -	ev->events = 0;
> -}
> -
>  void __rseq_debug_syscall_return(struct pt_regs *regs);
>  
>  static __always_inline void rseq_debug_syscall_return(struct pt_regs *regs)
> -- 
> 2.34.1
> 
