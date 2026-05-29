Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7935637F8D3;
	Fri, 29 May 2026 17:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780074967; cv=none; b=aj8iib9QBrUytcvkz0GLz14HSNQ5j5SJ7i/w1OMug4r09EpdBC1vzaLE7zL96Nw5+HEMP75ESLDviOH7n5VBGHMDw7EI18y2ojlxW0WqBVenyYk6D4W2CR7XKs2Uo+dCU7cBEt/Y2ZXaR1/x9ObxbrEJ0RZ0G+pN6iTrXxKy5JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780074967; c=relaxed/simple;
	bh=L95GHZmYAQTJKgW7g7kahj7YK8csZe2RXrPZyUvKAyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2HDcL3ShHYuQU5tmSBnV+9E6yU+Glmo5w9tFRf27iKEH+tUl6cCvzSi7aBz7gyj59zcBoj9de5C7ifGiwptmwedeGOSB4BlK71gVpQa6G3y3tBzwwZrRPXaLL3+OrcexGlyeU6ZEdN/6cX2dPhYsrEdRZEJzSZiYEgSylxQ1ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Auy8Evdo; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Auy8Evdo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1780074963;
	bh=L95GHZmYAQTJKgW7g7kahj7YK8csZe2RXrPZyUvKAyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Auy8EvdoiOgGNaowDEEeICXp3g737L/FxtNK2LY/GohPaJtfn13AEd+hMQQF7v1Lh
	 93+0J+xn4akRX0FPRYE1+ziKaSROFmravW5R+1hFdGdhbUQ6vWwKKFLGX1YLcA1sS/
	 a3j+R9nXfS5qHVnc5O/a5fZEaAuAZAhbmBZ8nL7w=
Date: Fri, 29 May 2026 19:16:02 +0200
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
Subject: Re: [PATCH v3 1/5] arm64: vdso: Prepare for robust futex unlock
 support
Message-ID: <b23ab875-fd4c-4095-a661-6a19b6a070e3@t-8ch.de>
References: <20260529-tonyk-robust_arm-v3-0-a6f02684d4fe@igalia.com>
 <20260529-tonyk-robust_arm-v3-1-a6f02684d4fe@igalia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260529-tonyk-robust_arm-v3-1-a6f02684d4fe@igalia.com>

On 2026-05-29 13:33:53-0300, André Almeida wrote:
> There will be a VDSO function to unlock non-contended robust futexes in
> user space. The unlock sequence is racy vs. clearing the list_pending_op
> pointer in the task's robust list head. To plug this race the kernel needs
> to know the critical section window so it can clear the pointer when the
> task is interrupted within that race window. The window is determined by
> labels in the inline assembly.
> 
> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> ---
> Notes:
>  - The diff futex_set_vdso_cs_range() should happen in the commit that
>  introduced it, and rebase will clear it from here
>  - So far I couldn't figure out why current->rseq.event.user_irq is never set in
>  aarch64

Why not put these unrelated changes into their own commits?
It makes reviewing and integrating it into the original series easier.

> v3:
>  - Fix adding vdso base addr twice
>  - Call vdso_futex_robust_unlock_update_ips() on remap as well
> v2:
>  - Fixed linker not finding VDSO symbols
> ---
>  arch/arm64/kernel/vdso.c          | 25 +++++++++++++++++++++++++
>  arch/arm64/kernel/vdso/vdso.lds.S |  5 +++++
>  arch/x86/entry/vdso/vma.c         |  4 ++--
>  include/linux/futex.h             | 13 ++-----------
>  4 files changed, 34 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
> index 592dd8668de4..76f22ea8e181 100644
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
> @@ -57,11 +58,31 @@ static struct vdso_abi_info vdso_info[] __ro_after_init = {
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
> +		futex_set_vdso_cs_range(fd, 0, success, end, false);
> +	}
> +}
> +#else
> +static inline void vdso_futex_robust_unlock_update_ips(enum vdso_abi abi, struct mm_struct *mm) { }
> +#endif /* CONFIG_FUTEX_ROBUST_UNLOCK */
> +
>  static int vdso_mremap(const struct vm_special_mapping *sm,
>  		struct vm_area_struct *new_vma)
>  {
>  	current->mm->context.vdso = (void *)new_vma->vm_start;
>  
> +	vdso_futex_robust_unlock_update_ips(VDSO_ABI_AA64, current->mm);
> +
>  	return 0;
>  }
>  
> @@ -134,6 +155,8 @@ static int __setup_additional_pages(enum vdso_abi abi,
>  	if (IS_ERR(ret))
>  		goto up_fail;
>  
> +	vdso_futex_robust_unlock_update_ips(abi, mm);
> +
>  	return 0;
>  
>  up_fail:
> @@ -159,6 +182,8 @@ static int aarch32_sigpage_mremap(const struct vm_special_mapping *sm,
>  {
>  	current->mm->context.sigpage = (void *)new_vma->vm_start;
>  
> +	vdso_futex_robust_unlock_update_ips(VDSO_ABI_AA32, current->mm);

This is for the sigpage remap, not the vDSO, is it really necessary?
If yes it should be part of the later VDSO_ABI_AA32 patch IMO.


If there is a way for a 64-bit application to call 32-bit syscalls then 
the 64-bit vDSO also needs the 32-bit functions. See:
[0] https://lore.kernel.org/lkml/875x4zw4bp.ffs@tglx/

>  	return 0;
>  }
>  
> diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
> index 52314be29191..8633aafe6b81 100644
> --- a/arch/arm64/kernel/vdso/vdso.lds.S
> +++ b/arch/arm64/kernel/vdso/vdso.lds.S
> @@ -104,6 +104,7 @@ VERSION
>  		__kernel_clock_gettime;
>  		__kernel_clock_getres;
>  		__kernel_getrandom;
> +		__vdso_futex_robust_list64_try_unlock;

Guard behind CONFIG_FUTEX_ROBUST_UNLOCK ?

ld.lld fails when a function mentioned in the linker script is missing.

>  	local: *;
>  	};
>  }
> @@ -112,3 +113,7 @@ VERSION
>   * Make the sigreturn code visible to the kernel.
>   */
>  VDSO_sigtramp		= __kernel_rt_sigreturn;
> +
> +VDSO_futex_list64_try_unlock_cs_start = __futex_list64_try_unlock_cs_start;
> +VDSO_futex_list64_try_unlock_cs_success = __futex_list64_try_unlock_cs_success;
> +VDSO_futex_list64_try_unlock_cs_end = __futex_list64_try_unlock_cs_end;

(...)
