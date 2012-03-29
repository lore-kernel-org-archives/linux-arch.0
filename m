From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GIT PULL] Disintegrate and kill asm/system.h
Date: Thu, 29 Mar 2012 23:48:07 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1203292344140.2542@ionos>
References: <5599.1332958811@redhat.com> <30702.1332989444@neuling.org> <20120329135555.06593144b65bf81cc9191f8a@canb.auug.org.au> <20120329151544.ef2117821dfb459e8b52af48@canb.auug.org.au> <CA+55aFzn=bsH76hPDUgS-FBP=RVu51gwmRdqjkw5RJO=Q_cRfA@mail.gmail.com>
 <20120329154238.1ce219f7c998da45452af4b2@canb.auug.org.au> <CA+55aFzjQ7qb=bPAj_gGoGLPXOGweTaqtmOBZH4mUt8E_KQwsg@mail.gmail.com> <1333008684.3010.9.camel@pasglop> <CACxGe6v+nMMuEM+bBMdYf_OeuaXb+NsS0qz-+puRtdzHLPH2hA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:59260 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933361Ab2C2VsQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 Mar 2012 17:48:16 -0400
In-Reply-To: <CACxGe6v+nMMuEM+bBMdYf_OeuaXb+NsS0qz-+puRtdzHLPH2hA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-arch@vger.kernel.org, Michael Neuling <mikey@neuling.org>, arnd@arndb.de, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, paul.gortmaker@windriver.com, hpa@zytor.com, akpm@linux-foundation.org, ppc-dev <linuxppc-dev@lists.ozlabs.org>

On Thu, 29 Mar 2012, Grant Likely wrote:
> On Thu, Mar 29, 2012 at 2:11 AM, Benjamin Herrenschmidt
> The rightmost fields of /proc/interrupts are a weird set of
> conditional outputs that don't really have any parsable formatting to
> them.  It may be safe to apply my patch because it adds another field
> in the middle of a section of conditional outputs* anyway so tools
> already won't know what those fields mean.  But, regardless, I'm not
> going to take responsibility for applying that patch unless encouraged
> by several other maintainers to do so.

Go ahead. We changed that output several times in the last years
without causing the end of the universe.

Thanks,

	tglx
