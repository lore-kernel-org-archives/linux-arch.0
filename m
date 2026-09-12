Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD8E2C08D0;
	Sat, 12 Sep 2026 18:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789239484; cv=none; b=W+jqHYHvIOKsB4iGlTCmGPU5KyQsow8KyBAJjbTJrWBLh+61wJUWM2+V0mrNF5Q6W0hwcpljD8aBnPbpmCx9pw9eyDhPxEQ4Qk6cPNHIuFbEdVINwJkzDK4nqrFoLm9Vm6TyHLEPZcIotByL8pZ90cenocqEG9Gr+X3r46JlmEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789239484; c=relaxed/simple;
	bh=y3CQirMNKJQfcwKc4KuXVIcD4nkiaw5eX7+nHt9Rmz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UgeCRQjhdX9Ukol/KJx6HNLGQ3iLu6hp0DzahC/Ak8+AxYz1CDscCsvZh18twz+KmI/60QkiLb1qr6MqNkc72p/K3mKqvb1uTtjUO49mIf1+QnDadyLxi3VcEygYd3DReB8V++kxuFAN+6yIm/72L1GZCQ3eUqnZvhCj4wSmTls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b129hE7D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b129hE7D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3411F000FF;
	Sat, 12 Sep 2026 18:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789239483;
	bh=6BluU+mCWJjFo1z+n6s87f5KoVwieJ3DCesot+22iUM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=b129hE7DRPv2I9AH7m/fRZZ/wUraKivazDVqrrdnPPQTFkC4bOPRxSFQ921pq+u1x
	 cGQkMb6MKHfzBNpFFu9GL8/4I146UwIzNCQt+WAS7CsRsoRRUfAPNubcl71S8L93/T
	 M4BxXA2lx75Yt6sFb7qTFJM3fkyQTG7/VCGedhz8RGzs5iM0+wGZ6iy3eDAI/3jJhb
	 HBXihJbQv+/HFP/CY31Aq+Ze+g0B0G+g5Nr9EsIqty/z7SMqrf6FAQQndY7tYg6Nv2
	 Tughn9iBXX5fCq4stHOZiAfKrE2zDe1NEUpSQS1R739nv5jL0eK4meZvyKZABMuXt1
	 T4Ysbtv5zQTRA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 01B51CE1578; Sat, 12 Sep 2026 11:58:02 -0700 (PDT)
Date: Sat, 12 Sep 2026 11:58:02 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Bradley Morgan <brads@mainlining.org>, frederic@kernel.org,
	neeraj.upadhyay@kernel.org, boqun@kernel.org, joelagnelf@nvidia.com,
	rcu@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
	Vineet Gupta <vgupta@kernel.org>,
	linux-snps-arc@lists.infradead.org,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org, Guo Ren <guoren@kernel.org>,
	linux-csky@vger.kernel.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org, Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] lib: Add two-byte cmpxchg emulation function
Message-ID: <17a92c0b-8062-48ae-b5fa-f61a3e0ff24c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260911192540.20983-1-brads@mainlining.org>
 <20260911192540.20983-2-brads@mainlining.org>
 <20260911231017.550f8cd1@pumpkin>
 <d0ef7beb-6952-49cc-9b33-e7542e831ba6@paulmck-laptop>
 <20260912103047.1b95bb03@pumpkin>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912103047.1b95bb03@pumpkin>

On Sat, Sep 12, 2026 at 10:30:47AM +0100, David Laight wrote:
> On Fri, 11 Sep 2026 16:09:16 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > On Fri, Sep 11, 2026 at 11:10:17PM +0100, David Laight wrote:
> > > On Fri, 11 Sep 2026 19:25:34 +0000
> > > Bradley Morgan <brads@mainlining.org> wrote:
> > >   
> > > > cmpxchg_emu_u8() emulates one-byte cmpxchg() in terms of four-byte
> > > > cmpxchg() for the architectures lacking native one-byte atomics.
> > > > The same architectures also lack native two-byte cmpxchg(), where
> > > > such an operation is not supported and either fails to compile via
> > > > BUILD_BUG() or fails to link, because the bad pointer sentinels
> > > > these architectures declare are never defined.
> > > > 
> > > > Add cmpxchg_emu_u16(), the two-byte sibling. It reads the enclosing
> > > > word with READ_ONCE(), splices the two target bytes through a union
> > > > and loops on cmpxchg() of the full word until the compare succeeds.
> > > > Like cmpxchg_emu_u8() it is fully ordered.
> > > > 
> > > > The Kconfig symbol gating this file is renamed from
> > > > ARCH_NEED_CMPXCHG_1_EMU to ARCH_NEED_CMPXCHG_1_2_EMU, as it now
> > > > selects both the one-byte and the two-byte emulation.
> > > > 
> > > > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > > > Signed-off-by: Bradley Morgan <brads@mainlining.org>
> > > > ---
> > > >  arch/Kconfig                |  2 +-
> > > >  arch/arc/Kconfig            |  2 +-
> > > >  arch/arm/Kconfig            |  2 +-
> > > >  arch/csky/Kconfig           |  2 +-
> > > >  arch/sh/Kconfig             |  2 +-
> > > >  arch/xtensa/Kconfig         |  2 +-
> > > >  include/linux/cmpxchg-emu.h |  1 +
> > > >  lib/Makefile                |  2 +-
> > > >  lib/cmpxchg-emu.c           | 35 ++++++++++++++++++++++++++++++++---
> > > >  9 files changed, 40 insertions(+), 10 deletions(-)
> > > >   
> > > ...  
> > > > diff --git a/include/linux/cmpxchg-emu.h b/include/linux/cmpxchg-emu.h
> > > > index 998deec67740..fee8171fa05e 100644
> > > > --- a/include/linux/cmpxchg-emu.h
> > > > +++ b/include/linux/cmpxchg-emu.h
> > > > @@ -11,5 +11,6 @@
> > > >  #define __LINUX_CMPXCHG_EMU_H
> > > >  
> > > >  uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new);
> > > > +uintptr_t cmpxchg_emu_u16(volatile u16 *p, uintptr_t old, uintptr_t new);  
> > > 
> > > Why uintptr_t? Shouldn't it just be u16?
> > > (Which probably means the code would better if it was just 'unsigned int')  
> > 
> > I suspect that Bradley is just following my cmpxchg_emu_u8() example,
> > which also returns uintptr_t.
> > 
> > I remember that *something* broke when I made this be u8, but I cannot
> > recall what the problem was.
> > 
> > Bradley, could you please try making it be u16 as David suggests just to
> > see what happens?  Who knows?  Maybe it was a compiler issue that has
> > since been fixed.  Or maybe the macros and asms using cmpxchg_emu_u8()
> > need that uintptr_t for some reason.
> 
> I think the uintptr (unsigned long) cast is needed to stop a compile
> error when exchanging pointers.
> But that is an issue with the #define not the called functions.
> 
> Possibly changing the #define to have:
> 	unsigned long ul_old = (unsigned long)(old);
> Or even, with the type check from:
> 	unsigned long ul_old = (unsigned long)(0 ? *(ptr) : (old));
> (with the same for 'new')
> and the removing all the casts where the value are used might be better.

It does sound worth a try, especially since we have the uintptr_t version
to fall back on should that fail, or in case it somehow makes things
more complicated.

But we have been living with uintptr_t for some years with the 8-bit
code, so this should be able to be a follow-on patch.

							Thanx, Paul
