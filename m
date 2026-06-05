Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85135407571;
	Fri,  5 Jun 2026 06:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780641607; cv=none; b=XYLjoFEHioD3a8bscVu5wEMBu8F1gaCuKHzM+1ld0xNnu+bjdyNC9C6WTzS42oNcvEDmHGU3MYm2bgUly+Kmvqg3gRvxie0GZBwRnQNpOp5wf0UF25yUhOnWq5zoWPz+OwXK1rDoMe93CahICBCB3Nq1STM0RLHU78eyEIvA+Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780641607; c=relaxed/simple;
	bh=Sqsktppb0Mid02mXFy7U5N2GOkZIVg+cj6qbUr9DEuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iT2aDKYVaxukbEx87bhTML+F7Ea9r8hncFHHengBrQJRFmnBRGj6+EiJHGm2lvoTO9jywf7KsqitX+2zVwjHjbyX+RegDYm0SJOXe2Rz1yybUEbIIQD2hUO/OEgxqaeR1MbImqNeWPlJCABoC/e5hyixA4hoyI6uY+zsVfBqX0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCwpRhpl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCwpRhpl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A5F21F00899;
	Fri,  5 Jun 2026 06:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780641606;
	bh=DY5lQMmxnI3uPjy+HsvkNcAQVWz09l4bSQCGxX64lwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SCwpRhpllZT0DflijqLdXa7P0UzHVOcvFnhaubpEXRFqatgHZsLoRQoa6UxH9/7Gu
	 A4WzWIytQBIgLL/mVxxHYeurTihmY3bXue2rtX1SH1qiQYqubxaisD8gf6kf9PciWv
	 36vpij0sTcjLyUHPSsW5NP6QZcZ8X8SCqB6qSVh8nMLeVylOaO3RWxSc3rmgeZF/D1
	 yFCo0bJKUI1L+SULclOJdgKelkKAjdmRROIlNiGTaNTnoeCoHBHWe4l7q1USgax3Nj
	 52rHxOP4AIM/CqwoWll7HOtWPS1oU8Cv1EcW7GrJK7K1AGql1xbIOt0q5q+SObPjmJ
	 FkacklmJRjzXQ==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id B70ACF4006E;
	Fri,  5 Jun 2026 02:40:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 05 Jun 2026 02:40:01 -0400
X-ME-Sender: <xms:QW8ial2TUUzWCAP6co1jWb7CI4x3g-5Pq9qQ4vuEp7Kwc9ZG8veMxA>
    <xme:QW8iamfRUz2t9RKucbDpWrZaYjLiPUZ-GscI5nE9oQWkas_hye0rNGOl0pwzWNgOu
    l9bdWbRFIHnZmF3fJP5okRghIOheZMuYov7Mfk0hHwHwKgk56tggg>
X-ME-Received: <xmr:QW8iamruRw1zbvmPvqzV9_K6fZekyGN8AxGjTnQgk-qUFHMxb8km_Z5kybg>
X-ME-Proxy-Cause: dmFkZTFLWWdWQ5yOtjyAoTSNdapbF5O9v5FYeP09oEn6GipmmCjtdlXjTTKTx73+TWqgNB
    hwiGw8o0ugRfCGCDxQmnhTdVFJWduY/2eQrvWZWTBWilYm11fCIdENjkjGBcYlC42gMkJa
    Ul38fP6hVwrZVZKF7vLXr1xSKtoSdJMHKAtCkY9OVF0RDdMMWjiQmlSvZMWy3Usn1OiL5I
    3/WXi8wUNHyAzz1oSC4Cbsq2buM8fcqNt9OiPTSFj0mW6GYiLa8ZcCwN9tXicwVQ1BR8kI
    gRdcfnleMO8dHQFRVCHs7DtVHFCRJmsbHqeoRG9M6nUCK/R/efMEvYDDKFTt9+8xvriaFO
    isDgnP7yc93BZPEG/WDk+bvwFyqnW6qYvd3Cbm0YG9a37mTkpVqf7p/kaqQWM44PInd2yy
    LWj4vD+1RxPdMlyAEpfNOjtsylpAFq9wWhNgPDroJlHU1q1RsiF/uH6A12ZBUWNc3qf5vF
    ECxsWvtYgR4M9kUsE8LcPxBihBMJjgC9lIpNpeHGfVkdWkJj2bJXWsoNhipnbKVUMk0enV
    gyoul5WryjKwF/cLIuHjwndZJMkDYbEmv1F8yysuSBUZaBYYYj5/mVrOZ21VldUf5woOI/
    cr0j13cgqRGDBfIweTl8erPGSABDzKhcdpnHHYuip+Qai2KNMnJtyjg4DCnw
X-ME-Proxy: <xmx:QW8iagXSJeiA0BpAOFMNNa_qhk3-kyfc5yFdU_disTgZJSRx5xGe-g>
    <xmx:QW8iam3P0sldLLp_B5G68gif9eaRdOoDa1597cKkl96alRLVBt8xMw>
    <xmx:QW8iaiCe_gKhV4eurA2AtcISGUX_4jIZEEo6IZdAPeN7rsP4SapfIg>
    <xmx:QW8iasOBsi_D2XpdA3kLAVmylf2BVWrhgk-fCAJ4GbQIMPgLk12rEQ>
    <xmx:QW8iargk-FdnGJ9uLyxfdgNMCTYL75Ao1DKpSAfM6hjeNFJFXWWKbyxv>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 02:40:00 -0400 (EDT)
Date: Thu, 4 Jun 2026 23:40:00 -0700
From: Boqun Feng <boqun@kernel.org>
To: bot+bpf-ci@kernel.org
Cc: peterz@infradead.org, catalin.marinas@arm.com, will@kernel.org,
	jonas@southpole.se, stefan.kristiansson@saunalahti.fi,	shorne@gmail.com,
 hca@linux.ibm.com, gor@linux.ibm.com,	agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com,	svens@linux.ibm.com, tglx@kernel.org,
 mingo@redhat.com,	bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org,	hpa@zytor.com, arnd@arndb.de, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, kprateek.nayak@amd.com, longman@redhat.com,
	akpm@linux-foundation.org, andrii@kernel.org, eddyz87@gmail.com,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	jolsa@kernel.org, shuah@kernel.org, ojeda@kernel.org,	gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org,	a.hindborg@kernel.org,
 aliceryhl@google.com, tmgross@umich.edu,	dakr@kernel.org,
 ruanjinjie@huawei.com, lyude@redhat.com,	thuth@redhat.com,
 sohil.mehta@intel.com,	pawan.kumar.gupta@linux.intel.com,
 seanjc@google.com,	nikunj@amd.com, xin@zytor.com, joelagnelf@nvidia.com,
	andriy.shevchenko@linux.intel.com, rdunlap@infradead.org,
	ynorov@nvidia.com, bigeasy@linutronix.de,	linux-kernel@vger.kernel.org,
 linux-openrisc@vger.kernel.org,	linux-s390@vger.kernel.org,
 linux-arch@vger.kernel.org,	bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org,	rust-for-linux@vger.kernel.org,
 boqun.feng@gmail.com,	martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
Subject: Re: [PATCH v3 05/13] irq & spin_lock: Add counted interrupt
 disabling/enabling
Message-ID: <aiJvQIiDiXvu5x01@tardis-2.local>
References: <20260605054128.5925-6-boqun@kernel.org>
 <cc4b5fb3f63b8b508334edd883765bf81c9ab1d2045f414a74c8712c6cc705e9@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc4b5fb3f63b8b508334edd883765bf81c9ab1d2045f414a74c8712c6cc705e9@mail.kernel.org>

On Fri, Jun 05, 2026 at 06:30:16AM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/include/linux/interrupt_rc.h b/include/linux/interrupt_rc.h
> > new file mode 100644
> > index 000000000000..dd4444c61330
> > --- /dev/null
> > +++ b/include/linux/interrupt_rc.h
> > @@ -0,0 +1,67 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * include/linux/interrupt_rc.h - refcounted local processor interrupt
> > + * management.
> > + *
> > + * Since the implementation of this API currently depends on
> > + * local_irq_save()/local_irq_restore(), we split this into it's own header to
> > + * make it easier to include without hitting circular header dependencies.
> > + */
> > +
> > +#ifndef __LINUX_INTERRUPT_RC_H
> > +#define __LINUX_INTERRUPT_RC_H
> > +
> > +#include <linux/irqflags.h>
> > +#include <asm/processor.h>
> > +#ifdef CONFIG_SMP
> > +#include <asm/smp.h>
> > +#endif
> > +
> > +/* Per-cpu interrupt disabling state for local_interrupt_{disable,enable}() */
> > +struct interrupt_disable_state {
> > +	unsigned long flags;
> > +};
> > +
> > +DECLARE_PER_CPU(struct interrupt_disable_state, local_interrupt_disable_state);
> > +
> > +static inline void local_interrupt_disable(void)
> > +{
> > +	unsigned long flags;
> > +	int new_count;
> > +
> > +	WARN_ON_ONCE(in_nmi());
> > +
> > +	new_count = hardirq_disable_enter();
> > +
> > +	/* Interrupts can happen here, but it's OK, see __irq_exit_rcu(). */
> > +
> > +	if ((new_count & HARDIRQ_DISABLE_MASK) == HARDIRQ_DISABLE_OFFSET) {
> > +		local_irq_save(flags);
> > +		raw_cpu_write(local_interrupt_disable_state.flags, flags);
> > +	}
> > +}
> > +
> > +static inline void local_interrupt_enable(void)
> > +{
> > +	int new_count;
> > +
> > +	new_count = hardirq_disable_exit();
> > +
> > +	if ((new_count & HARDIRQ_DISABLE_MASK) == 0) {
> > +		unsigned long flags;
> > +
> > +		flags = raw_cpu_read(local_interrupt_disable_state.flags);
> > +		local_irq_restore(flags);
> 
> Could this lead to indefinite softirq starvation? When __irq_exit_rcu()

Yes and no. There is no behavioral difference between here and
local_irq_enable(), neither will trigger softirqs.

> skips invoke_softirq() due to hardirq_disable_count() > 0, any scheduled
> softirqs (timers, RCU callbacks, networking) remain pending. When the
> outermost critical section ends and local_interrupt_enable() restores
> hardware interrupts, it doesn't check local_softirq_pending() to flush
> these deferred softirqs.
> 
> Will these pending softirqs stall until another unrelated hardware
> interrupt fires? In low-activity periods, this could potentially cause
> RCU stalls or network hangs. This concern was raised by the sashiko bot in
> both v2 and v3 but remains unaddressed:
> 
> https://lore.kernel.org/all/20260526175409.7CFCC1F000E9@smtp.kernel.org/
> 
> > +		/*
> > +		 * TODO: re-read preempt count can be avoided, but it needs
> > +		 * should_resched() taking another parameter as the current
> > +		 * preempt count
> > +		 */
> > +#ifdef CONFIG_PREEMPTION
> > +		if (should_resched(0))
> > +			__preempt_schedule();
> 
> Peter Zijlstra suggested in v2 replacing should_resched(0) with a direct
> check of new_count for preemption. His suggestion was "can't you simply
> write: if (!new_count) __preempt_schedule();" The author acknowledged this
> in discussion but hasn't implemented it in v3:
> 
> https://lore.kernel.org/all/20260528104322.GF343181@noisy.programming.kicks-ass.net/
> 
> Is there a reason to keep the more complex should_resched(0) approach, or
> would the direct check be more appropriate here?
> 

I have an optimization/cleanup patch in patch #13.

Regards,
Boqun

> > +#endif
> > +	}
> > +}
> > +
> > +#endif /* !__LINUX_INTERRUPT_RC_H */
> 
> [ ... ]
> 
> > diff --git a/kernel/softirq.c b/kernel/softirq.c
> > index 10af5ed859e7..d1ab1799794c 100644
> > --- a/kernel/softirq.c
> > +++ b/kernel/softirq.c
> > @@ -88,6 +88,9 @@ EXPORT_PER_CPU_SYMBOL_GPL(hardirqs_enabled);
> >  EXPORT_PER_CPU_SYMBOL_GPL(hardirq_context);
> >  #endif
> >
> > +DEFINE_PER_CPU(struct interrupt_disable_state, local_interrupt_disable_state);
> > +EXPORT_PER_CPU_SYMBOL_GPL(local_interrupt_disable_state);
> > +
> >  DEFINE_PER_CPU(unsigned int, nmi_nesting);
> >
> >  /*
> > @@ -728,7 +731,16 @@ static inline void __irq_exit_rcu(void)
> >  #endif
> >  	account_hardirq_exit(current);
> >  	preempt_count_sub(HARDIRQ_OFFSET);
> > -	if (!in_interrupt() && local_softirq_pending()) {
> > +	/*
> > +	 * Interrupts may happen between hardirq_disable_enter() and
> > +	 * local_irq_save() in local_interrupt_disable(), if irq_exit() invokes
> > +	 * softirq here, we may have a softirq handler calling
> > +	 * local_interrupt_disable() but it won't disable the irq because
> > +	 * hardirq disabling count is already 1, hence we need to prevent
> > +	 * invoking softirq when a local_interrupt_disable() is ongoing.
> > +	 */
> > +	if (!in_interrupt() && !hardirq_disable_count() &&
> > +	    local_softirq_pending()) {
> >  		/*
> >  		 * If we left hrtimers unarmed, make sure to arm them now,
> >  		 * before enabling interrupts to run SoftIRQ.
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26998319662

