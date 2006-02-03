Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:45512 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932460AbWBCLaX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2006 06:30:23 -0500
From: Andi Kleen <ak@suse.de>
Subject: Re: percpu data changes
Date: Fri, 3 Feb 2006 12:07:13 +0100
References: <20060203011748.6fe3fee3.akpm@osdl.org> <200602031051.49816.ak@suse.de> <43E33802.6090502@cosmosbay.com>
In-Reply-To: <43E33802.6090502@cosmosbay.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200602031207.14816.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Andrew Morton <akpm@osdl.org>, Mikael Starvik <starvik@axis.com>, David Howells <dhowells@redhat.com>, Kyle McMartin <kyle@parisc-linux.org>, Anton Blanchard <anton@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mundt <lethal@linux-sh.org>, "David S. Miller" <davem@davemloft.net>, William Lee Irwin III <wli@holomorphy.com>, Andi Kleen <ak@muc.de>, Christian Zankel <chris@zankel.net>, Philippe Elie <phil.el@wanadoo.fr>, Nathan Scott <nathans@sgi.com>, Jens Axboe <axboe@suse.de>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Friday 03 February 2006 12:01, Eric Dumazet wrote:
> Andi Kleen a écrit :
> > On Friday 03 February 2006 10:17, Andrew Morton wrote:
> >> It seems that powerpc has gone and changed their implementation of percpu
> >> data so that there is no memory allocated for not-possible CPUs.  To save a
> >> bit of RAM.
> >>
> >> This means that any code which does
> >>
> >> 	for (i = 0; i < NR_CPUS; i++)
> >> 		touch(percpudata(i))
> >>
> >> will explode on powerpc.
> > 
> > It also explodes since some time on x86-64.
> > 
> > But I added a workaround now (or rather sent one and Linus dropped it)
> > to point the not possible CPUs to the reference data and not free it.
> > With that violating that protocol is mostly harmless.
> > 
> > Later the plan was to point it to unmapped data to catch all users.
> 
> Maybe you can port the following i386 patch to x86_64 ? (I dont have a x86_64 
> test machine at this moment)

Yes good idea. I will add it after 2.6.16.

-Andi
