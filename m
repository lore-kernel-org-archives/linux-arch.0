From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [RFC PATCH v3 1/2] membarrier: Provide register expedited
 private command
Date: Fri, 22 Sep 2017 16:59:59 +0800
Message-ID: <20170922085959.GG10893@tardis>
References: <20170919221342.29915-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lHGcFxmlz1yfXmOs"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35410 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751808AbdIVJEP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Sep 2017 05:04:15 -0400
Content-Disposition: inline
In-Reply-To: <20170919221342.29915-1-mathieu.desnoyers@efficios.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, Andrew Hunter <ahh@google.com>, Maged Michael <maged.michael@gmail.com>, gromer@google.com, Avi Kivity <avi@scylladb.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Dave Watson <davejwatson@fb.com>, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>, linux-arch@vger.kernel.org


--lHGcFxmlz1yfXmOs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 19, 2017 at 06:13:41PM -0400, Mathieu Desnoyers wrote:
[...]
> +static inline void membarrier_arch_sched_in(struct task_struct *prev,
> +		struct task_struct *next)
> +{
> +	/*
> +	 * Only need the full barrier when switching between processes.
> +	 */
> +	if (likely(!test_ti_thread_flag(task_thread_info(next),
> +			TIF_MEMBARRIER_PRIVATE_EXPEDITED)
> +				|| prev->mm == next->mm))

And we also don't need the smp_mb() if !prev->mm, because switching from
kernel to user will have a smp_mb() implied by mmdrop()?

> +		return;
> +
> +	/*
> +	 * The membarrier system call requires a full memory barrier
> +	 * after storing to rq->curr, before going back to user-space.
> +	 */
> +	smp_mb();
> +}

[...]

> +static inline void membarrier_fork(struct task_struct *t,
> +		unsigned long clone_flags)
> +{
> +	if (!current->mm || !t->mm)
> +		return;
> +	t->mm->membarrier_private_expedited =
> +		current->mm->membarrier_private_expedited;

Have we already done the copy of ->membarrier_private_expedited in
copy_mm()?

Regards,
Boqun

> +	membarrier_arch_fork(t, clone_flags);
> +}
> +static inline void membarrier_execve(struct task_struct *t)
> +{
> +	t->mm->membarrier_private_expedited = 0;
> +	membarrier_arch_execve(t);
> +}
> +#else
> +static inline void membarrier_sched_in(struct task_struct *prev,
> +		struct task_struct *next)
> +{
> +}
> +static inline void membarrier_fork(struct task_struct *t,
> +		unsigned long clone_flags)
> +{
> +}
> +static inline void membarrier_execve(struct task_struct *t)
> +{
> +}
> +#endif
> +
[...]

--lHGcFxmlz1yfXmOs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlnE0QwACgkQSXnow7UH
+rhCVQf+IhTZRUW/ntVGWcPAjRpCk5QP/62TRsYs+jdCDl2ieycED3WVRfqpT9fE
2lmY5tsMO7qaqM2AxXFI5kpgTyKPiAnYOo1nKsgXVQgW/pLLz/67q1ZXDMGfLreF
yim1jtI31/5JQiefHkB+n2boQJF3C0m8KzL8qo5ypBBWMWyK5ofK14J/p+9Rwh4K
ojw2Hvp4QZdWmSysNASNZR0qupsot3AnAVk5qRno3syQ6NbJh/MZHjm9tJnoJC4N
7y2AvZ219BZ9PEJuratyPS4DMgOkZN1pZCUiuzy+MhSS+SHmaGglWsdy9O+WVLP0
8PPJ9x09MNZaeaLN0jqWz1yOHNAIuw==
=fgzU
-----END PGP SIGNATURE-----

--lHGcFxmlz1yfXmOs--
