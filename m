From: Jon Masters <jcm@redhat.com>
Subject: Re: [RFC PATCH 0/2] Missing READ_ONCE in core and arch-specific
 pgtable code leading to crashes
Date: Thu, 28 Sep 2017 15:38:00 -0400
Message-ID: <9f351432-3c6b-3b06-7b49-bc9a5806aff5@redhat.com>
References: <1506527369-19535-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1506527369-19535-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, peterz@infradead.org, paulmck@linux.vnet.ibm.com, kirill.shutemov@linux.intel.com
Cc: linux-kernel@vger.kernel.org, ynorov@caviumnetworks.com, rruigrok@codeaurora.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, catalin.marinas@arm.com
List-Id: linux-arch.vger.kernel.org

On 09/27/2017 11:49 AM, Will Deacon wrote:

> The moral of the story is that read-after-read (same address) ordering *only*
> applies if READ_ONCE is used consistently. This means we need to fix page
> table dereferences in the core code as well as the arch code to avoid this
> problem. The two RFC patches in this series fix arm64 (which is a bigger fix
> that necessary since I clean things up too) and page_vma_mapped_walk.
> 
> Comments welcome.

Thanks for this Will. I'll echo Timur's comment that it would be ideal
to split this up into the critical piece needed for ordering
access/update to the PMD in the face of a THP split and separately have
the cosmetic cleanups. Needless to say, we've got a bunch of people who
are tracking this one and tracking it ready for backport. We just got
THP re-enabled so I'm pretty keen that we not have to disable again.

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop
