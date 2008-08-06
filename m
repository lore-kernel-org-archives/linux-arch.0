From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: kbuild now support arch/$ARCH/include - time for ARCHs to convert
Date: Wed, 6 Aug 2008 21:27:29 +0200
Message-ID: <20080806192729.GA17227@uranus.ravnborg.org>
References: <20080728200500.GA14284@uranus.ravnborg.org> <200808051418.05324.rusty@rustcorp.com.au> <20080805204548.GD5464@uranus.ravnborg.org> <20080805220615.GC18607@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtpout3.tre.se ([80.251.192.228]:37205 "EHLO smtpout3.tre.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754309AbYHFT0x (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 6 Aug 2008 15:26:53 -0400
Content-Disposition: inline
In-Reply-To: <20080805220615.GC18607@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rusty Russell <rusty@rustcorp.com.au>, linux arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

> 
> Currently, I know Linus' tree builds fine for most ARM platforms (thanks
> to the ARM kautobuild project.)  However, I'm seeing unexpected build
> failures that don't make sense from the linux-next project.
> 
> I've just wound my tree back to a "pristine" state for linux-next, and
> plan to wait for its next build to check whether its me or something else
> causing it.  What I'm referring to is:
> 
> s3c2410_defconfig's showing:
> include/asm/arch/map.h:16:30: error: asm/plat-s3c/map.h: No such file or directory
> 
> which, if its including it via include/ shouldn't be happening because
> plat-s3c hasn't moved from include/asm(-arm)/, the same as
> include/asm-arm/arch-s3c2410 hasn't moved in linux-next yet.

This is a kbuild bug.
The top-level Makefile creates the include2/asm symlink only
if the file$(srctree)/include/asm-$ARCH/errno.h is present.

And you moved errno.h when you committed your changes so symlink
is not created anymore thus it fails.
But this is oly with "make O=..." builds which I think kautobuild
does not use (since it did not trigger the bug).

I cannot recall the exact reason why I did this check before
creating the symlink so I will simply create it always.

	Sam
