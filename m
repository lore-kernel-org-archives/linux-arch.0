From: Michal Marek <mmarek@suse.cz>
Subject: Re: subtle side effect of commit a1c48bb160f836
Date: Thu, 18 Jun 2015 10:13:29 +0200
Message-ID: <20150618081329.GA9434@pobox.suse.cz>
References: <55826966.6050202@synopsys.com> <CAMuHMdXWHYF8hEEgeFxLTrhvmEDBVS2=VmKykfOtDkGjqODQbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49118 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753799AbbFRINd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 18 Jun 2015 04:13:33 -0400
Content-Disposition: inline
In-Reply-To: <CAMuHMdXWHYF8hEEgeFxLTrhvmEDBVS2=VmKykfOtDkGjqODQbA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>

On Thu, Jun 18, 2015 at 09:10:30AM +0200, Geert Uytterhoeven wrote:
> Hi Vineet,
> 
> On Thu, Jun 18, 2015 at 8:47 AM, Vineet Gupta
> <Vineet.Gupta1@synopsys.com> wrote:
> > commit a1c48bb160f8368 "Makefile: Fix unrecognized cross-compiler command line
> > options" moved ARCH specific cc option handling before common -Os/O2 setup.
> >
> > For ARC this had a subtle effect that we can no longer over-ride generic -O2 with
> > -O3, hence a performance regression observed going from 3.13 to 3.18 (the above
> > commit went into 3.16)
> >
> > I want to understand how to properly fix this. Moving the include of arch makefile
> > will bring back the old issue. I can introduce another option to set default optim
> > level, but only arc/m32r care about it anyways.

m32r only sets -O for its assembler.


> Can we include $(srctree)/arch/$(SRCARCH)/Makefile twice?

Please don't, the gcc commandline is long enough already.


> Or perhaps we can not apply the extra -O* if there's already a -O* option?
> 
> Alternatively, as we already have CONFIG_CC_OPTIMIZE_FOR_SIZE,
> a(nother) Kconfig option may make sense.

We can also introduce some ARCH_CFLAGS that is appended near the end of
the list, and have arc/Makefile add its -O3 there. But I'd like to why
the -O3 needs to be there in first place. Obviously, the kernel works
with -O2, otherwise the regression would have been identified earlier.
So why can't users specify -O3 in KCFLAGS like on any other
architecture.

Michal
