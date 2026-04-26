Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F5C26AC3;
	Sun, 26 Apr 2026 18:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777226882; cv=none; b=gzvu6+CJFqNyaP8i3gdF7gRTrlmlrhxgApKLxEU4SlO3+HtAZWcC31zdugUm1W/ObwRsyufhBawGH5LPkR0rgWh4VhnJNd+mGZ2c24U/UMgp/8JLoo2QPqX4obqBaYu+5LfGEug7stTWSXtFUBF0omN8ld/4w8SbuIS4fc+vAnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777226882; c=relaxed/simple;
	bh=zc5aB7NvKWadhiFZbK5wv5oaFDwCfrp1MnjPGqyFYVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXaVf0vDKfzmmmMNmLK0blN413mbFwblbv6dNjvQIeB5qkB1i82HNJPS8hFyc5d/rIvA+p9zFkv8TyA5BgE4tWdqGYTx+ea1E9FMkPW3qy4MwIdqzTOj5SNzduOS2yYyLkumP9TBRO0xr2zC7qND/W0t7EO9fmVxVkPF56a2L34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=YcTJAX4D; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="YcTJAX4D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1777226871;
	bh=zc5aB7NvKWadhiFZbK5wv5oaFDwCfrp1MnjPGqyFYVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YcTJAX4DGL57HRJLhNgUfb3LeKKyyQRppts6WZnVt1V5nhKTm4r55YbNo7GMOUg+/
	 Inp6fVnTwhsyKzp1mJkqRVizOVcLrrVOmJ4zTug9QWPMrCp8t5AI/RTVZJQPc6ka12
	 Bd79Q8E6pcx9xr1OVRLTK3APW0zdqHJuD/oLbJNE=
Date: Sun, 26 Apr 2026 20:07:49 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Carlos O'Donell <carlos@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Florian Weimer <fweimer@redhat.com>, 
	Rich Felker <dalias@aerifal.cx>, Torvald Riegel <triegel@redhat.com>, 
	Darren Hart <dvhart@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Uros Bizjak <ubizjak@gmail.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	kernel-dev@igalia.com
Subject: Re: [PATCH RFC v2 1/2] arm64: vdso: Prepare for robust futex unlock
 support
Message-ID: <f8e83a24-0b04-4c88-9f67-0879875be25c@t-8ch.de>
References: <20260424-tonyk-robust_arm-v2-0-db4e46f752cf@igalia.com>
 <20260424-tonyk-robust_arm-v2-1-db4e46f752cf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260424-tonyk-robust_arm-v2-1-db4e46f752cf@igalia.com>

Hi André,

Some more comments, after doing an actual proper review.

On 2026-04-24 15:56:00-0300, André Almeida wrote:
> There will be a VDSO function to unlock non-contended robust futexes in
> user space. The unlock sequence is racy vs. clearing the list_pending_op
> pointer in the task's robust list head. To plug this race the kernel needs
> to know the critical section window so it can clear the pointer when the
> task is interrupted within that race window. The window is determined by
> labels in the inline assembly.
> 
> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> ---
> Changes from v1:
>  - Fixed linker not finding VDSO symbols
> ---
>  arch/arm64/kernel/vdso.c          | 30 ++++++++++++++++++++++++++++++
>  arch/arm64/kernel/vdso/vdso.lds.S |  7 +++++++
>  2 files changed, 37 insertions(+)

What is the reason for splitting the series into two patches?
To me it looks like it should be one patch.

> diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
> index 592dd8668de4..f9c520a1c942 100644
> --- a/arch/arm64/kernel/vdso.c
> +++ b/arch/arm64/kernel/vdso.c
> @@ -11,6 +11,7 @@
>  #include <linux/clocksource.h>
>  #include <linux/elf.h>
>  #include <linux/err.h>
> +#include <linux/futex.h>
>  #include <linux/errno.h>
>  #include <linux/gfp.h>
>  #include <linux/kernel.h>
> @@ -57,6 +58,33 @@ static struct vdso_abi_info vdso_info[] __ro_after_init = {
>  #endif /* CONFIG_COMPAT_VDSO */
>  };
>  
> +#ifdef CONFIG_FUTEX_ROBUST_UNLOCK
> +static void vdso_futex_robust_unlock_update_ips(enum vdso_abi abi, struct mm_struct *mm)
> +{
> +	unsigned long vdso = (unsigned long) mm->context.vdso;
> +	struct futex_mm_data *fd = &mm->futex;
> +	uintptr_t success, end;
> +
> +	if (abi == VDSO_ABI_AA64) {
> +		success = (uintptr_t) VDSO_SYMBOL(vdso, futex_list64_try_unlock_cs_success);
> +		end = (uintptr_t) VDSO_SYMBOL(vdso, futex_list64_try_unlock_cs_end);
> +
> +		futex_set_vdso_cs_range(fd, 0, vdso, success, end, false);

Both VDSO_SYMBOL() and futex_set_vdso_cs_range() add the vdso base
address to the symbol offsets. The value stored in .start_ip will be
wrong. The fact that futex_set_vdso_cs_range() does the addition looks
like an artifact of it being written for x86 first. IMO its interface
should be changed not to do the addition internally.

> +	}
> +
> +#ifdef CONFIG_COMPAT_VDSO
> +	if (abi == VDSO_ABI_AA32) {
> +		success = (uintptr_t) VDSO_SYMBOL(vdso, futex_list32_try_unlock_cs_success);
> +		end = (uintptr_t) VDSO_SYMBOL(vdso, futex_list32_try_unlock_cs_end);
> +
> +		futex_set_vdso_cs_range(fd, 1, vdso, success, end, true);
> +	}
> +#endif
> +}
> +#else
> +static inline void vdso_futex_robust_unlock_update_ips(enum vdso_abi abi, struct mm_struct *mm) { }
> +#endif /* CONFIG_FUTEX_ROBUST_UNLOCK */
> +
>  static int vdso_mremap(const struct vm_special_mapping *sm,
>  		struct vm_area_struct *new_vma)
>  {

(...)
