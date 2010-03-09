Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:52577 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753446Ab0CIIq7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 9 Mar 2010 03:46:59 -0500
Message-ID: <4B960AD0.8010709@kernel.org>
Date: Tue, 09 Mar 2010 17:46:08 +0900
From: Tejun Heo <tj@kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH/RFC 1/8] numa: prep:  move generic percpu interface definitions
 to percpu-defs.h
References: <20100304170654.10606.32225.sendpatchset@localhost.localdomain> <20100304170702.10606.85808.sendpatchset@localhost.localdomain>
In-Reply-To: <20100304170702.10606.85808.sendpatchset@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Lee Schermerhorn <lee.schermerhorn@hp.com>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-numa@vger.kernel.org, Mel Gorman <mel@csn.ul.ie>, Andi Kleen <andi@firstfloor.org>, Christoph Lameter <cl@linux-foundation.org>, Nick Piggin <npiggin@suse.de>, David Rientjes <rientjes@google.com>, akpm@linux-foundation.org, eric.whitney@hp.com
Message-ID: <20100309084608.oRGav1veyKCG1cKA3pF1Dt28Lq1mrzvd1yJ0pe_jLGE@z>

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
