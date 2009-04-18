From: Ingo Molnar <mingo@elte.hu>
Subject: Re: kbuild - introduce support for subdir-ccflags-y
Date: Sat, 18 Apr 2009 17:07:50 +0200
Message-ID: <20090418150750.GA24059@elte.hu>
References: <20090418125159.GA23008@uranus.ravnborg.org> <20090418125839.GA3668@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090418125839.GA3668@flint.arm.linux.org.uk>
Sender: linux-kbuild-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, linux arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linu>
List-Id: linux-arch.vger.kernel.org


* Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> On Sat, Apr 18, 2009 at 02:51:59PM +0200, Sam Ravnborg wrote:
> > The typical use cases are an architecture or a subsystem that
> > decide to cover all files with -Werror.
> > Today alpha, mips and sparc uses -Werror in almost all their
> > Makefile - with subdir-ccflag-y it is now simpler to do so
> > as only the top-level directories needs to be covered.
> 
> Hmm, this won't make sense for ARM.  We have things like #warning 
> and deprecated functions in machine specific headers, and adding 
> -Werror to the whole of arch/arm/ will result in these causing 
> builds to fail.

This is optional - if you dont want it, you dont set it.

	Ingo
