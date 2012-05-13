From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Do we use runtime patching of function calls somewhere?
Date: Sun, 13 May 2012 20:45:38 +0200
Message-ID: <20120513184537.GA2434@merkur.ravnborg.org>
References: <20120513121600.GA15708@merkur.ravnborg.org> <20120513.143229.1966847219427517224.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.snhosting.dk ([87.238.248.203]:57901 "EHLO
	smtp.domainteam.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256Ab2EMSpl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 13 May 2012 14:45:41 -0400
Content-Disposition: inline
In-Reply-To: <20120513.143229.1966847219427517224.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org

On Sun, May 13, 2012 at 02:32:29PM -0400, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Sun, 13 May 2012 14:16:00 +0200
> 
> > I could try to come up with something myself - but if we already
> > have it somewhere maybe there is something to be inspired by.
> 
> You could relocatable link, record all the R_SPARC_WDISP30 relocations
> into a special data file (which you'd link into vmlinux), then provide
> a stub version of all the routines.
> 
> At run time you walk through the relocations and resolve them just as
> the linker or the module loader would.
> 
> But I wouldn't do this, it's hairy with modules etc.
> 
> Instead, I'd do for these routines what sparc64 does, which is patch
> the actual code.
> 
> You have a base implementation which is at least as large as the
> largest implementation which exists.  Then you simply copy the
> instructions over from the implementation you want to use.  All
> branches must be relative and be to destination only within the
> routine itself, otherwise you'd have to fixup their offsets since the
> necessary branch displacement changes once you move the instruction
> from one place to another.

That makes sense - then we do not need to search for the callers etc.
And we can use the base implemntation as the default case.

But I need to brush up my sparc assembler skills a bit first,
I'm afraid.
I will put this on my todo list as this would be good to
have, but I will postpone the idea for now.

	Sam
