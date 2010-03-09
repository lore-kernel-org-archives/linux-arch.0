From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH/RFC 1/8] numa: prep:  move generic percpu interface definitions
 to percpu-defs.h
Date: Tue, 09 Mar 2010 17:46:08 +0900
Message-ID: <4B960AD0.8010709@kernel.org>
References: <20100304170654.10606.32225.sendpatchset@localhost.localdomain> <20100304170702.10606.85808.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-numa-owner@vger.kernel.org>
In-Reply-To: <20100304170702.10606.85808.sendpatchset@localhost.localdomain>
Sender: linux-numa-owner@vger.kernel.org
To: Lee Schermerhorn <lee.schermerhorn@hp.com>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-numa@vger.kernel.org, Mel Gorman <mel@csn.ul.ie>, Andi Kleen <andi@firstfloor.org>, Christoph Lameter <cl@linux-foundation.org>, Nick Piggin <npiggin@suse.de>, David Rientjes <rientjes@google.com>, akpm@linux-foundation.org, eric.whitney@hp.com
List-Id: linux-arch.vger.kernel.org

Hello,

On 03/05/2010 02:07 AM, Lee Schermerhorn wrote:
> To use the generic percpu infrastructure for the numa_node_id() interface,
> defined in linux/topology.h, we need to break the circular header dependency
> that results from including <linux/percpu.h> in <linux/topology.h>.  The
> circular dependency:
> 
> 	percpu.h -> slab.h -> gfp.h -> topology.h
> 
> percpu.h includes slab.h to obtain the definition of kzalloc()/kfree() for
> inlining __alloc_percpu() and free_percpu() in !SMP configurations.  One could
> un-inline these functions in the !SMP case, but a large number of files depend
> on percpu.h to include slab.h.  Tejun Heo suggested moving the definitions to
> percpu-defs.h and requested that this be separated from the remainder of the
> generic percpu numa_node_id() preparation patch.

Hmmm... I think uninlining !SMP case would be much cleaner.  Sorry
that you had to do it twice.  I'll break the dependency in the percpu
devel branch and let you know.

For other patches, except for what Christoph has already pointed out,
everything looks good to me.

Thank you.

-- 
tejun
