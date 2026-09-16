Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8264DE705;
	Wed, 16 Sep 2026 21:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789592486; cv=none; b=nRd6ytQurqunZhxuMFUcqjMGLjzGpSpVqcNB+2g0Z33eaZh36Vj2g5a1zfykTaW1WbYeYB34qH55B+u1fj+Tne34OpSyza4F61yT5EyXnw0QhZdU9jknGrI5xV2L2O/HRX6q7+c4DxYVsIWaTAbRGLIPM7b79sObhK8gZDmVfPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789592486; c=relaxed/simple;
	bh=dvC+nyed1imXNtzCpigw2/hSWgjwH7Pi3stl+Bd+m44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmoqDxrzIXzoPA8g9EV1d0crdDVNQ1G7BLHJuKpQxLDVWZoi79J0Jem3BUMDkA9MLAJflUVFboFPjey9sQkNUh8R5HkhOOQmtqXnEGcUi7j0ypsot65/TV7yn3514m0T0qL/yeA3YD+XiYNYCpr0CDJ/aiMy9d/lcBPf9+KF1XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLsv+qLj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLsv+qLj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57EF91F000FF;
	Wed, 16 Sep 2026 21:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789592470;
	bh=AuXdN9aGbtMyg5CPBRFzrLlbAoIxrshk4vqYbfwx7zk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=VLsv+qLjeEIuF/7HFCetYAKnkSVM5+afDqKwl5Y8elt8ggAsqiPrhgm4AUridwMkZ
	 JUa/cwQ/dxaF73pjj0bh5Ea48hlBTsaO7xkt7UY85+gDWHJAiA0zaZcTgyxZpgv6EC
	 ELBkBjoksOM7pw9H8botxyJsD9MYY7j8/DYTvyTL9MFcP0HCWvkWWRUJ9ByrjCfXQl
	 KWduc61DCtV4CGtkrPp5KybVTRm4pkPGA+/bKX+YtW1sYJGir6pRy5Jxm0D9VLtQ6F
	 Rvf6IRZo1UuWBgHDIs6r1Nd0FO/i2zgnCWxdK0D/W252zvXizTdtNEbtUXvhoLsSVW
	 0jXP1K4b/uJ6A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9923BCE0503; Wed, 16 Sep 2026 14:01:07 -0700 (PDT)
Date: Wed, 16 Sep 2026 14:01:07 -0700
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
Message-ID: <ed3ef87e-b9c8-4aa6-90ca-c1da3e97a8e3@paulmck-laptop>
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

You might be thinking of the cmpxchg_emu_u8() series from a few years back.
This is cmpxchg_emu_u16().

							Thanx, Paul

> Either way:
> 
> Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> 
> Adrian
> 
> -- 
>  .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer
> `. `'   Physicist
>   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
