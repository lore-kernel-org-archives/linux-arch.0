Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D452249F129;
	Tue, 22 Sep 2026 23:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790118367; cv=none; b=iq5/cTgH6hNENydoRYc3ccjBlhPWjzzsPZ0jUTOceGCOIX41dGdp47RL9rGoh4+DasU5LWSSoQsw4wEYGdsUY6h71m0pgmg1IXsZw89q23VaIDYk30MpWy0zHt6J0WGJq8fgXRD9nyvfwaKWgTau6iphfYingQhSfsW4OEVq688=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790118367; c=relaxed/simple;
	bh=EmGSukYVu9aG+Eu1hs9iHp1plMrq3eLcrl/6PCE1evo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2yWxSJtWF6cwqM4HIt3StBq2I4ftYRrLznAINUST9mAR37DFOL4k7qCLMX3mxADOzejHzNpI23C5WfqtZyoJGYmU+X2fSnVRTAvxIWVr5tmlTYWI3lG+wj8fj6C3a+uALURJ45aG7Cvq+Z9NtPSHU3Czl6UQWi6xCuoC2/YJjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXVfl775; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXVfl775"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6EB1F000FF;
	Tue, 22 Sep 2026 23:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790118365;
	bh=/tRbI6XkA8MPG1ny+jKahsxINKgsku5yR+AT0hT9eCM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=lXVfl7756EL7HSGKyR9mbEmgPPWnZRPR+y7JpN/HZlavwjdnB1Z/pgEDvNs9hfS7m
	 mmGMCU0mm754ETZabpB+yAIXjg6cd44aBfApfjVqey5ZvwSYRIyO/MXSvxPTQV8jRM
	 5VM68QWqrnGI3hxTbNtACtjUA7nVaqlqZCDVRADbz98iwyF7Sb/a1vCKEmMUh0+b2S
	 e8qcKrHmlbS56Gi/kSLADZB422ZgCrtRTvsc1Orv2iOrt5IksuzvX/khCSOtY/pjF0
	 xiAxBMWGk7rtsBe898hzXch3RfVvvKHX1hlJtUzdzzCEVPlHekF3CYFkincVW2ITTn
	 3qjfQ1wesTwvw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1306ECE098B; Tue, 22 Sep 2026 16:06:05 -0700 (PDT)
Date: Tue, 22 Sep 2026 16:06:05 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
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
	Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] sh: Emulate two-byte cmpxchg
Message-ID: <43815338-7862-4ab1-a078-47161909a246@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260911192540.20983-1-brads@mainlining.org>
 <20260911192540.20983-6-brads@mainlining.org>
 <1835e3f1b7e936479964f5e40583133484510d25.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1835e3f1b7e936479964f5e40583133484510d25.camel@physik.fu-berlin.de>

On Wed, Sep 16, 2026 at 09:16:16PM +0200, John Paul Adrian Glaubitz wrote:
> Hi Bradley,
> 
> On Fri, 2026-09-11 at 19:25 +0000, Bradley Morgan wrote:
> > SH has no byte or halfword atomic memory operations, so the
> > __cmpxchg() switch routes case 1 through cmpxchg_emu_u8() and
> > lets case 2 fall through to __cmpxchg_called_with_bad_pointer(),
> > which is declared but never defined, so a two-byte cmpxchg()
> > fails at link time. Route case 2 through the new cmpxchg_emu_u16().
> > 
> > Signed-off-by: Bradley Morgan <brads@mainlining.org>
> > ---
> >  arch/sh/include/asm/cmpxchg.h | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/sh/include/asm/cmpxchg.h b/arch/sh/include/asm/cmpxchg.h
> > index 1e5dc5ccf7bf..477d3025a441 100644
> > --- a/arch/sh/include/asm/cmpxchg.h
> > +++ b/arch/sh/include/asm/cmpxchg.h
> > @@ -59,6 +59,8 @@ static inline unsigned long __cmpxchg(volatile void * ptr, unsigned long old,
> >  	switch (size) {
> >  	case 1:
> >  		return cmpxchg_emu_u8(ptr, old, new);
> > +	case 2:
> > +		return cmpxchg_emu_u16(ptr, old, new);
> >  	case 4:
> >  		return __cmpxchg_u32(ptr, old, new);
> >  	}
> 
> Odd, I thought this series was merged long time ago. Was there anything holding it back?
> 
> Either way:
> 
> Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Thank you, John!

In my reshuffling, I associated the arch/sh/Kconfig change with the
cmpxchg.h changes, as shown below.  The idea is to show all the changes
for a given architecture in one place.  I kept your Acked-by, but please
let me know if this is in any way problematic.

						Thanx, Paul

------------------------------------------------------------------------

commit 662151462e30187c342cffcd250834a32a9eb67a
Author: Bradley Morgan <brads@mainlining.org>
Date:   Tue Sep 22 17:33:52 2026 +0000

    sh: Emulate two-byte cmpxchg
    
    SH has no byte or halfword atomic memory operations, so the __cmpxchg()
    switch routes case 1 through cmpxchg_emu_u8() and lets case 2 fall
    through to __cmpxchg_called_with_bad_pointer(), which is declared but
    never defined, so a two-byte cmpxchg() fails at link time. Route case
    2 through the new cmpxchg_emu_u16(), which takes the old and new
    values as unsigned long, so the (unsigned long) casts move off the
    call and into _old_ and _new_ declarations that type check the old
    and new arguments against *ptr through (unsigned long)(0 ? *ptr : _o_),
    the idiom David Laight suggested, so cmpxchg(&p, 4, 5) no longer
    compiles silently.
    
    Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
    Signed-off-by: Bradley Morgan <brads@mainlining.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
    Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
    Cc: Rich Felker <dalias@libc.org>
    Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
    Cc: <linux-sh@vger.kernel.org>

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index d60f1d5a94c0..09e556fced01 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -14,7 +14,7 @@ config SUPERH
 	select ARCH_HIBERNATION_POSSIBLE if MMU
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_WANT_IPC_PARSE_VERSION
-	select ARCH_NEED_CMPXCHG_1_EMU
+	select ARCH_NEED_CMPXCHG_1_2_EMU
 	select CPU_NO_EFFICIENT_FFS
 	select DMA_DECLARE_COHERENT
 	select GENERIC_ATOMIC64
diff --git a/arch/sh/include/asm/cmpxchg.h b/arch/sh/include/asm/cmpxchg.h
index 1e5dc5ccf7bf..b87f59107b4e 100644
--- a/arch/sh/include/asm/cmpxchg.h
+++ b/arch/sh/include/asm/cmpxchg.h
@@ -59,6 +59,8 @@ static inline unsigned long __cmpxchg(volatile void * ptr, unsigned long old,
 	switch (size) {
 	case 1:
 		return cmpxchg_emu_u8(ptr, old, new);
+	case 2:
+		return cmpxchg_emu_u16(ptr, old, new);
 	case 4:
 		return __cmpxchg_u32(ptr, old, new);
 	}
@@ -70,8 +72,10 @@ static inline unsigned long __cmpxchg(volatile void * ptr, unsigned long old,
   ({									 \
      __typeof__(*(ptr)) _o_ = (o);					 \
      __typeof__(*(ptr)) _n_ = (n);					 \
-     (__typeof__(*(ptr))) __cmpxchg((ptr), (unsigned long)_o_,		 \
-				    (unsigned long)_n_, sizeof(*(ptr))); \
+     unsigned long _old_ = (unsigned long)(0 ? *ptr : _o_);	 \
+     unsigned long _new_ = (unsigned long)(0 ? *ptr : _n_);	 \
+     (__typeof__(*(ptr))) __cmpxchg((ptr), _old_,				 \
+				    _new_, sizeof(*(ptr)));	 \
   })
 
 #include <asm-generic/cmpxchg-local.h>
