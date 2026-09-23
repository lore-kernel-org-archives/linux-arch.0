Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A1970836;
	Wed, 23 Sep 2026 17:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790182839; cv=none; b=MobyNvYwRQLQVs3d2jmwfOmqfXkA3Dn7IWRNivNQHCCT8pZNN6DBo3CDeTxTt3AoUpSR9UEXwC/rlLEBFKqFVfrCyZKye7XRCyOUCv2YL/2TNIc3laLCOB11h/GUhSGb7AzGfm0L0c3FlOg9T4zw45qnk3hFXWE2gOcdMbrS9V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790182839; c=relaxed/simple;
	bh=upvQ28kj+Zot6l2sr0FocrdOCH6thCSzV9pOZTXEDnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkrIZySZvYbJMr5RQoQOBChsG6vjclteCnht7DMiYPX4iXqr0ETnQuSGOaWD8nmQPW9HVxNS0isPeI22FqkGMBvVsIJYqIZnhhc/8pW3kHUi9W7k9+M1EeOieip1Jeu+pKVMGziJuJH0H59r+TpXSCItdVESgkhm6cfp0YjzsXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3SWeuyx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3SWeuyx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A7C1F000FF;
	Wed, 23 Sep 2026 17:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790182834;
	bh=oYrY96BkmNrksWcvVD7C1QohSxV2WmGeTWj6WJeQNwk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=O3SWeuyxeCA33WKiVgWynxkaK6WXM/9PzNvKGGJvHYgMtZ7fzf5wNbGABcm2PyPj0
	 ulo+tAaMqePdNeRO4+Z12Obay4r+X761lYIAXX7LBrFpH1jyxy/IcTr3YvwTboZroO
	 tHqehtSNX4OCsUOvOroNHB5MqUtLlAWLWuyWJ/jPw7b+0IN20cMVOt8NDPbZXBh0uj
	 6TQhIAVJGZD1sl840y39G+sYKSRYOGPkxAYleHfPbZOxM9hfcg3XAzKEEUnh3MCz7U
	 WBGGn5AXMVNwklMPoO+X82EHE3INiTFAxKTO0GDKUZXxF9WmRvptntaEd3aJ7hfXe1
	 HTGdL2PEWqJxA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id AFC4ACE1598; Wed, 23 Sep 2026 10:00:33 -0700 (PDT)
Date: Wed, 23 Sep 2026 10:00:33 -0700
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
Message-ID: <93f2bb33-c5ec-4836-8b1b-d0ee131be5b7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260911192540.20983-1-brads@mainlining.org>
 <20260911192540.20983-2-brads@mainlining.org>
 <20260923114313.75494970@pumpkin>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923114313.75494970@pumpkin>

On Wed, Sep 23, 2026 at 11:43:13AM +0100, David Laight wrote:
> On Fri, 11 Sep 2026 19:25:34 +0000
> Bradley Morgan <brads@mainlining.org> wrote:
> 
> > cmpxchg_emu_u8() emulates one-byte cmpxchg() in terms of four-byte
> > cmpxchg() for the architectures lacking native one-byte atomics.
> > The same architectures also lack native two-byte cmpxchg(), where
> > such an operation is not supported and either fails to compile via
> > BUILD_BUG() or fails to link, because the bad pointer sentinels
> > these architectures declare are never defined.
> > 
> > Add cmpxchg_emu_u16(), the two-byte sibling. It reads the enclosing
> > word with READ_ONCE(), splices the two target bytes through a union
> > and loops on cmpxchg() of the full word until the compare succeeds.
> > Like cmpxchg_emu_u8() it is fully ordered.
> > 
> > The Kconfig symbol gating this file is renamed from
> > ARCH_NEED_CMPXCHG_1_EMU to ARCH_NEED_CMPXCHG_1_2_EMU, as it now
> > selects both the one-byte and the two-byte emulation.
> > 
> > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Bradley Morgan <brads@mainlining.org>
> > ---
> >  arch/Kconfig                |  2 +-
> >  arch/arc/Kconfig            |  2 +-
> >  arch/arm/Kconfig            |  2 +-
> >  arch/csky/Kconfig           |  2 +-
> >  arch/sh/Kconfig             |  2 +-
> >  arch/xtensa/Kconfig         |  2 +-
> >  include/linux/cmpxchg-emu.h |  1 +
> >  lib/Makefile                |  2 +-
> >  lib/cmpxchg-emu.c           | 35 ++++++++++++++++++++++++++++++++---
> >  9 files changed, 40 insertions(+), 10 deletions(-)
> > 
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index 3bb2e568f5b1..d56064797e09 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -1817,7 +1817,7 @@ config CC_HAS_SANE_FUNCTION_ALIGNMENT
> >  	# strict alignment always, even with -falign-functions.
> >  	def_bool CC_HAS_MIN_FUNCTION_ALIGNMENT || CC_IS_CLANG
> >  
> > -config ARCH_NEED_CMPXCHG_1_EMU
> > +config ARCH_NEED_CMPXCHG_1_2_EMU
> 
> Is it actually worth the churn of changing the name?
> Maybe just a comment that say it adds both 1 and 2 byte emulation?

The churn is only a few lines of code, and the potential confusion from
the name would be forever.  I agree that if we were stuck with the old
name, the comment would help, but why not just rip the bandage off and
be done with it?  ;-)

							Thanx, Paul
