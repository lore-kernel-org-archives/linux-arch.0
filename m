Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267449AbUIJPXe@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:5898 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S267370AbUIJPXe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 10 Sep 2004 11:23:34 -0400
Date: Fri, 10 Sep 2004 16:23:30 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [RFC] flush_cache_page in kernel/ptrace.c
Message-ID: <20040910162330.F22599@flint.arm.linux.org.uk>
References: <20040909225643.G6434@flint.arm.linux.org.uk> <Pine.LNX.4.58.0409091658370.5912@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409091658370.5912@ppc970.osdl.org>; from torvalds@osdl.org on Thu, Sep 09, 2004 at 05:06:59PM -0700
Sender: Russell King <rmk@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

On Thu, Sep 09, 2004 at 05:06:59PM -0700, Linus Torvalds wrote:
> On Thu, 9 Sep 2004, Russell King wrote:
> > I argue that the use of flush_cache_page() here in the generic
> > code is wrong, and if an architecture wishes to use it for this
> > purpose, it should do so within it's architecture private
> > implementation of copy_to_user_page() and copy_from_user_page().
> 
> I can't fault that argument. Let's just make it so. Can we have the arch 
> people involved (the normal virtual cache suspects: mips, sparc, sh, 
> pa-risc, who else?) take a quick look and send their suggested patch to do 
> so for their architecture. 
> 
> I hereby nominate Russell to be President, Vice General and Grand Poobah
> of said patches, and charge him to remove the generic version line at the
> appropriate time.. In recognition of this service, he'll get an extra "l" 
> to make up for all the ones he has lost over time.
> 
> Russelll?

That's fine by me - please send your patches my way. 8)

Thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
