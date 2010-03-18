From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: + documentation-volatile-considered-harmfultxt-correct-cpu_relax-documentation.patch
 added to -mm tree
Date: Thu, 18 Mar 2010 14:54:52 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1003181447420.18017@i5.linux-foundation.org>
References: <201003182141.o2ILfgB0017286@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59493 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752056Ab0CRV6Y (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 18 Mar 2010 17:58:24 -0400
In-Reply-To: <201003182141.o2ILfgB0017286@imap1.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: mm-commits@vger.kernel.org, rmk@arm.linux.org.uk, linux-arch@vger.kernel.org, rmk+kernel@arm.linux.org.uk



On Thu, 18 Mar 2010, akpm@linux-foundation.org wrote:
> 
> cpu_relax() is documented in volatile-considered-harmful.txt to be a
> memory barrier.  However, everyone with the exception of Blackfin and
> possibly ia64 defines cpu_relax() to be a compiler barrier.
> 
> Make the documentation reflect the general concensus.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: <linux-arch@vger.kernel.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Acked-by: Linus Torvalds <torvalds@linux-foundation.org>

I don't think it was ever the intention that it would be seen as anything 
but a compiler barrier, although it is obviously implied that it might 
well perform some per-architecture actions that have "memory barrier-like" 
semantics.

After all, the whole and only point of the "cpu_relax()" thing is to tell 
the CPU that we're busy-looping on some event.

And that "event" might be (and often is) about reading the same memory 
location over and over until it changes to what we want it to be. So it's 
quite possible that on various architectures the "cpu_relax()" could be 
about making sure that such a tight loop on loads doesn't starve cache 
transactions, for example - and as such look a bit like a memory barrier 
from a CPU standpoint.

But it's not meant to have any kind of architectural memory ordering 
semantics as far as the kernel is concerned - those must come from other 
sources.

			Linus
