Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB964156FB;
	Wed, 16 Sep 2026 19:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789586902; cv=none; b=sHUnCsvUDNqpH8w/OTzfp0kqDaV5p4f7UiYMTBJI///PYOZS30e89YwsLcLZYzlOaVnSinsc1NDX98V06mD4/1c2INlgy5bTxxODSfH3U6U9mI4vQyHhjYaHyKxLmHinTd0Lj0Og+v1e3PsKGVK9/roIGFG2YjqxOET/Gk6Ch3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789586902; c=relaxed/simple;
	bh=aZ9HBAB5EPGjOS+Oyn0SySJBAMHqTTY661V3TKy8j/o=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=AeCxAlfG5bZXGk48FF5ghyvUfUEHQsmY5NkjxqEz0Y+TG0w8oP48IF0GNwgDCeNwZVMXmCM8iLWM/jUqQ0H6X/BbJ2lEjc481TUD+6k8zlNPiuMH/iHD+rDe9cp2Bj4kLat77ohx/CMxdB13ELKhN5/F5ZlIeplqWIzbu+nOWTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.helo=mail.mainlining.org; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.helo=mail.mainlining.org
Date: Wed, 16 Sep 2026 20:27:11 +0100
From: Bradley Morgan <brads@mainlining.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "Paul E. McKenney" <paulmck@kernel.org>
CC: frederic@kernel.org, neeraj.upadhyay@kernel.org, boqun@kernel.org,
 joelagnelf@nvidia.com, rcu@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, Vineet Gupta <vgupta@kernel.org>,
 linux-snps-arc@lists.infradead.org, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Guo Ren <guoren@kernel.org>,
 linux-csky@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] sh: Emulate two-byte cmpxchg
In-Reply-To: <1835e3f1b7e936479964f5e40583133484510d25.camel@physik.fu-berlin.de>
References: <20260911192540.20983-1-brads@mainlining.org> <20260911192540.20983-6-brads@mainlining.org> <1835e3f1b7e936479964f5e40583133484510d25.camel@physik.fu-berlin.de>
Message-ID: <0BA8FB21-8118-4D8B-B284-A79149AC3B4D@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 16 September 2026 20:16:16 BST, John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>Hi Bradley,
>
>On Fri, 2026-09-11 at 19:25 +0000, Bradley Morgan wrote:
>> SH has no byte or halfword atomic memory operations, so the
>> __cmpxchg() switch routes case 1 through cmpxchg_emu_u8() and
>> lets case 2 fall through to __cmpxchg_called_with_bad_pointer(),
>> which is declared but never defined, so a two-byte cmpxchg()
>> fails at link time. Route case 2 through the new cmpxchg_emu_u16().
>> 
>> Signed-off-by: Bradley Morgan <brads@mainlining.org>
>> ---
>>  arch/sh/include/asm/cmpxchg.h | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/arch/sh/include/asm/cmpxchg.h
>b/arch/sh/include/asm/cmpxchg.h
>> index 1e5dc5ccf7bf..477d3025a441 100644
>> --- a/arch/sh/include/asm/cmpxchg.h
>> +++ b/arch/sh/include/asm/cmpxchg.h
>> @@ -59,6 +59,8 @@ static inline unsigned long __cmpxchg(volatile void *
>ptr, unsigned long old,
>>  	switch (size) {
>>  	case 1:
>>  		return cmpxchg_emu_u8(ptr, old, new);
>> +	case 2:
>> +		return cmpxchg_emu_u16(ptr, old, new);
>>  	case 4:
>>  		return __cmpxchg_u32(ptr, old, new);
>>  	}
>
>Odd, I thought this series was merged long time ago. Was there anything
>holding it back?
>

ARM had a board where 16 bit wouldn't have been supported, so the V2 is
ready now anyway, let me add ur a-b and submit 

>Either way:
>
>Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>
>Adrian
>
>

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
