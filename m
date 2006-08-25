Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:50408 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S964810AbWHYPDw
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 25 Aug 2006 11:03:52 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k7PF3pc9023801
	for <linux-arch@vger.kernel.org>; Fri, 25 Aug 2006 11:03:51 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k7PF3oaR105158
	for <linux-arch@vger.kernel.org>; Fri, 25 Aug 2006 09:03:50 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k7PF3oKu000397
	for <linux-arch@vger.kernel.org>; Fri, 25 Aug 2006 09:03:50 -0600
Subject: Re: [RFC][PATCH] unify all architecture PAGE_SIZE definitions
From: Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <20060825053127.GA9066@localhost.hsdv.com>
References: <20060824234445.6B519D52@localhost.localdomain>
	 <20060825053127.GA9066@localhost.hsdv.com>
Content-Type: text/plain
Date: Fri, 25 Aug 2006 08:03:43 -0700
Message-Id: <1156518223.12011.175.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, 2006-08-25 at 14:31 +0900, Paul Mundt wrote:
> I like the idea of asm-generic/page_size.h (though why not just use
> asm-generic/page.h?)

asm-generic/page.h looks good.  I'll give it a shot.

> and ripping that out from the architecture headers,
> though the mm/Kconfig bits look like something best left in the
> architecture Kconfigs.
> 
> PAGE_SHIFT is really the only thing of interest, and that can be handled
> without the CONFIG_PAGE_SIZE mess. The architectures that really care
> about it can use their current hacks or just check PAGE_SHIFT. 

I just changed this around a little bit so that only the architectures
that care see the prompt:

> choice
>         prompt "Kernel Page Size"
>         depends on IA64 || SPARC64 || PARISC || MIPS
>         default PAGE_SIZE_4KB if MIPS
>         default PAGE_SIZE_8KB if IA64 || SPARC64 || PARISC
> config PAGE_SIZE_4KB
...

That at least consolidates the four architectures.  I guess I could move
them back, but some of the help text was _really_ similar and it all
seemed pretty redundant.

It wouldn't be hard to move it back, though.  That would certainly work.

-- Dave

