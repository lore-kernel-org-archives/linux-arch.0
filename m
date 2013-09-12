From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] Kconfig cleanup (PARPORT_PC dependencies)
Date: Thu, 12 Sep 2013 21:49:04 +0100
Message-ID: <20130912204904.GR12758@n2100.arm.linux.org.uk>
References: <1379012038-31764-1-git-send-email-msalter@redhat.com> <20130912203204.GA26170@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54481 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757162Ab3ILUtg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 12 Sep 2013 16:49:36 -0400
Content-Disposition: inline
In-Reply-To: <20130912203204.GA26170@merkur.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Mark Salter <msalter@redhat.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, tony.luck@intel.com, geert@linux-m68k.org, monstr@monstr.eu, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, lethal@linux-sh.org, davem@davemloft.net, cmetcalf@tilera.com, gxt@mprc.pku.edu.cn, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com

On Thu, Sep 12, 2013 at 10:32:04PM +0200, Sam Ravnborg wrote:
> On Thu, Sep 12, 2013 at 02:53:58PM -0400, Mark Salter wrote:
> > Remove messy dependencies from PARPORT_PC by having it depend on one
> > Kconfig symbol (ARCH_MAY_HAVE_PC_PARPORT) and having architectures
> > which need it declare ARCH_MAY_HAVE_PC_PARPORT in arch/*/Kconfig.
> > New architectures are unlikely to need PARPORT_PC, so this avoids
> > having an ever growing list of architectures to exclude. Those
> > architectures which do declare ARCH_MAY_HAVE_PC_PARPORT in this
> > patch are the ones which have an asm/parport.h.
> 
> It is much nicer if you provide a config symbol only once.
> And then let the architectures who want it select this symbol.
> 
> This is the pattern we use for similar things in many places today,
> so it is best to follow that pattern.

Yes, and if you do, please be sensitive to the files you're editing.
If you find yourself adding a "select" statement at the bottom of an
already sorted list, then you're probably going to make someone less
than happy.

(I've just re-sorted arch/arm/Kconfig's select statements after they've
become mis-sorted - originally sorted alphabetically at akpm's request
to avoid conflicts.  It now has a comment at the end of the main list
asking for new additions to be appropriately placed.)
