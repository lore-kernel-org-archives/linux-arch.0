From: Tejun Heo <tj@kernel.org>
Subject: [GIT PATCH core/percpu] x86,percpu: generalize 4k and lpage allocator
Date: Wed, 17 Jun 2009 13:04:30 +0900
Message-ID: <1245211476-27015-1-git-send-email-tj@kernel.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752648AbZFQEFc@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@elte.hu, andi@firstfloor.org, hpa@zytor.com, tglx@linutronix.de
List-Id: linux-arch.vger.kernel.org


Hello,

Upon ack, please pull from the following git tree.

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git tj-percpu-make-allocators-generic

This patchset generalizes 4k and lpage first chunk allocators and
makes x86 call these generic helpers.  This will help converting other
architectures to dynamic percpu and be the basis for further first
chunk allocator improvements by standardizing how the first chunk is
allocated.

This patchset contains the following six patches.

 0001-x86-make-pcpu_chunk_addr_search-matching-stricter.patch
 0002-percpu-drop-unit_size-from-embed-first-chunk-alloc.patch
 0003-x86-percpu-generalize-4k-first-chunk-allocator.patch
 0004-percpu-make-4k-first-chunk-allocator-map-memory.patch
 0005-x86-percpu-generalize-lpage-first-chunk-allocator.patch
 0006-percpu-simplify-pcpu_setup_first_chunk.patch

0001 and 0002 are cleanups which don't make any functional difference.

0003-0004 generalizes 4k allocator and makes its behavior more uniform
with other allocators.  0005 generalizes lpage allocator.

As 0004 makes generic alloc/map handling in pcpu_setup_first_chunk()
unnecessary, 0006 drops it.  This simplification will allow dropping
pcpu_chunk->page[] by later patchset.

This patchset is on top of

linus-2.6#master (300df7dc89cc276377fc020704e34875d5c473b6)
+ [1] tj-percpu-convert-most-archs, take#3
+ [2] x86-percpu-fix-pageattr, take#4

and contains the following changes.

 arch/x86/include/asm/percpu.h  |    9 
 arch/x86/kernel/setup_percpu.c |  247 ++--------------------
 arch/x86/mm/pageattr.c         |    1 
 include/linux/percpu.h         |   44 +++
 mm/percpu.c                    |  455 ++++++++++++++++++++++++++++++++---------
 5 files changed, 433 insertions(+), 323 deletions(-)

Thanks.

--
tejun

[1] http://thread.gmane.org/gmane.linux.kernel.cross-arch/3818
[2] http://thread.gmane.org/gmane.linux.kernel.cross-arch/3825
