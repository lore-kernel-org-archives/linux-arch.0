From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [RFC PATCH 0/6] ARM: mm: HugeTLB + THP support.
Date: Fri, 21 Dec 2012 14:41:51 +0100
Message-ID: <50D4671F.1010003@free-electrons.com>
References: <1350576942-25299-1-git-send-email-steve.capper@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.32.191]:40782 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978Ab2LUNmQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 21 Dec 2012 08:42:16 -0500
In-Reply-To: <1350576942-25299-1-git-send-email-steve.capper@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steve Capper <steve.capper@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, aarcange@redhat.com, bill4carson@gmail.com, tawfik@marvell.com, catalin.marinas@arm.com, will.deacon@arm.com, cmetcalf@tilera.com, mhocko@suse.cz, maen@marvell.com, hoffman@marvell.com, notasas@gmail.com, kirill@shutemov.name, akpm@linux-foundation.org, shadi@marvell.com, Lior Amsalem <alior@marvell.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>Maen Suleiman <maen@marvell.com>

On 10/18/2012 06:15 PM, Steve Capper wrote:
> Hello,
Hi Steve,

I resurrected this old thread to have some news about this subject.
We are interested to get this support for the Armada 370/XP based boards.

I am surprised that there wasn't any feedback on this series. We are
willing to help this feature being merge in the kernel.

Testing your series on the board we have could help you?

Thanks

> The following patches bring both HugeTLB support and Transparent HugePage (THP)
> support to ARM.
> 
> Both short descriptors (non-LPAE) and long descriptors (LPAE) are supported.
> 
> The non-LPAE HugeTLB code is based on patches by Bill Carson [1], but instead of
> allocating extra memory to store "Linux PTEs", it re-purposes the domain bits
> of section descriptors and constructs huge Linux PTEs on demand.
> 
> As PMDs are walked directly by the kernel THP functions (there are no
> huge_pmd_offset style functions), any "linux PMD"/"hardware PMD" distinction
> would require some re-working of the ARM PMD/PTE code. Use of the domain bits
> allows for a more straightforward THP implementation.
> 
> Some general HugeTLB code relating to huge page migration on memory failure
> (CONFIG_MEMORY_FAILURE) de-references huge pte_t *s directly rather than use
> the huge_ptep_get and set_huge_pte_at functions. Thus this config option is
> incompatible with non-LPAE hugepages. At the moment I can only see x86 using
> CONFIG_MEMORY_FAILURE though.
> 
> For non-LPAE, I make an assumption about how the memory type is mapped between
> linux PTE and section descriptor. Ideally I would like to look this information
> up, possibly from get_mem_types(MT_MEMORY). Comments on an elegant way of
> achieving this are welcome.
> 
> Non-LPAE code was tested on a Versatile Express (V2P-CA15_A7 Cortex A15 tile),
> Tegra 2 TrimSlice and RealView ARM11MPCore.
> 
> The LPAE code manipulates the hardware page tables directly as the long
> descriptors are wide enough to contain all the Linux PTE information.
> 
> The LPAE code has been tested on a Versatile Express: V2F-2XV6 Cortex A15 and
> V2P-CA15_A7 Cortex A15 tiles.
> 
> This patch set requires the following to be applied on top of 3.7-rc1:
> "ARM: mm: introduce L_PTE_VALID for page table entries"
>   (PROT_NONE series, posted by Will on linux-arm-kernel)
>   - http://lists.infradead.org/pipermail/linux-arm-kernel/2012-October/126130.html
> 
> "mm: thp: Set the accessed flag for old pages on access fault."
>   (posted by Will on linux-mm)
>    - http://marc.info/?l=linux-kernel&m=135048927416117&w=2
> 
> Cheers,
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
