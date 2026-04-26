Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133123793A5;
	Sun, 26 Apr 2026 19:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777230260; cv=none; b=XzKpoCpcVzAwYm7uaXA7qldgPwG5ehdLbzh1N4kepw14LJ0G2ZiYgq8IsLPLb+agKRy2vV1B1/fmlPMV5L11l8o4GquanJclvVBNwLj7TUZFs1uSMaRKiArPc806uGlUe4AOutyW/JL5Un3RLTJNP3i6/hdj4SpIWeye1xpGK9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777230260; c=relaxed/simple;
	bh=cL909OqLMd5VzANrjK7Nm/XEbexMuPAlas4Ce1GEC8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPnd5bCLWqdPt9qoRzU0r3L7eCVZSGBsu1mM7JSMrCFz2brYNsU1U+5qqGhAHui2AGiLQHZriC9IWZTw+b5xwoRnIvv/YQCcadrL1rm4GT0gpFra24KqeYFZY6+72Z25KJagK2pUbvbVn/J7tVC93COJpYIHaG7nDDJZkRL3ZcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=eHNUcbuC; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="eHNUcbuC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1777230255;
	bh=cL909OqLMd5VzANrjK7Nm/XEbexMuPAlas4Ce1GEC8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eHNUcbuCZilNwpHrn0AE0Yn4krgyTNzjDGoxNuscpKIOVVWM0QoT0gEDctOpBwiAL
	 TQLYYNLH702PIhm8Gg34eRi+IibwULREquFg0ov4wUBlBQjhV/nJ0u0s8tk0xvqXnG
	 BtiWRxFFBVLirNHcKKcDMrlU74nOSVdnXrShtZ40=
Date: Sun, 26 Apr 2026 21:04:14 +0200
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
Message-ID: <c9e3f275-da35-4cdf-876f-b4ec4278a75d@t-8ch.de>
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

One more thing, sorry for the spam.

On 2026-04-24 15:56:00-0300, André Almeida wrote:
(...)

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
> +	}
> +
> +#ifdef CONFIG_COMPAT_VDSO
> +	if (abi == VDSO_ABI_AA32) {
> +		success = (uintptr_t) VDSO_SYMBOL(vdso, futex_list32_try_unlock_cs_success);
> +		end = (uintptr_t) VDSO_SYMBOL(vdso, futex_list32_try_unlock_cs_end);

The futex_list32_ symbols here are in the 64-bit vDSO. They are not
applicable for VDSO_ABI_AA32 processes.

> +
> +		futex_set_vdso_cs_range(fd, 1, vdso, success, end, true);
> +	}
> +#endif
> +}

(...)
