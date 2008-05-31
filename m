From: Jeremy Higdon <jeremy@sgi.com>
Subject: Re: MMIO and gcc re-ordering issue
Date: Sat, 31 May 2008 00:52:42 -0700
Message-ID: <20080531075242.GC108600@sgi.com>
References: <1211852026.3286.36.camel@pasglop> <20080526.184047.88207142.davem@davemloft.net> <1211854540.3286.42.camel@pasglop> <20080526.192812.184590464.davem@davemloft.net> <20080526204233.75b71bb8@infradead.org> <1211872130.3286.64.camel@pasglop> <adaprr721c6.fsf@cisco.com> <1211922696.3286.82.camel@pasglop> <adaiqwzsa83.fsf@cisco.com> <yq0iqwxrwuh.fsf@jaguar.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from relay1.sgi.com ([192.48.171.29]:45935 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751410AbYEaHwu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 31 May 2008 03:52:50 -0400
Content-Disposition: inline
In-Reply-To: <yq0iqwxrwuh.fsf@jaguar.mkp.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jes Sorensen <jes@sgi.com>
Cc: Roland Dreier <rdreier@cisco.com>, benh@kernel.crashing.org, Arjan van de Ven <arjan@infradead.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tpiepho@freescale.com, linuxppc-dev@ozlabs.org, scottwood@freescale.com, torvalds@linux-foundation.org, David Miller <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk

On Thu, May 29, 2008 at 10:47:18AM -0400, Jes Sorensen wrote:
> Thats not going to solve the problem on Altix. On Altix the issue is
> that there can be multiple paths through the NUMA fabric from cpuX to
> PCI bridge Y. 
> 
> Consider this uber-cool<tm> ascii art - NR is my abbrevation for NUMA
> router:
> 
>         -------         -------
>         |cpu X|         |cpu Y|
>         -------         -------
>          |   \____  ____/    |
>          |        \/         |
>          |    ____/\____     |
>          |   /          \    |
>          -----          ------
>          |NR 1|         |NR 2|
>          ------         ------
>               \         /
>                \       /
>                 -------
>                 | PCI |
>                 -------
> 
> The problem is that your two writel's, despite being both issued on
> cpu X, due to the spin lock, in your example, can end up with the
> first one going through NR 1 and the second one going through NR 2. If
> there's contention on NR 1, the write going via NR 2 may hit the PCI
> bridge prior to the one going via NR 1.

We don't actually have that problem on the Altix.  All writes issued
by CPU X will be ordered with respect to each other.  But writes by
CPU X and CPU Y will not be, unless an mmiowb() is done by the
original CPU before the second CPU writes.  I.e.

	CPU X	writel
	CPU X	writel
	CPU X	mmiowb

	CPU Y	writel
	...

Note that this implies some sort of locking.  Also note that if in
the above, CPU Y did the mmiowb, that would not work.

jeremy
