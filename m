From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 0/9] Fixup page directory freeing
Date: Tue, 14 Jan 2020 16:25:26 -0800
Message-ID: <20200114162526.87863ebce00695cc979b5217@linux-foundation.org>
References: <20200114100145.365527-1-aneesh.kumar@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728774AbgAOAZ2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Jan 2020 19:25:28 -0500
In-Reply-To: <20200114100145.365527-1-aneesh.kumar@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: peterz@infradead.org, will@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Tue, 14 Jan 2020 15:31:36 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:

> This is a repost of patch series from Peter with the arch specific changes except ppc64 dropped.
> ppc64 changes are added here because we are redoing the patch series on top of ppc64 changes. This makes it
> easy to backport these changes. Only the first 3 patches need to be backported to stable. 

But none of these patches had a cc:stable in the changelog?

> The thing is, on anything SMP, freeing page directories should observe the
> exact same order as normal page freeing:
> 
>  1) unhook page/directory
>  2) TLB invalidate
>  3) free page/directory
> 
> Without this, any concurrent page-table walk could end up with a Use-after-Free.
> This is esp. trivial for anything that has software page-table walkers
> (HAVE_FAST_GUP / software TLB fill) or the hardware caches partial page-walks
> (ie. caches page directories).
> 
> Even on UP this might give issues since mmu_gather is preemptible these days.
> An interrupt or preempted task accessing user pages might stumble into the free
> page if the hardware caches page directories.
> 
> This patch series fixup ppc64 and add generic MMU_GATHER changes to support the conversion of other architectures.
> I haven't added patches w.r.t other architecture because they are yet to be acked.
