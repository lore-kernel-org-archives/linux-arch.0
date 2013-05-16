Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.21]:45801 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751423Ab3EPPGP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 May 2013 11:06:15 -0400
Date: Thu, 16 May 2013 15:58:48 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [RFC PATCH v2 08/11] ARM64: mm: Swap PTE_FILE and
 PTE_PROT_NONE bits.
Message-ID: <20130516145848.GE18308@arm.com>
References: <1368006763-30774-1-git-send-email-steve.capper@linaro.org>
 <1368006763-30774-9-git-send-email-steve.capper@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1368006763-30774-9-git-send-email-steve.capper@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steve Capper <steve.capper@linaro.org>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>, "x86@kernel.org" <x86@kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Michal Hocko <mhocko@suse.cz>, Ken Chen <kenchen@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon <Will.Deacon@arm.com>, "patches@linaro.org" <patches@linaro.org>
Message-ID: <20130516145848.r8UHujrVHp2JvAsmOAh5mxk0JErBBRdh83pRlV4K-5g@z>

On Wed, May 08, 2013 at 10:52:40AM +0100, Steve Capper wrote:
> Under ARM64, PTEs can be broadly categorised as follows:
>    - Present and valid: Bit #0 is set. The PTE is valid and memory
>      access to the region may fault.
> 
>    - Present and invalid: Bit #0 is clear and bit #1 is set.
>      Represents present memory with PROT_NONE protection. The PTE
>      is an invalid entry, and the user fault handler will raise a
>      SIGSEGV.
> 
>    - Not present (file): Bits #0 and #1 are clear, bit #2 is set.
>      Memory represented has been paged out. The PTE is an invalid
>      entry, and the fault handler will try and re-populate the
>      memory where necessary.
> 
> Huge PTEs are block descriptors that have bit #1 clear. If we wish
> to represent PROT_NONE huge PTEs we then run into a problem as
> there is no way to distinguish between regular and huge PTEs if we
> set bit #1.
> 
> As huge PTEs are always present, the meaning of bits #1 and #2 can
> be swapped for invalid PTEs. This patch swaps the PTE_FILE and
> PTE_PROT_NONE constants, allowing us to represent PROT_NONE huge
> PTEs.

I guess we'll never get a huge_(pte|pmd)_file() (but we can shift the
file bits up anyway).

> Signed-off-by: Steve Capper <steve.capper@linaro.org>

Apart from the comments you already got:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
