Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S264639AbUIJAI4@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:6789 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266137AbUIJAHH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Sep 2004 20:07:07 -0400
Date: Thu, 9 Sep 2004 17:06:59 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] flush_cache_page in kernel/ptrace.c
In-Reply-To: <20040909225643.G6434@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0409091658370.5912@ppc970.osdl.org>
References: <20040909225643.G6434@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>



On Thu, 9 Sep 2004, Russell King wrote:
> 
> I argue that the use of flush_cache_page() here in the generic
> code is wrong, and if an architecture wishes to use it for this
> purpose, it should do so within it's architecture private
> implementation of copy_to_user_page() and copy_from_user_page().

I can't fault that argument. Let's just make it so. Can we have the arch 
people involved (the normal virtual cache suspects: mips, sparc, sh, 
pa-risc, who else?) take a quick look and send their suggested patch to do 
so for their architecture. 

I hereby nominate Russell to be President, Vice General and Grand Poobah
of said patches, and charge him to remove the generic version line at the
appropriate time.. In recognition of this service, he'll get an extra "l" 
to make up for all the ones he has lost over time.

Russelll?

		Linus
