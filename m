Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36583 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752943AbZDRM6z (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 18 Apr 2009 08:58:55 -0400
Date: Sat, 18 Apr 2009 13:58:39 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: kbuild - introduce support for subdir-ccflags-y
Message-ID: <20090418125839.GA3668@flint.arm.linux.org.uk>
References: <20090418125159.GA23008@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090418125159.GA23008@uranus.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>, linux arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "David S. Miller" <davem@davemloft.net>
Message-ID: <20090418125839.KsEto90DOYoEb93TrjrnHTSw3I1eT0d1xoYtWHsfIVQ@z>

On Sat, Apr 18, 2009 at 02:51:59PM +0200, Sam Ravnborg wrote:
> The typical use cases are an architecture or a subsystem that
> decide to cover all files with -Werror.
> Today alpha, mips and sparc uses -Werror in almost all their
> Makefile - with subdir-ccflag-y it is now simpler to do so
> as only the top-level directories needs to be covered.

Hmm, this won't make sense for ARM.  We have things like #warning and
deprecated functions in machine specific headers, and adding -Werror
to the whole of arch/arm/ will result in these causing builds to fail.

Adding it just for boot,common,kernel,lib,mm,nwfpe,oprofile,vfp (iow
everything except the mach-* and plat-* directories) would make sense
though.

> The feature is added because the x86 guys are planning
> to (conditionally) cover all of arch/x86/ with -Werrror
> and adding this statement in each single Makefile
> was *the wrong way* to do so.

I think that's the way we're going to _have_ to do it on ARM.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
