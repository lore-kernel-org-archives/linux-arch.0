From: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] proc: mm: export PTE sizes directly in smaps (v3)
Date: Thu, 1 Dec 2016 13:21:39 +0100
Message-ID: <3d879b98-1d11-adc1-b417-3faa1dd6d9d8@suse.cz>
References: <20161129201703.CE9D5054@viggo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20161129201703.CE9D5054@viggo.jf.intel.com>
Sender: owner-linux-mm@kvack.org
To: Dave Hansen <dave@sr71.net>, linux-kernel@vger.kernel.org
Cc: hch@lst.de, akpm@linux-foundation.org, dan.j.williams@intel.com, khandual@linux.vnet.ibm.com, linux-mm@kvack.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 11/29/2016 09:17 PM, Dave Hansen wrote:
> Andrew, you can drop proc-mm-export-pte-sizes-directly-in-smaps-v2.patch,
> and replace it with this.
>
> Changes from v2:
>  * Do not assume (wrongly) that smaps_hugetlb_range() always uses
>    PUDs.  (Thanks for pointing this out, Vlastimil).  Also handle
>    hstates that are not exactly at PMD/PUD sizes.
>
> Changes from v1:
>  * Do one 'Pte' line per pte size instead of mashing on one line
>  * Use PMD_SIZE for pmds instead of PAGE_SIZE, whoops
>  * Wrote some Documentation/
>
> --
>
> /proc/$pid/smaps has a number of fields that are intended to imply the
> kinds of PTEs used to map memory.  "AnonHugePages" obviously tells you
> how many PMDs are being used.  "MMUPageSize" along with the "Hugetlb"
> fields tells you how many PTEs you have for a huge page.
>
> The current mechanisms work fine when we have one or two page sizes.
> But, they start to get a bit muddled when we mix page sizes inside
> one VMA.  For instance, the DAX folks were proposing adding a set of
> fields like:
>
> 	DevicePages:
> 	DeviceHugePages:
> 	DeviceGiganticPages:
> 	DeviceGinormousPages:
>
> to unmuddle things when page sizes get mixed.  That's fine, but
> it does require userspace know the mapping from our various
> arbitrary names to hardware page sizes on each architecture and
> kernel configuration.  That seems rather suboptimal.
>
> What folks really want is to know how much memory is mapped with
> each page size.  How about we just do *that* instead?
>
> Patch attached.  Seems harmless enough.  Seems to compile on a
> bunch of random architectures.  Makes smaps look like this:
>
> Private_Hugetlb:       0 kB
> Swap:                  0 kB
> SwapPss:               0 kB
> KernelPageSize:        4 kB
> MMUPageSize:           4 kB
> Locked:                0 kB
> Ptes@4kB:	      32 kB
> Ptes@2MB:	    2048 kB
>
> The format I used here should be unlikely to break smaps parsers
> unless they're looking for "kB" and now match the 'Ptes@4kB' instead
> of the one at the end of the line.
>
> Note: hugetlbfs PTEs are unusual.  We can have more than one "pte_t"
> for each hugetlbfs "page".  arm64 has this configuration, and probably
> others.  The code should now handle when an hstate's size is not equal
> to one of the page table entry sizes.  For instance, it assumes that
> hstates between PMD_SIZE and PUD_SIZE are made up of multiple PMDs
> and prints them as such.
>
> I've tested this on x86 with normal 4k ptes, anonymous huge pages,
> 1G hugetlbfs and 2M hugetlbfs pages.
>
> 1. I'd like to thank Dan Williams for showing me a mirror as I
>    complained about the bozo that introduced 'AnonHugePages'.
>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: linux-mm@kvack.org
> Cc: linux-arch@vger.kernel.org

Acked-by: Vlastimil Babka <vbabka@suse.cz>

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
