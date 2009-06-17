From: Tejun Heo <tj@kernel.org>
Subject: [GIT PATCH core/percpu] percpu: teach lpage allocator about NUMA
Date: Wed, 17 Jun 2009 13:26:05 +0900
Message-ID: <1245212769-29134-1-git-send-email-tj@kernel.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41148 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754113AbZFQE0e (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 17 Jun 2009 00:26:34 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@elte.hu, andi@firstfloor.org, hpa@zytor.com, tglx@linutronix.de, JBeulich@novell.com, cl@linux-foundati


Hello,

Upon ack, please pull from the following git tree.

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git tj-percpu

This patchset teaches lpage about NUMA.  Till now, lpage allocator did
things per-cpu.  It allocated one large page per cpu and then gave
back whatever is unused which makes chunk size huge which is very
inefficient VM space-wise, makes reclamation not work very well and
adds to TLB pressure when walking other processor's percpu variables.

This patchset first makes the percpu allocator to be able to use
non-linear and/or sparse cpu -> unit mapping and then make lpage
allocator consider CPU topology and group CPUs in LOCAL_DISTANCE into
the same large pages.  For example, on an 4/4 NUMA machine, the
original code used up 16MB for each chunk but the new code uses only
4MB - one large page for each NUMA node.  The grouping code is quite
robust and will try to minimize space wastage even when the CPU
topology is assymmetric.

This patchset will also allow future changes to do partial allocations
for cases where there are possible but offline cpus.

This patchset contains the following four patchets.

 0001-percpu-reorder-a-few-functions-in-mm-percpu.c.patch
 0002-percpu-drop-pcpu_chunk-page.patch
 0003-percpu-allow-non-linear-sparse-cpu-unit-mappin.patch
 0004-percpu-teach-large-page-allocator-about-NUMA.patch

0001 preps for later changes.  0002 drops pcpu_chunk->page which is no
longer necessary and would bloat already large pcpu_chunk size when
the cpu -> unit mapping becomes sparse.

0003 updates percpu core such that non-linear/sparse cpu->unit
mappings are allowed.

0004 teaches lpage allocator about NUMA.

This patchset is on top of

linus-2.6#master (300df7dc89cc276377fc020704e34875d5c473b6)
+ [1] tj-percpu-convert-most-archs, take#3
+ [2] x86-percpu-fix-pageattr, take#4
+ [3] x86-percpu-generalize-4k-and-lpage-allocator

and contains the following changes.

 arch/x86/kernel/setup_percpu.c |   72 ++
 include/linux/percpu.h         |   30 -
 mm/percpu.c                    | 1079 ++++++++++++++++++++++++++++-------------
 3 files changed, 834 insertions(+), 347 deletions(-)

Thanks.

--
tejun

[1] http://thread.gmane.org/gmane.linux.kernel.cross-arch/3818
[2] http://thread.gmane.org/gmane.linux.kernel.cross-arch/3825
[3] http://lkml.org/lkml/2009/6/17/2
