From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCHv2 1/3] x86/mm: Provide pmdp_establish() helper
Date: Wed, 21 Jun 2017 08:49:03 -0700
Message-ID: <1af1738a-88a7-987c-eca7-2118d66514e1@synopsys.com>
References: <20170615145224.66200-1-kirill.shutemov@linux.intel.com>
 <20170615145224.66200-2-kirill.shutemov@linux.intel.com>
 <20170619152228.GE3024@e104818-lin.cambridge.arm.com>
 <20170619160005.wgj4nymtj2nntfll@node.shutemov.name>
 <20170619170911.GF3024@e104818-lin.cambridge.arm.com>
 <20170619215210.2crwjou3sfdcj73d@node.shutemov.name>
 <20170620155438.GC21383@e104818-lin.cambridge.arm.com>
 <20170621095303.q5fqt5a3ao5smko6@node.shutemov.name>
 <20170621112702.GC10220@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20170621112702.GC10220@e104818-lin.cambridge.arm.com>
Content-Language: en-US
Sender: owner-linux-mm@kvack.org
To: Catalin Marinas <catalin.marinas@arm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, Ralf Baechle <ralf@linux-mips.org>, "David S. Miller" <davem@davemloft.net>, "Aneesh
 Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

On 06/21/2017 04:27 AM, Catalin Marinas wrote:
> On Wed, Jun 21, 2017 at 12:53:03PM +0300, Kirill A. Shutemov wrote:
>>>>>>> On Thu, Jun 15, 2017 at 05:52:22PM +0300, Kirill A. Shutemov wrote:
>>>>>>>> We need an atomic way to setup pmd page table entry, avoiding races with
>>>>>>>> CPU setting dirty/accessed bits. This is required to implement
>>>>>>>> pmdp_invalidate() that doesn't loose these bits.
> [...]
>> Any chance you could help me with arm too?
> On arm (ARMv7 with LPAE) we don't have hardware updates of the
> access/dirty bits, so a generic implementation would suffice. I didn't
> find one in your patches, so here's an untested version:
>
> static inline pmd_t pmdp_establish(struct mm_struct *mm, unsigned long address,
> 				   pmd_t *pmdp, pmd_t pmd)
> {
> 	pmd_t old_pmd = *pmdp;
> 	set_pmd_at(mm, address, pmdp, pmd);
> 	return old_pmd;
> }

So it seems the discussions have settled down and pmdp_establish() can be 
implemented in generic way as above and it will suffice if arch doesn't have a 
special need. It would be nice to add the comment above generic version that it 
only needs to be implemented if hardware sets the accessed/dirty bits !

Then nothing special is needed for ARC - right ?

-Vineet

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
