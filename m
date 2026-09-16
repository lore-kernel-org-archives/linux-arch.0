Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18A54DE705;
	Wed, 16 Sep 2026 21:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789592644; cv=none; b=BC4iDgrM3Hppe5XYi1Gi3NKUljpDpVZqGb/oQkrF7DKDeM7bBF0yCzhI/WX05N2shQiPjd/EBXX6kchTGxnxf+1BryhklvzFULMduiZwzQQTvCkid+3EeMrugWOg1WOiVsouPEL/bonqDfk7d+CySKXh2niSNRPb6a4v9g5vivs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789592644; c=relaxed/simple;
	bh=GaUFeToKrKCkhEuh0KyPpvoqc2qykEt6cZ5W4HAmRws=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=CjvXZrVWNCVKK0/BIggzW9Q9TnaxbZNhSKzyAkAO7P9TSloC+oeWfjXgRpXIiEYmrFlF2R+u9iqJNgOYUdjZ+lQD1jEUxcFpKhhLTB1+N5S168b6J1vWgA2BTCpXiKi7ZxW6vuhSHTUa5AtnoxNCMLzFA56esdwaPnoLzoC+cn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.helo=mail.mainlining.org; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.helo=mail.mainlining.org
Date: Wed, 16 Sep 2026 22:03:45 +0100
From: Bradley Morgan <brads@mainlining.org>
To: paulmck@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
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
In-Reply-To: <ed3ef87e-b9c8-4aa6-90ca-c1da3e97a8e3@paulmck-laptop>
References: <20260911192540.20983-1-brads@mainlining.org> <20260911192540.20983-6-brads@mainlining.org> <1835e3f1b7e936479964f5e40583133484510d25.camel@physik.fu-berlin.de> <ed3ef87e-b9c8-4aa6-90ca-c1da3e97a8e3@paulmck-laptop>
Message-ID: <2CE26D63-5CA4-4E54-AC70-B34783BD55C7@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 16 September 2026 22:01:07 BST, "Paul E. McKenney" <paulmck@kernel.org>
wrote:
>On Wed, Sep 16, 2026 at 09:16:16PM +0200, John Paul Adrian Glaubitz wrote:
>> Hi Bradley,
>> 
>> On Fri, 2026-09-11 at 19:25 +0000, Bradley Morgan wrote:
>> > SH has no byte or halfword atomic memory operations, so the
>> > __cmpxchg() switch routes case 1 through cmpxchg_emu_u8() and
>> > lets case 2 fall through to __cmpxchg_called_with_bad_pointer(),
>> > which is declared but never defined, so a two-byte cmpxchg()
>> > fails at link time. Route case 2 through the new cmpxchg_emu_u16().
>> > 
>> > Signed-off-by: Bradley Morgan <brads@mainlining.org>
>> > ---
>> >  arch/sh/include/asm/cmpxchg.h | 2 ++
>> >  1 file changed, 2 insertions(+)
>> > 
>> > diff --git a/arch/sh/include/asm/cmpxchg.h
>b/arch/sh/include/asm/cmpxchg.h
>> > index 1e5dc5ccf7bf..477d3025a441 100644
>> > --- a/arch/sh/include/asm/cmpxchg.h
>> > +++ b/arch/sh/include/asm/cmpxchg.h
>> > @@ -59,6 +59,8 @@ static inline unsigned long __cmpxchg(volatile void
>* ptr, unsigned long old,
>> >  	switch (size) {
>> >  	case 1:
>> >  		return cmpxchg_emu_u8(ptr, old, new);
>> > +	case 2:
>> > +		return cmpxchg_emu_u16(ptr, old, new);
>> >  	case 4:
>> >  		return __cmpxchg_u32(ptr, old, new);
>> >  	}
>> 
>> Odd, I thought this series was merged long time ago. Was there anything
>holding it back?
>
>You might be thinking of the cmpxchg_emu_u8() series from a few years
>back.
>This is cmpxchg_emu_u16().
>
>							Thanx, Paul
>
>> Either way:
>> 
>> Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>> 
>> Adrian
>> 
>> -- 
>>  .''`.  John Paul Adrian Glaubitz
>> : :' :  Debian Developer
>> `. `'   Physicist
>>   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
I think he was referring to when you tried u16 that time.
--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
