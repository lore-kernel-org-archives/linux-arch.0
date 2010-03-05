From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [PATCH/RFC 0/8] Numa: Use Generic Per-cpu Variables for
 numa_*_id()
Date: Fri, 5 Mar 2010 10:19:12 +0900
Message-ID: <20100305101912.f0a875df.kamezawa.hiroyu@jp.fujitsu.com>
References: <20100304170654.10606.32225.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:35713 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924Ab0CEBWx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 4 Mar 2010 20:22:53 -0500
In-Reply-To: <20100304170654.10606.32225.sendpatchset@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Lee Schermerhorn <lee.schermerhorn@hp.com>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-numa@vger.kernel.org, Tejun Heo <tj@kernel.org>, Mel Gorman <mel@csn.ul.ie>, Andi Kleen <andi@firstfloor.org>, Christoph Lameter <cl@linux-foundation.org>, Nick Piggin <npiggin@suse.de>, David Rientjes <rientjes@google.com>, akpm@linux-foundation.org, eric.whitney@hp.com

On Thu, 04 Mar 2010 12:06:54 -0500
Lee Schermerhorn <lee.schermerhorn@hp.com> wrote:

> >nid-04:
> >
> >* Isn't #define numa_mem numa_node a bit dangerous?  Someone might use
> >  numa_mem as a local variable name.  Why not define it as a inline
> >  function or at least a macro which takes argument.
> 
> numa_mem and numa_node are the names of the per cpu variables, referenced
> by __this_cpu_read().  So, I suppose we can rename them both something like:
> percpu_numa_*.  Would satisfy your concern?
> 
> What do others think?
> 
> Currently I've left them as numa_mem and numa_node.
> 

Could you add some documentation to Documentation/vm/numa ?
about
  numa_node_id()
  numa_mem_id()
  topics on memory-less node
  (cpu-less node)
  

Recently I see this kind of topics on list but I'm not sure whether
I catch the issues/changes correctly....

Thanks,
-Kame
