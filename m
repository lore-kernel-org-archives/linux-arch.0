From: Christoph Lameter <cl@linux-foundation.org>
Subject: Re: [PATCH/RFC 5/8] numa: Introduce numa_mem_id()- effective local
 memory node id
Date: Thu, 4 Mar 2010 12:52:17 -0600 (CST)
Message-ID: <alpine.DEB.2.00.1003041250290.21776@router.home>
References: <20100304170654.10606.32225.sendpatchset@localhost.localdomain> <20100304170817.10606.29049.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20100304170817.10606.29049.sendpatchset@localhost.localdomain>
Sender: owner-linux-mm@kvack.org
To: Lee Schermerhorn <lee.schermerhorn@hp.com>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-numa@vger.kernel.org, Tejun Heo <tj@kernel.org>, Mel Gorman <mel@csn.ul.ie>, Andi Kleen <andi@firstfloor.org>, Nick Piggin <npiggin@suse.de>, David Rientjes <rientjes@google.com>, akpm@linux-foundation.org, eric.whitney@hp.com
List-Id: linux-arch.vger.kernel.org

On Thu, 4 Mar 2010, Lee Schermerhorn wrote:

> numa_mem_id() - returns node number of "local memory" node

Can we call that numa_nearest_node or so? What happens if multiple nodes
are at the same distance? Still feel unsecure about what happens if there
are N closest nodes to M cpuless cpus. Will each of the M cpus use the
first of the N closest nodes for allocation?

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
