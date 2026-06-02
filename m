Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36A43C3C03;
	Tue,  2 Jun 2026 08:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780389039; cv=none; b=kWzZOWDk1l6Dp3NtkRkmIaOsPO96kA1tEOcFw0zNlAPfdT0Et+OluEcFWZ/kBp0WyvR4Fu0dSDuJDWsmecnQ7AAdS47aAduE59sxKWAuBOfBOdeIzSoIcdZmGhJgBzVA2VXmL/3T31mP2W4LhW40wH3y25CJi6aSf8fiJhlkLYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780389039; c=relaxed/simple;
	bh=PT+6lJbxojln0Y3MXIQ5J0jCKL58p13yFJTiQO26mEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6PctBh/0wENHr21tNky75oCJsj3ydAqeJi5p00hEq05Pa8bi25Q3TgK5MogJ/xDoulpbWIdcgTWJCnlWDgF0exe4Fb4+TCyD7sh+fgjVVNHZX+sRihiQSrOOcaJ0i+30CdBbVLGT8FIks1JPPZdzwc/fUIY515xUZA4SfOv6Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=YZG/8NKh; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="YZG/8NKh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1780389029;
	bh=PT+6lJbxojln0Y3MXIQ5J0jCKL58p13yFJTiQO26mEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YZG/8NKhTOheOicD/ZKCr+Y6m9yQdyWFpnBSofLKDQJDgY47n46wSnhwNTk0stkRG
	 9Rg/L96JOFYVHz6KRCDFRSN08vfI2tJfuAo2apcknRdfFJwytTK38NCkqrTsmzdau7
	 ytyNz4jZhNKWgchT/RnsxKv2QtamLLRIcBYiqBmA=
Date: Tue, 2 Jun 2026 10:30:28 +0200
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
Subject: Re: [PATCH v3 5/5] arm64: vdso32: Implement
 __vdso_futex_robust_try_unlock()
Message-ID: <67474c48-a49f-417c-b440-97db0baee602@t-8ch.de>
References: <20260529-tonyk-robust_arm-v3-0-a6f02684d4fe@igalia.com>
 <20260529-tonyk-robust_arm-v3-5-a6f02684d4fe@igalia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260529-tonyk-robust_arm-v3-5-a6f02684d4fe@igalia.com>

On 2026-05-29 13:33:57-0300, André Almeida wrote:
> Based on aarch64 implementation, provide a 32 bit entry point for this vDSO.
> 
> In order to keep compatibility with arm64_futex_robust_unlock_get_pop(),
> make sure to store the pop address at r2.
> 
> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> ---
>  arch/arm64/kernel/vdso.c            |  9 +++++++++
>  arch/arm64/kernel/vdso32/Makefile   |  2 +-
>  arch/arm64/kernel/vdso32/vdso.lds.S |  5 +++++
>  arch/arm64/kernel/vdso32/vfutex.c   | 33 +++++++++++++++++++++++++++++++++
>  4 files changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
> index 76f22ea8e181..3ce9d9d79431 100644
> --- a/arch/arm64/kernel/vdso.c
> +++ b/arch/arm64/kernel/vdso.c
> @@ -71,6 +71,15 @@ static void vdso_futex_robust_unlock_update_ips(enum vdso_abi abi, struct mm_str
>  
>  		futex_set_vdso_cs_range(fd, 0, success, end, false);
>  	}
> +
> +#ifdef CONFIG_COMPAT_VDSO
> +	if (abi == VDSO_ABI_AA32) {
> +		success = (uintptr_t) VDSO_SYMBOL(vdso, futex_list32_try_unlock_cs_success);
> +		end = (uintptr_t) VDSO_SYMBOL(vdso, futex_list32_try_unlock_cs_end);
> +
> +		futex_set_vdso_cs_range(fd, 1, success, end, true);

Should also be idx = 0, I think.

> +	}
> +#endif
>  }
>  #else
>  static inline void vdso_futex_robust_unlock_update_ips(enum vdso_abi abi, struct mm_struct *mm) { }
> diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
> index 2775843e53cd..cc4248539bec 100644
> --- a/arch/arm64/kernel/vdso32/Makefile
> +++ b/arch/arm64/kernel/vdso32/Makefile
> @@ -97,7 +97,7 @@ VDSO_LDFLAGS += --orphan-handling=$(CONFIG_LD_ORPHAN_WARN_LEVEL)
>  munge := ../../../arm/vdso/vdsomunge
>  hostprogs := $(munge)
>  
> -c-obj-vdso := note.o
> +c-obj-vdso := note.o vfutex.o

#ifdef CONFIG_FUTEX_ROBUST_UNLOCK

>  c-obj-vdso-gettimeofday := vgettimeofday.o
>  
>  ifneq ($(c-gettimeofday-y),)
> diff --git a/arch/arm64/kernel/vdso32/vdso.lds.S b/arch/arm64/kernel/vdso32/vdso.lds.S
> index c374fb0146f3..31e0a3770c32 100644
> --- a/arch/arm64/kernel/vdso32/vdso.lds.S
> +++ b/arch/arm64/kernel/vdso32/vdso.lds.S
> @@ -87,6 +87,11 @@ VERSION
>  		__vdso_clock_getres;
>  		__vdso_clock_gettime64;
>  		__vdso_clock_getres_time64;
> +		__vdso_futex_robust_list32_try_unlock;

#ifdef CONFIG_FUTEX_ROBUST_UNLOCK

>  	local: *;
>  	};
>  }
> +
> +VDSO_futex_list32_try_unlock_cs_success = __futex_list32_try_unlock_cs_success;
> +VDSO_futex_list32_try_unlock_cs_start = __futex_list32_try_unlock_cs_start;
> +VDSO_futex_list32_try_unlock_cs_end = __futex_list32_try_unlock_cs_end;

When support for 32-bit robust lists will be added to the 64-bit vDSO
then both vDSOs will have these symbols and they will conflict.
Maybe add VDSO32_SYMBOL() which uses a different namespace than the
regular VDSO_SYMBOL(). And teach gen_vdso_offsets.sh to use that
namespace.

(...)


Thomas
