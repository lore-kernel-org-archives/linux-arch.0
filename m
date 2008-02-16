Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45851 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911AbYBPIJN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 16 Feb 2008 03:09:13 -0500
Date: Sat, 16 Feb 2008 08:08:41 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: Announce: Linux-next (Or Andrew's dream  :-))
Message-ID: <20080216080841.GA19396@flint.arm.linux.org.uk>
References: <20080212120208.f7168a91.sfr@canb.auug.org.au> <20080216000943.GD31474@flint.arm.linux.org.uk> <20080215162121.317c7c1c.akpm@linux-foundation.org> <20080216004249.GA3263@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080216004249.GA3263@martell.zuzino.mipt.ru>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, linux-arch@vger.kernel.org, torvalds@linux-foundation.org

On Sat, Feb 16, 2008 at 03:42:49AM +0300, Alexey Dobriyan wrote:
> On Fri, Feb 15, 2008 at 04:21:21PM -0800, Andrew Morton wrote:
> > On Sat, 16 Feb 2008 00:09:43 +0000
> > Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > 
> > > For reference, even _I_ don't build test the entire set of ARM defconfigs -
> > > at about 7 minutes a build, 75 defconfigs, that's about 9 hours...  I
> > > just build those which are important to myself, hope that the others are
> > > fine, and rely on kautobuild finding any breakage.
> > > 
> > 
> > you need a better box ;)
> > 
> > cerfcube_defconfig:				35 seconds
> > carmeva_defconfig:				23 seconds
> > spitz_defconfig (one of the biggest):		45 seconds
> > 
> > so would a stupid `for i in arch/arm/configs/*' script be sufficient
> > coverage?
> 
> I do this wildcard together with 
> 
> 	yes '' | make ARCH=arm ... oldconfig
> 	make
> 
> Sans toolchain issues, it's pretty good -- Russell larts you when some
> defconfig becomes broken anyway. :^)

Only when I check the kautobuild website - which I've not been doing
regularly since about end of November, and it only covers Linus'
kernels.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
