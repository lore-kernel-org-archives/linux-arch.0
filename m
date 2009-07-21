From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH/RFC] kbuild: use INSTALLKERNEL to select customized
	installkernel script
Date: Tue, 21 Jul 2009 09:18:36 +0200
Message-ID: <20090721071836.GA7210@merkur.ravnborg.org>
References: <20090720201137.GB6854@merkur.ravnborg.org> <20090720221120.GG11151@n2100.arm.linux.org.uk> <4A651863.6090009@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pfepb.post.tele.dk ([195.41.46.236]:53114 "EHLO
	pfepb.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943AbZGUHSk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2009 03:18:40 -0400
Content-Disposition: inline
In-Reply-To: <4A651863.6090009@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ian Campbell <icampbell@arcom.com>, Mike Frysinger <vapier@gentoo.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Hirokazu Takata <takata@linux-m32r.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Kyle McMartin <kyle@mcmartin.ca>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>

On Mon, Jul 20, 2009 at 06:22:43PM -0700, H. Peter Anvin wrote:
> Russell King - ARM Linux wrote:
> > 
> > That's a good thing in some ways and a bad thing in others.  Having
> > it guarantee to fail if you try installing an ARM kernel onto an
> > x86 machine is definitely a good thing.  That said, it's not something
> > I've ever accidentally done.
> > 
> 
> I guess we could have it error out if you are building a non-native
> architecture but don't set CROSS_COMPILE.  Either that or we could
> default $INSTALLKERNEL to $(CROSS_COMPILE)installkernel, which would be
> backwards compatible.
I had googled a bit to try to analyse how much use
this feature has seen.
And I only managed to find the original patch implementing this.

None of the books I found mention this in their
install kernel chapets either.

So the conclusion - it is not widely used.

Russell is right that one implicit use is that "make CROSS_COMPILE=foo install"
would fail. And with this patch it would succeed.
Trying to error out is we are doing a non-native build is not the
right answer. People may like to have a custom script that can
ftp the new kernel somewhere or stuff like that. 

All that combined with the fact that using the binutils/gcc
CROSS_COMPILE prefix is the wrong solution anyway made me
conclude that we should fix this rather than implement it
in a different way.

That combined with the fact that CROSS_COMPILE has two
primary usages:

   - binutils/gcc prefix when building for another architecture

   - distcc/ccache

The latter does not fit well with the installkernel use.

I briefly looked into creating another way to specify
distcc / ccache.
But the current way to do things works well - so I dropped it again.

	Sam
