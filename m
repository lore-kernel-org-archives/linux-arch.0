From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH 0/2] Missing READ_ONCE in core and arch-specific
 pgtable code leading to crashes
Date: Fri, 29 Sep 2017 09:56:34 +0100
Message-ID: <20170929085634.GA14791@arm.com>
References: <1506527369-19535-1-git-send-email-will.deacon@arm.com>
 <9f351432-3c6b-3b06-7b49-bc9a5806aff5@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39834 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751004AbdI2I4U (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 29 Sep 2017 04:56:20 -0400
Content-Disposition: inline
In-Reply-To: <9f351432-3c6b-3b06-7b49-bc9a5806aff5@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jon Masters <jcm@redhat.com>
Cc: peterz@infradead.org, paulmck@linux.vnet.ibm.com, kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org, ynorov@caviumnetworks.com, rruigrok@codeaurora.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, catalin.marinas@arm.com, timur@codeaurora.org

[+ Timur]

On Thu, Sep 28, 2017 at 03:38:00PM -0400, Jon Masters wrote:
> On 09/27/2017 11:49 AM, Will Deacon wrote:
> 
> > The moral of the story is that read-after-read (same address) ordering *only*
> > applies if READ_ONCE is used consistently. This means we need to fix page
> > table dereferences in the core code as well as the arch code to avoid this
> > problem. The two RFC patches in this series fix arm64 (which is a bigger fix
> > that necessary since I clean things up too) and page_vma_mapped_walk.
> > 
> > Comments welcome.
> 
> Thanks for this Will. I'll echo Timur's comment that it would be ideal
> to split this up into the critical piece needed for ordering
> access/update to the PMD in the face of a THP split and separately have
> the cosmetic cleanups. Needless to say, we've got a bunch of people who
> are tracking this one and tracking it ready for backport. We just got
> THP re-enabled so I'm pretty keen that we not have to disable again.

Yeah, of course. I already posted a point diff to Yury in the original
thread:

http://lists.infradead.org/pipermail/linux-arm-kernel/2017-September/533299.html

so I'd like to queue that as an arm64 fix after we've worked out the general
direction of the full fix. I also don't see why other architectures
(including x86) can't be hit by this, so an alternative (completely
untested) approach would just be to take patch 2 of this series.

The full fix isn't just cosmetic; it's also addressing the wider problem
of unannotated racing page table accesses outside of the specific failure
case we've run into.

Will
