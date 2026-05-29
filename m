Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D05379EE6;
	Fri, 29 May 2026 17:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780075121; cv=none; b=SIPIKA/27VaCiWmq5z7DPdrGazLKbrni1TWdY3joXwLOOJWvt+tjXvCxqciAJP1KkapQOdXl4eRaEfBJvCLYBi4AdoIAJ+99ZuV0lEhmpN1cNkiCdvTCqWhtB5a/LllU8EjpM7n3fQlti58vj1uB4bLPKZhYkuAryXL3zwqU+b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780075121; c=relaxed/simple;
	bh=Pf8j5LUxZPMlyxOo7oP/tpqDVWFR6J4EvzR+xRCYqoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/QJQcWIfykftjHQ61P7TvMf+NAo64tv1KqqwjoLnRgb4Wb/HuzAs3wa8677T0nH03jNIVwfcsAc7ORBs/1DI8d4Zot2FQ0SYC4u4qE/SsSV1hM4PFm6Eozcu5kvH0jwwXMOuwthPT0CcWxxEsaOvQ79rcHyok94p7qT8zcY0B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=gW8lfxt/; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="gW8lfxt/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1780075118;
	bh=Pf8j5LUxZPMlyxOo7oP/tpqDVWFR6J4EvzR+xRCYqoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gW8lfxt/giEOQXCMNUf+WOd+H9C1l8SsT+dZTwTtaewDlYGKtTpJGfp8XdG02bk7Z
	 TKYQUw6EQr4kBUm1fjaLxfGvHCnC0M2XeX4sWSLXlorXtceY8ltQFUulxu3+hcY9s9
	 acQge5u9uy98h9VOVvYr6mD4HGaTqszeGi7nbLaU=
Date: Fri, 29 May 2026 19:18:37 +0200
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
Subject: Re: [PATCH v3 2/5] arm64: vdso: Implement
 __vdso_futex_robust_try_unlock()
Message-ID: <7f1e1aae-41d5-4583-b47e-9dcc7ad82ea1@t-8ch.de>
References: <20260529-tonyk-robust_arm-v3-0-a6f02684d4fe@igalia.com>
 <20260529-tonyk-robust_arm-v3-2-a6f02684d4fe@igalia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260529-tonyk-robust_arm-v3-2-a6f02684d4fe@igalia.com>

On 2026-05-29 13:33:54-0300, André Almeida wrote:
> Based on the x86 implementation, implement the vDSO function for unlocking
> a robust futex correctly.
> 
> Commit xxxxxxxxxxxx ("x86/vdso: Implement __vdso_futex_robust_try_unlock()") has
> the full explanation about why this mechanism is needed.
> 
> The unlock assembly sequence for arm64 is:
> 
> 	__vdso_futex_robust_list64_try_unlock:
> 	retry:
> 		ldxr	w8, [x0] // Load the value from *futex
> 		cmp	w1, w8   // Compare with TID
> 		b.ne	__vdso_futex_list64_try_unlock_cs_end
> 		stlxr	w9, wzr, [x0] // Try to zero *futex
> 		cbnz	w9, retry
> 	__vdso_futex_list64_try_unlock_cs_start:
> 		str	xzr, [x2] // After zeroing *futex, zero *op_pending
> 	__vdso_futex_list64_try_unlock_cs_end>:
> 
> The decision regarding if the pointer should be cleared or not lies on checking
> the condition flag zero:
> 
> 	return (regs->user_regs.pstate & PSR_Z_BIT) ?
> 		(void __user *) regs->user_regs.regs[2] : NULL;
> 
> If it's not zero, that means that the comparassion worked and the kernel should
> clear op_pending (if userspace didn't managed to) stored at x2.
> 
> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> ---
> Notes:
>  - Only LL/SC for now but I can add LSE later if this looks good
> 
> v3:
>  - Managed to get pop to always be stored at x2
> ---
>  arch/arm64/Kconfig                    |  1 +
>  arch/arm64/include/asm/futex_robust.h | 20 ++++++++++++++++++++
>  arch/arm64/kernel/vdso/Makefile       |  9 ++++++++-
>  arch/arm64/kernel/vdso/vfutex.c       | 34 ++++++++++++++++++++++++++++++++++
>  include/vdso/futex.h                  |  1 +
>  5 files changed, 64 insertions(+), 1 deletion(-)

(...)

> diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
> index 7dec05dd33b7..3c7f220fe783 100644
> --- a/arch/arm64/kernel/vdso/Makefile
> +++ b/arch/arm64/kernel/vdso/Makefile
> @@ -9,7 +9,8 @@
>  # Include the generic Makefile to check the built vdso.
>  include $(srctree)/lib/vdso/Makefile.include
>  
> -obj-vdso := vgettimeofday.o note.o sigreturn.o vgetrandom.o vgetrandom-chacha.o
> +obj-vdso := vgettimeofday.o note.o sigreturn.o vgetrandom.o vgetrandom-chacha.o \
> +	    vfutex.o

Should depend on CONFIG_FUTEX_ROBUST_UNLOCK ?

>  
>  # Build rules
>  targets := $(obj-vdso) vdso.so vdso.so.dbg
> @@ -45,9 +46,11 @@ CC_FLAGS_ADD_VDSO := -O2 -mcmodel=tiny -fasynchronous-unwind-tables
>  
>  CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_REMOVE_VDSO)
>  CFLAGS_REMOVE_vgetrandom.o = $(CC_FLAGS_REMOVE_VDSO)
> +CFLAGS_REMOVE_vfutex.o = $(CC_FLAGS_REMOVE_VDSO)
>  
>  CFLAGS_vgettimeofday.o = $(CC_FLAGS_ADD_VDSO)
>  CFLAGS_vgetrandom.o = $(CC_FLAGS_ADD_VDSO)
> +CFLAGS_vfutex.o = $(CC_FLAGS_ADD_VDSO)
>  
>  ifneq ($(c-gettimeofday-y),)
>    CFLAGS_vgettimeofday.o += -include $(c-gettimeofday-y)
> @@ -57,6 +60,10 @@ ifneq ($(c-getrandom-y),)
>    CFLAGS_vgetrandom.o += -include $(c-getrandom-y)
>  endif
>  
> +ifneq ($(c-futex-y),)
> +  CFLAGS_vfutex.o += -include $(c-futex-y)
> +endif
> +
>  targets += vdso.lds
>  CPPFLAGS_vdso.lds += -P -C -U$(ARCH)

(...)

> diff --git a/include/vdso/futex.h b/include/vdso/futex.h
> index 3cd175eefe64..80934561a10d 100644
> --- a/include/vdso/futex.h
> +++ b/include/vdso/futex.h
> @@ -4,6 +4,7 @@
>  
>  #include <uapi/linux/types.h>
>  
> +

Spurious change.

>  /**
>   * __vdso_futex_robust_list64_try_unlock - Try to unlock an uncontended robust futex
>   *					   with a 64-bit pending op pointer
> 
> -- 
> 2.54.0
> 
