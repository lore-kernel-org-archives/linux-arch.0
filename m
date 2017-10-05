From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH 0/2] Missing READ_ONCE in core and arch-specific
 pgtable code leading to crashes
Date: Thu, 5 Oct 2017 17:54:33 +0100
Message-ID: <20171005165433.GA4047@arm.com>
References: <1506527369-19535-1-git-send-email-will.deacon@arm.com>
 <9f351432-3c6b-3b06-7b49-bc9a5806aff5@redhat.com>
 <20170929085634.GA14791@arm.com>
 <95366fe6-e1eb-dd39-6f13-903704b5180f@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49086 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751335AbdJEQyd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 5 Oct 2017 12:54:33 -0400
Content-Disposition: inline
In-Reply-To: <95366fe6-e1eb-dd39-6f13-903704b5180f@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jon Masters <jcm@redhat.com>
Cc: peterz@infradead.org, paulmck@linux.vnet.ibm.com, kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org, ynorov@caviumnetworks.com, rruigrok@codeaurora.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, catalin.marinas@arm.com, timur@codeaurora.org

On Tue, Oct 03, 2017 at 02:36:42AM -0400, Jon Masters wrote:
> On 09/29/2017 04:56 AM, Will Deacon wrote:
> 
> > The full fix isn't just cosmetic; it's also addressing the wider problem
> > of unannotated racing page table accesses outside of the specific failure
> > case we've run into.
> 
> Let us know if there are additional tests we should be running on the
> Red Hat end. We've got high hundreds of ARM server systems at this
> point, including pretty much everything out there.

TBH, there's nothing ARM-specific about this issue afaict and it should
be reproducible on x86 if the compiler can keep the initially loaded pmd
live in a GPR for long enough.

As for wider problems, you want to stress anything that does page table
modification concurrently with lockless walkers (although GUP looks mostly
ok modulo the lack of pud_trans_huge support, which I'll try to fix if
I find time).

Will
