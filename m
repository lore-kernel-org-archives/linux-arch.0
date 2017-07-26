From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 1/1] mm/hugetlb: Make huge_pte_offset() consistent and
 document behaviour
Date: Wed, 26 Jul 2017 09:39:46 +0100
Message-ID: <20170726083945.4ejqwnxomplrqxrf@armageddon.cambridge.arm.com>
References: <20170725154114.24131-1-punit.agrawal@arm.com>
 <20170725154114.24131-2-punit.agrawal@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57626 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751467AbdGZIjv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Jul 2017 04:39:51 -0400
Content-Disposition: inline
In-Reply-To: <20170725154114.24131-2-punit.agrawal@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, steve.capper@arm.com, will.deacon@arm.com, kirill.shutemov@linux.intel.com, Michal Hocko <mhocko@suse.com>, Mike Kravetz <mike.kravetz@oracle.com>

On Tue, Jul 25, 2017 at 04:41:14PM +0100, Punit Agrawal wrote:
> When walking the page tables to resolve an address that points to
> !p*d_present() entry, huge_pte_offset() returns inconsistent values
> depending on the level of page table (PUD or PMD).
> 
> It returns NULL in the case of a PUD entry while in the case of a PMD
> entry, it returns a pointer to the page table entry.
> 
> A similar inconsitency exists when handling swap entries - returns NULL
> for a PUD entry while a pointer to the pte_t is retured for the PMD
> entry.
> 
> Update huge_pte_offset() to make the behaviour consistent - return NULL
> in the case of p*d_none() and a pointer to the pte_t for hugepage or
> swap entries.
> 
> Document the behaviour to clarify the expected behaviour of this
> function. This is to set clear semantics for architecture specific
> implementations of huge_pte_offset().
> 
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
