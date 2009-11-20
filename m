From: Christoph Lameter <cl@linux-foundation.org>
Subject: Re: [PATCH/RFC 1/6] numa: Use Generic Per-cpu Variables for
 numa_node_id()
Date: Fri, 20 Nov 2009 10:46:49 -0500 (EST)
Message-ID: <alpine.DEB.1.10.0911201044320.25879@V090114053VZO-1>
References: <20091113211714.15074.29078.sendpatchset@localhost.localdomain> <20091113211720.15074.99808.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20091113211720.15074.99808.sendpatchset@localhost.localdomain>
Sender: owner-linux-mm@kvack.org
To: Lee Schermerhorn <lee.schermerhorn@hp.com>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, Mel Gorman <mel@csn.ul.ie>, Christoph Lameter <clameter@sgi.com>, Nick Piggin <npiggin@suse.de>, David Rientjes <rientjes@google.com>, eric.whitney@hp.com, Tejun Heo <tj@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Fri, 13 Nov 2009, Lee Schermerhorn wrote:

> Signed-off-by: Lee Schermerhorn <lee.schermerhorn@hp.com>
> [Christoph's signoff here?]

Basically yes. The moving of the this_cpu ops to asm-generic is something
that is bothering me. Tejun?

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
