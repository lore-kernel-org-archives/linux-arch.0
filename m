Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S266508AbUHOGYG@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:43945 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266507AbUHOGYG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 15 Aug 2004 02:24:06 -0400
Date: Sat, 14 Aug 2004 23:22:23 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Re: clear_user_highpage()
Message-Id: <20040814232223.5e1aea52.akpm@osdl.org>
In-Reply-To: <20040812044634.GF11200@holomorphy.com>
References: <20040811161537.5e24c2b6.davem@redhat.com>
	<Pine.LNX.4.58.0408111635160.1839@ppc970.osdl.org>
	<20040812004654.GX11200@holomorphy.com>
	<Pine.LNX.4.58.0408111905210.1839@ppc970.osdl.org>
	<20040811194317.0acf4ae3.davem@redhat.com>
	<Pine.LNX.4.58.0408112113310.1839@ppc970.osdl.org>
	<20040812044634.GF11200@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: William Lee Irwin III <wli@holomorphy.com>
Cc: torvalds@osdl.org, davem@redhat.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> On Wed, 11 Aug 2004, David S. Miller wrote:
>  >> We have that cold/hot page thing in the current 2.6.x
>  >> tree, or are you talking about something else?
> 
>  On Wed, Aug 11, 2004 at 09:19:32PM -0700, Linus Torvalds wrote:
>  > You're right. It ended up never having problems (or they were worked out
>  > in the -mm tree), so I forgot all about it ;)
>  > How effective is it? Maybe the numbers that were done in 2001 aren't 
>  > relevant any more?
> 
>  For lock amortization it's extremely effective. Its effects on caching
>  have never been properly instrumented that I know of.

No, we (me, mbligh) instrumented the crap out of it.  It turned out that
the cache affinity was of very marginal benefit, if any.

I cooked up an artificial benchmark which consisted of writing 32k to a
file, then truncating it back to zero, then repeating.  Four instances of
that, against four separate files on 4-way showed a large speedup - 2x or
3x, from memory.  But for real-world workloads you really needed to squint
to see anything at all.

Which is why I dithered without sending it to Linus for a couple of months.
Ended up merging it anyway because of some lock contention benefits, and
because someone mught have a workload which involves repeated
write/truncate looping ;)
