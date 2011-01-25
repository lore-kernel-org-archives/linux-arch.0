From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 00/25] mm: Preemptibility -v7
Date: Tue, 25 Jan 2011 11:45:28 -0800
Message-ID: <m2ipxcsr6v.fsf@linux.intel.com>
References: <20110125173111.720927511@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:56031 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751828Ab1AYUkF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 25 Jan 2011 15:40:05 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glka-linux-arch@m.gmane.org>)
	id 1PhpgJ-0006gi-8W
	for linux-arch@vger.kernel.org; Tue, 25 Jan 2011 21:40:03 +0100
Received: from jfdmzpr02-ext.jf.intel.com ([134.134.137.71])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-arch@vger.kernel.org>; Tue, 25 Jan 2011 21:40:03 +0100
Received: from ak by jfdmzpr02-ext.jf.intel.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-arch@vger.kernel.org>; Tue, 25 Jan 2011 21:40:03 +0100
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.orglinux-kernel@vger.kernel.org

Peter Zijlstra <a.p.zijlstra@chello.nl> writes:

> This patch-set makes part of the mm a lot more preemptible. It converts
> i_mmap_lock and anon_vma->lock to mutexes and makes mmu_gather fully
> preemptible.
>
> The main motivation was making mm_take_all_locks() preemptible, since it
> appears people are nesting hundreds of spinlocks there.

Just curious: why is mm_take_all_locks() a problem? As far as I can see
it's just used when starting KVM or GRU the first time. Is that a common
situation?

-Andi

-- 
Andi Kleen
Intel Open Source Technology Center
