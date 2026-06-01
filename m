Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D57D2F4A0C;
	Mon,  1 Jun 2026 16:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780330978; cv=none; b=BKzAGMimwMNXMD1yPl4YKOqQ5zezNlWjRzDCd0VcGxCqxO4enmvd40Eg41AgLbeM9IoXnj7Zb9uUqT0DgD/eSCKjge/WvML0/ZRlgf7hGzW8qpaS8e05tcn8fa1HuuVBvVZG/zBVmZH3mVcg9zu9sscGjLfRLYEfVSuMVT4994c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780330978; c=relaxed/simple;
	bh=VOHOiM2ncWDTs6pavjkvSt+M4Adnz+MXROO/ORF6SiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qYMXeQAtSh5l1Ek0UIDhfjtCApfF89gXfTzBs4jynfut32u/ia1bvPbEkIsuEprLqCvFnaDmT3u1ydhnR8f2g2H/ydaDPvIBkkyebGw4IFWLv561VGtsCJ20rR1i2B1ZnbvG3vIrn/QqHDV44G4STCmHx/jSGvdIENgj5AVDs/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=VtkZTt3v; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="VtkZTt3v"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XGTfXQpJJgOvUWnNJBWL9rDECpWQG2T8jJ/gmcDpZ9g=; b=VtkZTt3vePlJjjQtqvEdRnQTYl
	8dNcmgt3dQ3hPxoENlfLakdKRdiRvICFEpPetNFVi2/G9fa9kxeeUDgAqN6W9J6q//e/W8m3X7KcM
	kgj4b1QosMxaiO+JTRwRI4J26UVdLEpNB0cHvOvZTdfjA3jIrqAeXKGbLJdGMUWxzpRPjUXdsKRlF
	TgSh23LDOOB2lxgg+nM/H1fJzCzYJGTDUrJ/Lnw5bfOX34mFZEmI6gNvsI2fTblm7Zt/d4m7Xk2t1
	OCCFZKHEvOACf2YFxXPVfGryCw5dvKGhGnq/zDXZoKzREn/415MdZ9Soj+tnu5FJBKUOjP1S1sSWl
	csI7rklw==;
Received: from [177.172.121.54] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1wU5PP-00B6P0-Dk; Mon, 01 Jun 2026 18:22:35 +0200
Message-ID: <798c75ba-615d-48d1-bc04-53bc40bc6503@igalia.com>
Date: Mon, 1 Jun 2026 13:22:28 -0300
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] arm64: vdso: Implement
 __vdso_futex_robust_try_unlock()
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-arm-kernel@lists.infradead.org, Rich Felker <dalias@aerifal.cx>,
 Florian Weimer <fweimer@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Carlos O'Donell <carlos@redhat.com>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Uros Bizjak <ubizjak@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, Darren Hart <dvhart@infradead.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Torvald Riegel <triegel@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 kernel-dev@igalia.com, Mark Rutland <mark.rutland@arm.com>
References: <20260529-tonyk-robust_arm-v3-0-a6f02684d4fe@igalia.com>
 <20260529-tonyk-robust_arm-v3-2-a6f02684d4fe@igalia.com>
 <844b56fe-b5d4-42b2-ae8e-ce07980d0f50@efficios.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <844b56fe-b5d4-42b2-ae8e-ce07980d0f50@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 29/05/2026 14:47, Mathieu Desnoyers escreveu:
> On 2026-05-29 12:33, André Almeida wrote:
>> Based on the x86 implementation, implement the vDSO function for 
>> unlocking
>> a robust futex correctly.
>>
>> Commit xxxxxxxxxxxx ("x86/vdso: Implement 
>> __vdso_futex_robust_try_unlock()") has
>> the full explanation about why this mechanism is needed.
>>
>> The unlock assembly sequence for arm64 is:
>>
>>     __vdso_futex_robust_list64_try_unlock:
>>     retry:
>>         ldxr    w8, [x0] // Load the value from *futex
>>         cmp    w1, w8   // Compare with TID
>>         b.ne    __vdso_futex_list64_try_unlock_cs_end
>>         stlxr    w9, wzr, [x0] // Try to zero *futex
> 
> So it looks like stlxr can be successful, and the process is killed
> right here. This is not within the start/end critical section, so the
> fixup is missed ? Or am I missing something ?
> 

As me and Mathieu discussed on IRC, this should be the right thing to do 
here:

  - Move the critical section label one instruction above to include 
`cbnz` on it
  - Use the result register as the check for the store success, not the 
zero flag register.

So it will look like this:

	__vdso_futex_robust_list64_try_unlock:
	retry:
		ldxr	w8, [x0] // Load the value from *futex
		cmp	w1, w8   // Compare with TID
		b.ne	__vdso_futex_list64_try_unlock_cs_end
		stlxr	w9, wzr, [x0] // Try to zero *futex
	__vdso_futex_list64_try_unlock_cs_start:
		cbnz	w9, retry
		str	xzr, [x2] // After zeroing *futex, zero *op_pending
	__vdso_futex_list64_try_unlock_cs_end>:

The decision regarding if the pointer should be cleared or not lies on 
checking the result register:

	return (regs->user_regs[9]) ? NULL :
		(void __user *) regs->user_regs.regs[2];

Thanks for the review!
