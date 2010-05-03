From: Lee Schermerhorn <lee.schermerhorn@hp.com>
Subject: [PATCH 0/7] numa: incremental fixes to generic per cpu numa_*_id() series
Date: Mon, 03 May 2010 11:04:55 -0400
Message-ID: <20100503150455.15039.10178.sendpatchset@localhost.localdomain>
Return-path: <owner-linux-mm@kvack.org>
Sender: owner-linux-mm@kvack.org
To: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-numa@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Valdis.Kletnieks@vt.edu, Randy Dunlap <randy.dunlap@oracle.com>, Christoph Lameter <cl@linux-foundation.org>, eric.whitney@hp.com, Andrew Morton <akpm@linux-foundation.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: linux-arch.vger.kernel.org

The following 7 patches address review comments on the 'generic percpu
numa_*_id()" series currently in the -mm tree [28apr10 mmotm].

Valdis Kletnieks confirmed that this series fixes the i386 !NUMA slab
build breakage that he reported.

With these patches, I have built and tested on x86_64 and ia64 NUMA.   In
addition I built mm/slab.o for x86_64 !NUMA and an entire i386 tree with the
i386 config that Andrew sent out in response to Vlad's report re: i386 !NUMA
slab.o breakage.

It should be obvious from the 'Subject' and the patch descriptions, where
the patches go in the mmotm series.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
