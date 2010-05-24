Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:1322 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752878Ab0EXOl7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 24 May 2010 10:41:59 -0400
Subject: Re: [PATCH 3/7]
 numa-x86_64-use-generic-percpu-var-numa_node_id-implementation-fix1
From: Lee Schermerhorn <Lee.Schermerhorn@hp.com>
In-Reply-To: <144644.1274710321@localhost>
References: <20100503150455.15039.10178.sendpatchset@localhost.localdomain>
	 <20100503150518.15039.3576.sendpatchset@localhost.localdomain>
	 <20100521160240.b61d3404.akpm@linux-foundation.org>
	 <1274710172.13756.122.camel@useless.americas.hpqcorp.net>
	 <144644.1274710321@localhost>
Content-Type: text/plain
Date: Mon, 24 May 2010 10:41:52 -0400
Message-ID: <1274712112.13756.177.camel@useless.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Valdis.Kletnieks@vt.edu
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-numa@vger.kernel.org, Tejun Heo <tj@kernel.org>, Randy Dunlap <randy.dunlap@oracle.com>, Christoph Lameter <cl@linux-foundation.org>, eric.whitney@hp.com, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <20100524144152.6f63yavZ8V-AL-TIh9bPXIs23caa7HtOY5QqypGsQ88@z>

On Mon, 2010-05-24 at 10:12 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Mon, 24 May 2010 10:09:32 EDT, Lee Schermerhorn said:
> > 
> > You asked about the fix3 patch [offlist] on Wednesday, 19May.  Do you
> > have that one in your tree?
>  
> numa-introduce-numa_mem_id-effective-local-memory-node-id-fix3.patch
> was in -mmotm0521.

Right.  But, Andrew needs:
numa-x86_64-use-generic-percpu-var-numa_node_id-implementation-fix3 --
i.e., a fix to the 2nd patch of the percpu numa_*_id patch series.

Thanks,
Lee


