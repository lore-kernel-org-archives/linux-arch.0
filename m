From: David Miller <davem@davemloft.net>
Subject: Re: Do we use runtime patching of function calls somewhere?
Date: Sun, 13 May 2012 14:32:29 -0400 (EDT)
Message-ID: <20120513.143229.1966847219427517224.davem@davemloft.net>
References: <20120513121600.GA15708@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:49426 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100Ab2EMScc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 13 May 2012 14:32:32 -0400
In-Reply-To: <20120513121600.GA15708@merkur.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: sam@ravnborg.org
Cc: linux-arch@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 13 May 2012 14:16:00 +0200

> I could try to come up with something myself - but if we already
> have it somewhere maybe there is something to be inspired by.

You could relocatable link, record all the R_SPARC_WDISP30 relocations
into a special data file (which you'd link into vmlinux), then provide
a stub version of all the routines.

At run time you walk through the relocations and resolve them just as
the linker or the module loader would.

But I wouldn't do this, it's hairy with modules etc.

Instead, I'd do for these routines what sparc64 does, which is patch
the actual code.

You have a base implementation which is at least as large as the
largest implementation which exists.  Then you simply copy the
instructions over from the implementation you want to use.  All
branches must be relative and be to destination only within the
routine itself, otherwise you'd have to fixup their offsets since the
necessary branch displacement changes once you move the instruction
from one place to another.

See arch/sparc/mm/ultra.S
