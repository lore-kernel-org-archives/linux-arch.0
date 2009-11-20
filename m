From: Christoph Lameter <cl@linux-foundation.org>
Subject: Re: [PATCH/RFC 0/6] Numa: Use Generic Per-cpu Variables for
 numa_*_id()
Date: Fri, 20 Nov 2009 10:43:36 -0500 (EST)
Message-ID: <alpine.DEB.1.10.0911201041170.25879@V090114053VZO-1>
References: <20091113211714.15074.29078.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20091113211714.15074.29078.sendpatchset@localhost.localdomain>
Sender: owner-linux-mm@kvack.org
To: Lee Schermerhorn <lee.schermerhorn@hp.com>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, Mel Gorman <mel@csn.ul.ie>, Christoph Lameter <clameter@sgi.com>, Nick Piggin <npiggin@suse.de>, David Rientjes <rientjes@google.com>, eric.whitney@hp.com
List-Id: linux-arch.vger.kernel.org

On Fri, 13 Nov 2009, Lee Schermerhorn wrote:

> Ad hoc measurements on x86_64 using:  hackbench 400 process 200
>
> 2.6.32-rc5+mmotm-091101		no patch	this series
> x86_64 avg of 40:		  4.605		  4.628  ~0.5%

Instructions become more efficient here.

> Ia64 showed ~1.2% longer time with the series applied.

IA64 can use the per cpu TLB entry to get to the numa node id with the
platform specific per cpu handling. The per cpu implementation
currently requires fallback. IA64 percpu ops could be reworked to avoid
consulting the per cpu offset arrray which would make it equivalent to the
current implementation.


--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
