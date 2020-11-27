Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C61C63798
	for <linux-arch@archiver.kernel.org>; Fri, 27 Nov 2020 13:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D695B22242
	for <linux-arch@archiver.kernel.org>; Fri, 27 Nov 2020 13:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbgK0NMW (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 27 Nov 2020 08:12:22 -0500
Received: from foss.arm.com ([217.140.110.172]:41224 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729913AbgK0NMW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 27 Nov 2020 08:12:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07A0C30E;
        Fri, 27 Nov 2020 05:12:22 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C9A4E3F70D;
        Fri, 27 Nov 2020 05:12:19 -0800 (PST)
Date:   Fri, 27 Nov 2020 13:12:17 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH v4 04/14] arm64: Kill 32-bit applications scheduled on
 64-bit-only CPUs
Message-ID: <20201127131217.skekrybqjdidm5ki@e107158-lin.cambridge.arm.com>
References: <20201124155039.13804-1-will@kernel.org>
 <20201124155039.13804-5-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201124155039.13804-5-will@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/24/20 15:50, Will Deacon wrote:
> Scheduling a 32-bit application on a 64-bit-only CPU is a bad idea.
> 
> Ensure that 32-bit applications always take the slow-path when returning
> to userspace on a system with mismatched support at EL0, so that we can
> avoid trying to run on a 64-bit-only CPU and force a SIGKILL instead.
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> ---

nit: We drop this patch at the end. Can't we avoid it altogether instead?

[...]

> diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> index a8184cad8890..bcb6ca2d9a7c 100644
> --- a/arch/arm64/kernel/signal.c
> +++ b/arch/arm64/kernel/signal.c
> @@ -911,6 +911,19 @@ static void do_signal(struct pt_regs *regs)
>  	restore_saved_sigmask();
>  }
>  
> +static bool cpu_affinity_invalid(struct pt_regs *regs)
> +{
> +	if (!compat_user_mode(regs))
> +		return false;

Silly question. Is there an advantage of using compat_user_mode() vs
is_compat_task()? I see the latter used in the file although struct pt_regs
*regs is passed to the functions calling it.

Nothing's wrong with it, just curious.

Thanks

--
Qais Yousef

> +
> +	/*
> +	 * We're preemptible, but a reschedule will cause us to check the
> +	 * affinity again.
> +	 */
> +	return !cpumask_test_cpu(raw_smp_processor_id(),
> +				 system_32bit_el0_cpumask());
> +}
