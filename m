From: David Miller <davem@davemloft.net>
Subject: Re: Do we use runtime patching of function calls somewhere?
Date: Sun, 13 May 2012 16:01:17 -0400 (EDT)
Message-ID: <20120513.160117.2049168343158239303.davem@davemloft.net>
References: <20120513121600.GA15708@merkur.ravnborg.org>
	<20120513.143229.1966847219427517224.davem@davemloft.net>
	<20120513184537.GA2434@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:49790 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752717Ab2EMUBV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 13 May 2012 16:01:21 -0400
In-Reply-To: <20120513184537.GA2434@merkur.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: sam@ravnborg.org
Cc: linux-arch@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 13 May 2012 20:45:38 +0200

> On Sun, May 13, 2012 at 02:32:29PM -0400, David Miller wrote:
>> Instead, I'd do for these routines what sparc64 does, which is patch
>> the actual code.
>> 
>> You have a base implementation which is at least as large as the
>> largest implementation which exists.  Then you simply copy the
>> instructions over from the implementation you want to use.  All
>> branches must be relative and be to destination only within the
>> routine itself, otherwise you'd have to fixup their offsets since the
>> necessary branch displacement changes once you move the instruction
>> from one place to another.
> 
> That makes sense - then we do not need to search for the callers etc.
> And we can use the base implemntation as the default case.
> 
> But I need to brush up my sparc assembler skills a bit first, I'm
> afraid.  I will put this on my todo list as this would be good to
> have, but I will postpone the idea for now.

BTW, I just wanted to make a note that the R_SPARC_WDISP30 thing I
mentioned is essentially what btfixup is doing by hand.  If you look
at arch/sparc/boot/btfix.S that gets generated, it has the table of
relocations (call sites to fix up) and then the NOP function stubs so
that vmlinux can link.
