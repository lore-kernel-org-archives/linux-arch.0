From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH 1/2] mm,thp: refactor generic deposit/withdraw routines
 for wider usage
Date: Thu, 11 Feb 2016 16:23:33 +0530
Message-ID: <56BC682D.6070808@synopsys.com>
References: <1455182907-15445-1-git-send-email-vgupta@synopsys.com>
 <1455182907-15445-2-git-send-email-vgupta@synopsys.com>
 <20160211112223.0acc8237@mschwide>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20160211112223.0acc8237@mschwide>
Sender: owner-linux-mm@kvack.org
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, "David S. Miller" <davem@davemloft.net>, Alex Thorlton <athorlton@sgi.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Andrea Arcangeli <aarcange@redhat.com>
List-Id: linux-arch.vger.kernel.org

On Thursday 11 February 2016 03:52 PM, Martin Schwidefsky wrote:
> On Thu, 11 Feb 2016 14:58:26 +0530
> Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:
> 
>> Generic pgtable_trans_huge_deposit()/pgtable_trans_huge_withdraw()
>> assume pgtable_t to be struct page * which is not true for all arches.
>> Thus arc, s390, sparch end up with their own copies despite no special
>> hardware requirements (unlike powerpc).
> 
> s390 does have a special hardware requirement. pgtable_t is an address
> for a 2K block of memory. It is *not* equivalent to a struct page *
> which refers to a 4K block of memory. That has been the whole point
> to introduce pgtable_t.

Actually my reference to hardware requirement was more like powerpc style save a
hash value some where etc.

Now pgtable_t need not be struct page * even if the actual sizes are same - e.g.
in ARC port I kept pgtable_t as pte_t * simply to avoid a few page_address() calls
in mm code (you could argue that is was a micro-optimization, anyways..)

So given I know nothing about s390 MMU internals, I still think you can switch to
the update generic version despite 2K vs. 4K. Agree ?

>> It seems massaging the code a bit can make it reusbale.
> 
> Imho the new code for asm-generic looks fine, as long as the override
> with __HAVE_ARCH_PGTABLE_DEPOSIT/__HAVE_ARCH_PGTABLE_WITHDRAW continues
> to work I do not mind.


--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
