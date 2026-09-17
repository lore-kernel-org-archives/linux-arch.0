Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295A159D61A;
	Thu, 17 Sep 2026 14:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789656074; cv=none; b=jnKyYzhC9LrcG5pTSElPKZ6iPxbQ4hyld87KvWHbHd6vhNbrl11XySBAqv1bSOAuGQMmZDAQieStWSt1zIRvG+SPu3kmA/mZJtau6jk/cQOVO9qtqQTnd/JRpirGZCzrOYMWVib+dTchFU7bq+vXVVrBvlc/4uYxelvKGXBUlco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789656074; c=relaxed/simple;
	bh=t+39SyfiaHgnqydfzkiFgoo21jF3tEkcnsN9WO2AfCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CQESn4oargqNo8vSRcy9lg80RIOmHYErQPV9wFRH7cf7AKn5JhYz6G617J63gIroVXDZtMne25sTtZeo+cSC+VmqbZO8TQD1EKGSUy2e65sIoepURgiDHkuM86q8MDDx2Nt50F9LeEFSlNAIzMWmRK9tX9sPIWwHsHAeDAwJIOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=s6+OPOS4; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="s6+OPOS4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=luaGer/wyE+IKlz1ehjzIlh5ZjZGTMka5bZxq7yuqOY=; b=s6+OPOS4CHmKTtSY/aVpc8sTRe
	0QcYGXMDKxqjX0o7fy8xdztussa/3sZf9AlKxW45l70OSeNbX/TDjKqcE/emBRVSeifvhe/zVslGK
	jxCtRvccth7EyFUVtfjCsDyLN2y3kGGuwWJJS5AO0khHAd/HmkF4gOj6xaVsyAY8IWsbM8W9v7nx6
	H9bXFEfTwYMyNcJqwxyGLNSMTlyYlU0b3bSL7lFQlshK2x2s9bx8YPMc9wep4j5DxvMvMi2MPTxS1
	wv7X356lYFgXGZ1j4SjyOmH8jbjtJDiDJ8+kzbJsjkXBrdp60bHukzkozskIjDag+cs7RKWiCGOiC
	eSc/wNPg==;
Received: from [177.172.123.214] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1x7DHw-003Tz7-3M; Thu, 17 Sep 2026 16:40:36 +0200
Message-ID: <c3d9e024-90a0-45c4-8116-4eb19d8f4cd3@igalia.com>
Date: Thu, 17 Sep 2026 11:40:33 -0300
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/4] arm64: vdso: Prepare for robust futex unlock
 support
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, Florian Weimer <fweimer@redhat.com>,
 Darren Hart <dvhart@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>,
 Uros Bizjak <ubizjak@gmail.com>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 kernel-dev@igalia.com
References: <20260821-tonyk-robust_arm-v8-0-077707b6f1c7@igalia.com>
 <20260821-tonyk-robust_arm-v8-1-077707b6f1c7@igalia.com>
 <aqqmmNTDnzT5d-ZT@J2N7QTR9R3>
 <4cc1a199-8917-4a93-91f8-138ca1511cff@igalia.com>
 <aqu6ZzMpunlKDIwm@J2N7QTR9R3>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <aqu6ZzMpunlKDIwm@J2N7QTR9R3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 17/09/2026 07:01, Mark Rutland escreveu:
> On Wed, Sep 16, 2026 at 10:05:38PM -0300, André Almeida wrote:
>> Em 16/09/2026 11:24, Mark Rutland escreveu:
>>> I reckon this might also be clearer as:
>>>
>>> | 	if (regs->regs[3])
>>> | 		return NULL;
>>> | 	
>>> | 	return (void __user *)regs->regs[2];
>>>
>>> Do we need a __force cast here, or is sparse happy without that?
>>
>> I've just re-compiled those patches with C=1, and didn't find any warning
>> for this.
> 
> Perfect, thanks for confirming!
> 
> [...]
> 
>>>> +	futex_set_vdso_cs_range(fd, is_32bit ? 1 : 0, start, end, is_32bit);
>>>
>>> On arm64 (and every architecture other than x86, AFAICT), the
>>> native/compat VDSOs are mutually exclusive, and a single mm can only
>>> have one of them.
>>>
>>> Given that, I think we can make this:
>>>
>>> 	futex_set_vdso_cs_range(fd, 0, start, end, is_32bit);
>>>
>>> That way we'll avoid confusing/bikesheeding over 'is_32bit ? 1 : 0',
>>> without having to add mnemnonics for the native/compat CS indices.
>>
>> Perfect, I will simplify that then.
>>
>>> That said, what's the plan for 32-bit robust lists on a 64-bit host?
>>> IIUC you wanted that for emulation, and AFAICT you have no way to call
>>> __vdso_futex_robust_list32_try_unlock() from a native task.
>>
>> Yes, the plan is to be able to use the 32-bit robust lists on a 64-bit
>> hosts, with a new interface (set/get_robust_list2[1]). That means that a
>> 64-bit kernel will be able to process an user robust list made of 32-bit
>> pointers. So the emulator will call set_robust_list2() one time for it's own
>> list, and another time for the emulated app list.
>>
>> However, what we have agreed for the moment is that, while there's no
>> support for that, we will not expose the 32-bit functions yet [2]:
> 
> Ah, thanks for the pointer! I had mistakenly assumed that some of
> that had already happened.
> 
> I guess the common logic for futex_set_vdso_cs_range() will need to
> change at that point I guess if/when that happens, you'd expect to add
> __vdso_futex_robust_list32_try_unlock() into the 64-bit VDSO, regardless
> of compat?
> 

Yes, given __vdso_futex_robust_list64_try_unlock() would write a 64-bit 
zero word in a 32-bit pointer, I probably need someway to expose 
__vdso_futex_robust_list32_try_unlock().

However, this will be need when a x86-32 bit app is running on top of 
the emulator, where the 32-bit glibc would eventually call the x86-32 
version of the VDSO. I will check what the emulator does with the other 
VDSOs, if they redirect to the native arm versions or what.

> Mark.
> 
>> "...that requires also the ability to register a 32-bit robust list for a
>> 64-bit process, which is not supported right now. So no, we are not exposing
>> something half functional..."
>>
>> So yes, in the near future I will need to expose
>> __vdso_futex_robust_list32_try_unlock() to 64-bit apps as well, to be able
>> to do this handling with 32-bit pointers, but we are not doing it right now.
>>
>> [1] https://lore.kernel.org/lkml/20251122-tonyk-robust_futex-v6-0-05fea005a0fd@igalia.com/
>>
>> [2] https://lore.kernel.org/lkml/878q9vwote.ffs@tglx/
>>

