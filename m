Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from holomorphy.com ([66.93.40.71]:46011 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S932199AbWBCJhk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2006 04:37:40 -0500
Date: Fri, 3 Feb 2006 01:36:18 -0800
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: percpu data changes
Message-ID: <20060203093618.GF2866@holomorphy.com>
References: <20060203011748.6fe3fee3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060203011748.6fe3fee3.akpm@osdl.org>
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Mikael Starvik <starvik@axis.com>, David Howells <dhowells@redhat.com>, Kyle McMartin <kyle@parisc-linux.org>, Anton Blanchard <anton@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mundt <lethal@linux-sh.org>, "David S. Miller" <davem@davemloft.net>, Andi Kleen <ak@muc.de>, Christian Zankel <chris@zankel.net>, Philippe Elie <phil.el@wanadoo.fr>, Nathan Scott <nathans@sgi.com>, Jens Axboe <axboe@suse.de>, linux-arch@vger.kernel.org, Eric Dumazet <dada1@cosmosbay.com>
List-ID: <linux-arch.vger.kernel.org>

On Fri, Feb 03, 2006 at 01:17:48AM -0800, Andrew Morton wrote:
> It seems that powerpc has gone and changed their implementation of percpu
> data so that there is no memory allocated for not-possible CPUs.  To save a
> bit of RAM.
> This means that any code which does
> 
> 	for (i = 0; i < NR_CPUS; i++)
> 		touch(percpudata(i))
> will explode on powerpc.
> I have a patch queued up (for 2.6.16) which fixes most users of percpu
> data.  Make them use for_each_cpu().  I'll send that in a moment.
...

Blanket Acked-by: William Irwin <wli@holomorphy.com>


-- wli
