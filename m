Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B2F35B137;
	Mon, 27 Apr 2026 16:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777307241; cv=none; b=GtvszSFmuXpk+270xD8wjGUmkksGgfYTxd4oGpxSc4Xsq/mKiul7grSSf2R3JczJ1rYBx1AsCpHVW07RX6odtEDtJo9oH4Y31pY6HItNpqCExFx031U3dqIJfsBtgdmBvukLqTp24EdyDsuuF+9Wwrt2FAhPP6ePUPNS8ULFgN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777307241; c=relaxed/simple;
	bh=6KT2lBRYaSdwASapXaVtu5KBdK0QefH/+15iWad9gK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TeKPGon+Gd8TDsR5Nv0AMPXJ3Yph3pJ4d4gcYyTiixo8Ru68T0uHafVjmECeDtKZpF4QQX2bpkN5WvsBaW6OLXcbdS7qJk3ZqXky5sJWVtZlgrCPWQhz+4A6j4GEbLAH1gdRYXn1ZlMQT0S6p3tGSjFASRc9qB5eDKkpusIir1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=syAv4LxL; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="syAv4LxL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BPLg1Hn38x8a+m0kG/FEsTFwbBhtL+oRHiLJRGc//TU=; b=syAv4LxLVHacKb7lD0gWSxExjl
	ALtxi4r+F+lwos9dX87zDCmRI8yf5uNew32TzulCab9e3SiknlZyLkTPxwJOt3ooYyt5nNCvzcHBL
	74B9Wuq45vZpqBLllROZa3rb7YNwvpc5gNJvkZHgyqmqIolWtVH6rvQGMmtK/Yt1AQkh0DVg1jBv9
	9rCLpB8OnLdSdRVKagAZ4q8RrBxZcRDnVMUiArOoGqRQrxAYe1LFin8JRjZCf8R8Ptd+DE4cRa8eH
	O/7yQfz+ZKhu9ou3cQoawCioTZ9Lp/+H86NE3rdehuB6RIn8Qg3/jQPJEKkuBWXpHPULfWOFNoVva
	pi2tC98Q==;
Received: from [187.57.76.96] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1wHOnL-0030S7-FA; Mon, 27 Apr 2026 18:26:50 +0200
Message-ID: <f14b2297-9b6b-46a6-ac9c-57377aaf9031@igalia.com>
Date: Mon, 27 Apr 2026 13:26:41 -0300
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 2/2] arm64: vdso: Implement
 __vdso_futex_robust_try_unlock()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Carlos O'Donell <carlos@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Florian Weimer <fweimer@redhat.com>, Rich Felker <dalias@aerifal.cx>,
 Torvald Riegel <triegel@redhat.com>, Darren Hart <dvhart@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Arnd Bergmann <arnd@arndb.de>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Uros Bizjak <ubizjak@gmail.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 kernel-dev@igalia.com
References: <20260424-tonyk-robust_arm-v2-0-db4e46f752cf@igalia.com>
 <20260424-tonyk-robust_arm-v2-2-db4e46f752cf@igalia.com>
 <7ddc1c74-c504-44c6-8d51-d10d436c0db8@t-8ch.de>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <7ddc1c74-c504-44c6-8d51-d10d436c0db8@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Em 26/04/2026 15:30, Thomas Weißschuh escreveu:
> On 2026-04-24 15:56:01-0300, André Almeida wrote:
> (...)
> 
>> Signed-off-by: André Almeida <andrealmeid@igalia.com>
>> ---
>> RFC:
>>   - Should I duplicate the explanation found in the x86 commit or can I just
>>   point to it?
>>   - Only LL/SC for now but I can add LSE later if this looks good
>>   - It the objdump I see that op_pending is store at x2. But how stable is this,
>>   how can I write it in a way that's always x2?
>> ---
>>   arch/arm64/Kconfig                                 |  1 +
>>   arch/arm64/include/asm/futex_robust.h              | 35 +++++++++++++
>>   arch/arm64/kernel/vdso/Makefile                    |  9 +++-
>>   arch/arm64/kernel/vdso/vdso.lds.S                  |  4 ++
>>   .../kernel/vdso/vfutex_robust_list_try_unlock.c    | 59 ++++++++++++++++++++++
>>   5 files changed, 107 insertions(+), 1 deletion(-)
> 
> What about the actual 32-bit vDSO in arch/arm64/kernel/vdso32/ ?
> 

Right, I missed that. Then I should move 
__vdso_futex_robust_list32_try_unlock() to arch/arm64/kernel/vdso32/ right?

> (...)
> 
>> diff --git a/arch/arm64/kernel/vdso/vfutex_robust_list_try_unlock.c b/arch/arm64/kernel/vdso/vfutex_robust_list_try_unlock.c
>> new file mode 100644
>> index 000000000000..e8a8fb22a2fa
>> --- /dev/null
>> +++ b/arch/arm64/kernel/vdso/vfutex_robust_list_try_unlock.c
>> @@ -0,0 +1,59 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +#include <vdso/futex.h>
>> +#include <linux/stringify.h>
>> +
>> +#define LABEL(name, sz) __stringify(__futex_list##sz##_try_unlock_cs_##name)
> 
> We should have some defines for these symbols. While they are not
> userspace ABI, they will be used by the selftests.
> 

Do you mean to have this defined at include/uapi/linux/futex.h?

>> +#define GLOBLS(sz) ".globl " LABEL(start, sz) ", " LABEL(success, sz) ", " LABEL(end, sz) "\n"
>> +
>> +__u32 __vdso_futex_robust_list64_try_unlock(__u32 *lock, __u32 tid, __u64 *pop)
>> +{
>> +	__u32 val, result;
>> +
>> +	asm volatile (
>> +		GLOBLS(64)
>> +		"	prfm pstl1strm, %[lock]			\n"
>> +		LABEL(start, 64)":				\n"
>> +		"	ldxr %[val], %[lock]			\n"
>> +		"	cmp %[tid], %[val]			\n"
>> +		"	bne " LABEL(end, 64)"			\n"
>> +		"	stlxr %w[result], xzr, %[lock]		\n"
>> +		"	cbnz %w[result], " LABEL(start, 64)"	\n"
>> +		LABEL(success, 64)":				\n"
>> +		"	str xzr, %[pop]				\n"
>> +		LABEL(end, 64)":				\n"
>> +
>> +		: [val] "=&r" (val), [result] "=r" (result)
>> +		: [tid] "r" (tid), [lock] "Q" (*lock), [pop] "Q" (*pop)
>> +		: "memory"
>> +	);
> 
> My clang 22.1.3 chokes on the assembly in this patch.
> 

Do you mind sharing the output?

>> +
>> +	return val;
>> +}
>> +
>> +#ifdef CONFIG_COMPAT_VDSO
> 
> I am wondering about the CONFIG_COMPAT{,_VDSO} dependency here.
> As far as I know the list32 variant is meant to be used by code
> emulators which run 32-bit code on a 64-bit kernel, for example FEX.
> But these emulators don't actually seem to need CONFIG_COMPAT.
> So the dependency does not look correct.
> The space savings also should be irrelevant.

Right, good catch. In the new syscall I had to do something similar[1], 
to expose the 32-bit functions to 64-bit kernels as well, and not hide 
them behind CONFIG_COMPAT.

[1] 
https://lore.kernel.org/lkml/20251122-tonyk-robust_futex-v6-2-05fea005a0fd@igalia.com/

> 
> The x86 series from Thomas does the same, maybe he will read this
> comment, otherwise I'll bring it up on his series, too.
> 
>> +__u32 __vdso_futex_robust_list32_try_unlock(__u32 *lock, __u32 tid, __u32 *pop)
>> +{
>> +	__u32 val, result;
>> +
>> +	asm volatile (
>> +		GLOBLS(32)
>> +		"	prfm pstl1strm, %[lock]			\n"
>> +		LABEL(start, 32)":				\n"
>> +		"	ldxr %w[val], %[lock]			\n"
>> +		"	cmp %w[tid], %w[val]			\n"
>> +		"	bne " LABEL(end, 32)"			\n"
>> +		"	stlxr %w[result], wzr, %w[lock]		\n"
>> +		"	cbnz %w[result], " LABEL(start, 32)"	\n"
>> +		LABEL(success, 32)":				\n"
>> +		"	str wzr, %w[pop]			\n"
>> +		LABEL(end, 32)":				\n"
>> +
>> +		: [val] "=&r" (val), [result] "=r" (result)
>> +		: [tid] "r" (tid), [lock] "Q" (*lock), [pop] "Q" (*pop)
>> +		: "memory"
>> +	);
>> +
>> +	return val;
>> +}
>> +#endif

