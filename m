Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F2D37F33F;
	Thu, 23 Jul 2026 15:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784822287; cv=none; b=SYw1RQzJFr4eU5yEIkET1z1wRYYjlY2EJOPyL1SksLihLEDX5aCarp2fWq1KbEikaSe98XgkwFy5HHJLDUMgxpkYh0ntjXDWS81WjIXfM3DKuHnSisXFA7OcgOpB4TZLzsqiELupCJPtSYprt6SrXbuPiLkVKPBZJVEmsu5JSrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784822287; c=relaxed/simple;
	bh=NK/VIeWHz2I8bR0cM+AL0kzHBGJocDRnuOpmnetXRik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dh6kJnQFTOjDdIkf4nyaKK1E3NX64Pe6oguq/cUQLIQariwiYv5S8p/ysIrrm91Vae3M6gOjewUmnJVSqIdAZoCRXTDid/N7oLq9gPbdeXU8sLXEuR4wi3gb9nk5iyeUiFYTS/rENTUrXEXpNTqI+yt8cM1MZ3F2VJPsjOsY2zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=gAyuiqoa; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="gAyuiqoa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=+k5jSvDUMU4cPoKCVbhaqWyx0o46NejDYXogafOH/14=; b=gAyuiqoaNTqTsUT9injp3BMG12
	nfA6QwCZL8GbIkkY1cyrdejhukJJS8PU9RzJhPnS22TcosMiR9DIIBxS8m7CPYO50EaW5wBaqpmUT
	hkqAM7oKggKSDB0V1l+O5SZTedqwsWHn8XjshgBGfMFiCyUkXZ37wHBeDWF2Hp+b8C7AWKNC8QDVI
	Iw1uXONA6sWCxIotmNASIrvvggneFglyqtIiITurqS2tvUD8T5yDSogk6OOWSIYsabBo08mn0cGUV
	Zegw0Glp7nm5yuLKnq2v2lzt9ViIQA4672vOibC9VGjdzDkFVXGUQJkV08ygDSSD9opOnF1EYvg/o
	FGSk8UrA==;
Received: from [179.118.191.219] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1wmvnS-003VA4-9g; Thu, 23 Jul 2026 17:57:18 +0200
Message-ID: <a701b60b-d343-4a7f-b298-e76c6c3a6cbc@igalia.com>
Date: Thu, 23 Jul 2026 12:57:10 -0300
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/4] arm64: vdso32: Implement
 __vdso_futex_robust_try_unlock()
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, Florian Weimer <fweimer@redhat.com>,
 Darren Hart <dvhart@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>,
 Uros Bizjak <ubizjak@gmail.com>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, kernel-dev@igalia.com
References: <20260720-tonyk-robust_arm-v6-0-7e68c122047e@igalia.com>
 <20260720-tonyk-robust_arm-v6-4-7e68c122047e@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20260720-tonyk-robust_arm-v6-4-7e68c122047e@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 20/07/2026 13:03, André Almeida escreveu:
> Based on aarch64 implementation, provide a 32 bit entry point for
> this vDSO.
> 
> In order to keep compatibility with arm64_futex_robust_unlock_get_pop(),
> make sure to store the pop address at r2 and the compare result value
> at r3.
> 
> Signed-off-by: André Almeida <andrealmeid@igalia.com>

[...]

> +__u32 __vdso_futex_robust_list32_try_unlock(__u32 *lock, __u32 tid, __u32 *pop)
> +{
> +	register __u32 *pop_reg asm("r2") = pop, result_reg asm("r3") = 0;
> +	__u32 val, zero = 0;
> +
> +	asm volatile (
> +		".globl						  "
> +		"__futex_list32_try_unlock_cs_start,		  "
> +		"__futex_list32_try_unlock_cs_success,		  "
> +		"__futex_list32_try_unlock_cs_end		\n"
> +
> +		"retry:						\n"
> +		"	ldrex %[val], %[lock]			\n"
> +		"	cmp %[tid], %[val]			\n"
> +		"	bne __futex_list32_try_unlock_cs_end	\n"
> +		"	strex %[result], %[zero], %[lock]	\n"

Actually, this should be `stlex` instead for the store release semantics.

> +		"__futex_list32_try_unlock_cs_start:		\n"
> +		"	cmp %[result], #0			\n"
> +		"	bne retry				\n"
> +		"__futex_list32_try_unlock_cs_success:		\n"
> +		"	str %[zero], %[pop_reg]			\n"
> +		"__futex_list32_try_unlock_cs_end:		\n"
> +
> +		: [val] "=&r" (val), [result] "=r" (result_reg)
> +		: [tid] "r" (tid), [lock] "Q" (*lock), [pop_reg] "Q" (*pop_reg), [zero] "r" (zero)
> +		: "cc", "memory"
> +	);
> +
> +	return val;
> +}
> 

