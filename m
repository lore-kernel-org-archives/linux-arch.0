Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E684BEE2A;
	Sat, 12 Sep 2026 10:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789209102; cv=none; b=PJHt56CZaqiogyRNuY1SH/emhgrXN0aVeba5rvJ+cLCFSMbW/ZWV9THUVYl5zVTn0jhQARMIDz/ZoKiWNtRGRQ8eV6sWCmzrOFVnwR4aIAA9Agrq9saQjOeIoTcbJB0aG0fBXDSuuLYSh11ZwJFRMGLWF8aHm3GZMu7Ozy+Gdn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789209102; c=relaxed/simple;
	bh=e5kZ0aoENwpriGEe0youjd9NbKIMnneVpfZH4WKrAZY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=iOnmIecFYTGen9JOtpGZBr8kPKDUVub16E5PjX8hPAZPhHBFDjoPf58F/J4Day5GwUk3OyNRaapfO0zA1x96kqVJXodnde4t3bEJ4vhXo64yjGsmK+ODYmkT+2mcmDIQxgfbBxNx/9X/vZaUO1BRnu8oGH5j/P5jCODsSRGvkIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.helo=mail.mainlining.org; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.helo=mail.mainlining.org
Date: Sat, 12 Sep 2026 11:29:03 +0100
From: Bradley Morgan <brads@mainlining.org>
To: David Laight <david.laight.linux@gmail.com>,
 "Paul E. McKenney" <paulmck@kernel.org>
CC: frederic@kernel.org, neeraj.upadhyay@kernel.org, boqun@kernel.org,
 joelagnelf@nvidia.com, rcu@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, Vineet Gupta <vgupta@kernel.org>,
 linux-snps-arc@lists.infradead.org, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Guo Ren <guoren@kernel.org>,
 linux-csky@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-sh@vger.kernel.org, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] lib: Add two-byte cmpxchg emulation function
In-Reply-To: <20260912103047.1b95bb03@pumpkin>
References: <20260911192540.20983-1-brads@mainlining.org> <20260911192540.20983-2-brads@mainlining.org> <20260911231017.550f8cd1@pumpkin> <d0ef7beb-6952-49cc-9b33-e7542e831ba6@paulmck-laptop> <20260912103047.1b95bb03@pumpkin>
Message-ID: <970C9FF6-1D56-48CA-8C2E-1DD332391229@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 12 September 2026 10:30:47 BST, David Laight
<david.laight.linux@gmail.com> wrote:
>On Fri, 11 Sep 2026 16:09:16 -0700
>"Paul E. McKenney" <paulmck@kernel.org> wrote:
>
>> On Fri, Sep 11, 2026 at 11:10:17PM +0100, David Laight wrote:
>> > On Fri, 11 Sep 2026 19:25:34 +0000
>> > Bradley Morgan <brads@mainlining.org> wrote:
>> >   
>> > > cmpxchg_emu_u8() emulates one-byte cmpxchg() in terms of four-byte
>> > > cmpxchg() for the architectures lacking native one-byte atomics.
>> > > The same architectures also lack native two-byte cmpxchg(), where
>> > > such an operation is not supported and either fails to compile via
>> > > BUILD_BUG() or fails to link, because the bad pointer sentinels
>> > > these architectures declare are never defined.
>> > > 
>> > > Add cmpxchg_emu_u16(), the two-byte sibling. It reads the enclosing
>> > > word with READ_ONCE(), splices the two target bytes through a union
>> > > and loops on cmpxchg() of the full word until the compare succeeds.
>> > > Like cmpxchg_emu_u8() it is fully ordered.
>> > > 
>> > > The Kconfig symbol gating this file is renamed from
>> > > ARCH_NEED_CMPXCHG_1_EMU to ARCH_NEED_CMPXCHG_1_2_EMU, as it now
>> > > selects both the one-byte and the two-byte emulation.
>> > > 
>> > > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
>> > > Signed-off-by: Bradley Morgan <brads@mainlining.org>
>> > > ---
>> > >  arch/Kconfig                |  2 +-
>> > >  arch/arc/Kconfig            |  2 +-
>> > >  arch/arm/Kconfig            |  2 +-
>> > >  arch/csky/Kconfig           |  2 +-
>> > >  arch/sh/Kconfig             |  2 +-
>> > >  arch/xtensa/Kconfig         |  2 +-
>> > >  include/linux/cmpxchg-emu.h |  1 +
>> > >  lib/Makefile                |  2 +-
>> > >  lib/cmpxchg-emu.c           | 35
>++++++++++++++++++++++++++++++++---
>> > >  9 files changed, 40 insertions(+), 10 deletions(-)
>> > >   
>> > ...  
>> > > diff --git a/include/linux/cmpxchg-emu.h
>b/include/linux/cmpxchg-emu.h
>> > > index 998deec67740..fee8171fa05e 100644
>> > > --- a/include/linux/cmpxchg-emu.h
>> > > +++ b/include/linux/cmpxchg-emu.h
>> > > @@ -11,5 +11,6 @@
>> > >  #define __LINUX_CMPXCHG_EMU_H
>> > >  
>> > >  uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t
>new);
>> > > +uintptr_t cmpxchg_emu_u16(volatile u16 *p, uintptr_t old, uintptr_t
>new);  
>> > 
>> > Why uintptr_t? Shouldn't it just be u16?
>> > (Which probably means the code would better if it was just 'unsigned
>int')  
>> 
>> I suspect that Bradley is just following my cmpxchg_emu_u8() example,
>> which also returns uintptr_t.
>> 
>> I remember that *something* broke when I made this be u8, but I cannot
>> recall what the problem was.
>> 
>> Bradley, could you please try making it be u16 as David suggests just to
>> see what happens?  Who knows?  Maybe it was a compiler issue that has
>> since been fixed.  Or maybe the macros and asms using cmpxchg_emu_u8()
>> need that uintptr_t for some reason.
>
>I think the uintptr (unsigned long) cast is needed to stop a compile
>error when exchanging pointers.
>But that is an issue with the #define not the called functions.
>
>Possibly changing the #define to have:
>	unsigned long ul_old = (unsigned long)(old);
>Or even, with the type check from:
>	unsigned long ul_old = (unsigned long)(0 ? *(ptr) : (old));
>(with the same for 'new')
>and the removing all the casts where the value are used might be better.
>
>David
>
>> 
>> 							Thanx, Paul
>
>
Hmm. Okie dokie, noted for V2, thanks for the review, 

I'm sure arch code is just implementing this function, so I hope nothing
went wrong with the arch code.
--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
