Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S266465AbUHBKla@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:5326 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266458AbUHBKkf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 2 Aug 2004 06:40:35 -0400
Date: Mon, 2 Aug 2004 12:40:22 +0200
From: Andi Kleen <ak@suse.de>
Subject: Re: find_next_bit return type
Message-ID: <20040802104022.GA25951@wotan.suse.de>
References: <20040731232434.7263b50c.akpm@osdl.org> <20040731232515.1fead83b.akpm@osdl.org> <20040731235824.249ddb23.davem@redhat.com> <20040801000213.5f01b469.akpm@osdl.org> <20040801001026.68ed7363.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040801001026.68ed7363.davem@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, Aug 01, 2004 at 12:10:26AM -0700, David S. Miller wrote:
> On Sun, 1 Aug 2004 00:02:13 -0700
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > Kind-of.  But it's also cringeworthy to go slinging 8-byte values around
> > when 4-byte values would suffice.  Is it not more efficient to use
> > integers?
> 
> They all go in registers, the same register that could hold the 4-byte
> values too.  There is also no computational cost to doing 64-bit add
> subtract and shift (ie. simple ALU's) compared to 32-bit ones.

Actually at least on Intel EM64T an 64bit sub/add is slower, so it's not
generally true. And 64bit ops generate bigger code on x86-64.

But I still agree with you David that returning long here is better.
Even though I consider it unlikely that anybody will search >4GB 
bitmaps in kernel any time soon (it would be a latency disaster).
But for the usual implementation (find_* subtracting two pointers) 
the function has to do a 64bit subtraction anyways, otherwise
you get a subtle "broken when crossing 4GB boundaries" bug. 
For consistency it is better to have long here.

-Andi
