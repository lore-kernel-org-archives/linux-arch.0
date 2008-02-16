Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:50789 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754384AbYBPAnE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 15 Feb 2008 19:43:04 -0500
Received: by rv-out-0910.google.com with SMTP id k20so633946rvb.1
        for <linux-arch@vger.kernel.org>; Fri, 15 Feb 2008 16:43:02 -0800 (PST)
Date: Sat, 16 Feb 2008 03:42:49 +0300
Subject: Re: Announce: Linux-next (Or Andrew's dream  :-))
Message-ID: <20080216004249.GA3263@martell.zuzino.mipt.ru>
References: <20080212120208.f7168a91.sfr@canb.auug.org.au> <20080216000943.GD31474@flint.arm.linux.org.uk> <20080215162121.317c7c1c.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080215162121.317c7c1c.akpm@linux-foundation.org>
From: Alexey Dobriyan <adobriyan@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, linux-arch@vger.kernel.org, torvalds@linux-foundation.org

On Fri, Feb 15, 2008 at 04:21:21PM -0800, Andrew Morton wrote:
> On Sat, 16 Feb 2008 00:09:43 +0000
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> 
> > For reference, even _I_ don't build test the entire set of ARM defconfigs -
> > at about 7 minutes a build, 75 defconfigs, that's about 9 hours...  I
> > just build those which are important to myself, hope that the others are
> > fine, and rely on kautobuild finding any breakage.
> > 
> 
> you need a better box ;)
> 
> cerfcube_defconfig:				35 seconds
> carmeva_defconfig:				23 seconds
> spitz_defconfig (one of the biggest):		45 seconds
> 
> so would a stupid `for i in arch/arm/configs/*' script be sufficient
> coverage?

I do this wildcard together with 

	yes '' | make ARCH=arm ... oldconfig
	make

Sans toolchain issues, it's pretty good -- Russell larts you when some
defconfig becomes broken anyway. :^)
