Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268456AbUHLAYL@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:4827 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268453AbUHLAVx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Aug 2004 20:21:53 -0400
Date: Wed, 11 Aug 2004 17:21:41 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: clear_user_highpage()
In-Reply-To: <1092268853.2179.28.camel@gaston>
Message-ID: <Pine.LNX.4.58.0408111716390.1839@ppc970.osdl.org>
References: <20040811161537.5e24c2b6.davem@redhat.com>
 <Pine.LNX.4.58.0408111635160.1839@ppc970.osdl.org> <1092268853.2179.28.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "David S. Miller" <davem@redhat.com>, Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>



On Thu, 12 Aug 2004, Benjamin Herrenschmidt wrote:
> 
> Ok, the later makes sense... especially since we could use the ppc dcbz
> instruction to "create blank cache lines" (not bothering at all about
> the previous content of the line)

ppc64 definitely already does that according to <asm/page.h> ;) 

>				, though I would expect any modern
> write combining CPU to figure that out based on the access pattern and
> end up doing the same at the cache level

Quite possibly.  I certainly hope so, but I suspect especially for the 
memory clearing case it's just simpler for everybody to just tell the CPU 
to do it.

		Linus
