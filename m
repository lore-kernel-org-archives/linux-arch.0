Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE6B1552FD;
	Sun, 26 Apr 2026 18:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777228240; cv=none; b=UbrV1z2mUiFTro2/mmColnRWwD9ZggJTn9R8DEpwfQ4s92OUFCDfd1fWTYdlrW5OnAttO8Xj9qHO1R39bKvUz5eONhNdul/piFlbyk4zVVZj3pExRzcRZmtcPIMCuZ2rgYg/eVRvVJzUMltE/PCNDT5FxI+8auMpg4FR675qtys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777228240; c=relaxed/simple;
	bh=RX0vprigtwFDfvPHPQDQjGHFFSECwpJrLBtKIV9cU9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EcT4f7zVvAu8c45IN26uRsmU+Ec3Qsznyp3mffufopz71zrxqLVlaia0+5OVSLncdhvT2nO5eZV44PmwJ5GRGBvRR3nyuFj7uAaRisbO9sfshOXcCnyjsSa+FAAGOUKFrgtIgXcv3optiq9cmBC9u37gv6Jk+XLuzt4ULygd86w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=rgZmiyWF; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="rgZmiyWF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1777228236;
	bh=RX0vprigtwFDfvPHPQDQjGHFFSECwpJrLBtKIV9cU9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rgZmiyWFqk2UTABJRG965ZG1RFUQYVGrGeAOCXp/tvCy8mvsOalPMS51t0Zx3luh8
	 AA+qi7rm4LSKejZiczUMyYWV0YeJKZhy5Vu6oHG+bP0Uiz0AyzruhGfDsMnxiE8gDm
	 fxhhGweLrnR+r7svkMupRffCtPEUghvWJJDPN5wM=
Date: Sun, 26 Apr 2026 20:30:35 +0200
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
Subject: Re: [PATCH RFC v2 2/2] arm64: vdso: Implement
 __vdso_futex_robust_try_unlock()
Message-ID: <7ddc1c74-c504-44c6-8d51-d10d436c0db8@t-8ch.de>
References: <20260424-tonyk-robust_arm-v2-0-db4e46f752cf@igalia.com>
 <20260424-tonyk-robust_arm-v2-2-db4e46f752cf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260424-tonyk-robust_arm-v2-2-db4e46f752cf@igalia.com>

On 2026-04-24 15:56:01-0300, André Almeida wrote:
(...)

> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> ---
> RFC:
>  - Should I duplicate the explanation found in the x86 commit or can I just
>  point to it?
>  - Only LL/SC for now but I can add LSE later if this looks good
>  - It the objdump I see that op_pending is store at x2. But how stable is this,
>  how can I write it in a way that's always x2?
> ---
>  arch/arm64/Kconfig                                 |  1 +
>  arch/arm64/include/asm/futex_robust.h              | 35 +++++++++++++
>  arch/arm64/kernel/vdso/Makefile                    |  9 +++-
>  arch/arm64/kernel/vdso/vdso.lds.S                  |  4 ++
>  .../kernel/vdso/vfutex_robust_list_try_unlock.c    | 59 ++++++++++++++++++++++
>  5 files changed, 107 insertions(+), 1 deletion(-)

What about the actual 32-bit vDSO in arch/arm64/kernel/vdso32/ ?

(...)

> diff --git a/arch/arm64/kernel/vdso/vfutex_robust_list_try_unlock.c b/arch/arm64/kernel/vdso/vfutex_robust_list_try_unlock.c
> new file mode 100644
> index 000000000000..e8a8fb22a2fa
> --- /dev/null
> +++ b/arch/arm64/kernel/vdso/vfutex_robust_list_try_unlock.c
> @@ -0,0 +1,59 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#include <vdso/futex.h>
> +#include <linux/stringify.h>
> +
> +#define LABEL(name, sz) __stringify(__futex_list##sz##_try_unlock_cs_##name)

We should have some defines for these symbols. While they are not
userspace ABI, they will be used by the selftests.

> +#define GLOBLS(sz) ".globl " LABEL(start, sz) ", " LABEL(success, sz) ", " LABEL(end, sz) "\n"
> +
> +__u32 __vdso_futex_robust_list64_try_unlock(__u32 *lock, __u32 tid, __u64 *pop)
> +{
> +	__u32 val, result;
> +
> +	asm volatile (
> +		GLOBLS(64)
> +		"	prfm pstl1strm, %[lock]			\n"
> +		LABEL(start, 64)":				\n"
> +		"	ldxr %[val], %[lock]			\n"
> +		"	cmp %[tid], %[val]			\n"
> +		"	bne " LABEL(end, 64)"			\n"
> +		"	stlxr %w[result], xzr, %[lock]		\n"
> +		"	cbnz %w[result], " LABEL(start, 64)"	\n"
> +		LABEL(success, 64)":				\n"
> +		"	str xzr, %[pop]				\n"
> +		LABEL(end, 64)":				\n"
> +
> +		: [val] "=&r" (val), [result] "=r" (result)
> +		: [tid] "r" (tid), [lock] "Q" (*lock), [pop] "Q" (*pop)
> +		: "memory"
> +	);

My clang 22.1.3 chokes on the assembly in this patch.

> +
> +	return val;
> +}
> +
> +#ifdef CONFIG_COMPAT_VDSO

I am wondering about the CONFIG_COMPAT{,_VDSO} dependency here.
As far as I know the list32 variant is meant to be used by code
emulators which run 32-bit code on a 64-bit kernel, for example FEX.
But these emulators don't actually seem to need CONFIG_COMPAT.
So the dependency does not look correct.
The space savings also should be irrelevant.

The x86 series from Thomas does the same, maybe he will read this
comment, otherwise I'll bring it up on his series, too.

> +__u32 __vdso_futex_robust_list32_try_unlock(__u32 *lock, __u32 tid, __u32 *pop)
> +{
> +	__u32 val, result;
> +
> +	asm volatile (
> +		GLOBLS(32)
> +		"	prfm pstl1strm, %[lock]			\n"
> +		LABEL(start, 32)":				\n"
> +		"	ldxr %w[val], %[lock]			\n"
> +		"	cmp %w[tid], %w[val]			\n"
> +		"	bne " LABEL(end, 32)"			\n"
> +		"	stlxr %w[result], wzr, %w[lock]		\n"
> +		"	cbnz %w[result], " LABEL(start, 32)"	\n"
> +		LABEL(success, 32)":				\n"
> +		"	str wzr, %w[pop]			\n"
> +		LABEL(end, 32)":				\n"
> +
> +		: [val] "=&r" (val), [result] "=r" (result)
> +		: [tid] "r" (tid), [lock] "Q" (*lock), [pop] "Q" (*pop)
> +		: "memory"
> +	);
> +
> +	return val;
> +}
> +#endif
