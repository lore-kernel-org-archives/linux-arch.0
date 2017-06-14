From: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [HELP-NEEDED, PATCH 0/3] Do not loose dirty bit on THP pages
Date: Wed, 14 Jun 2017 19:00:47 +0200
Message-ID: <d589ad0a-d5d4-927a-597c-4b094285d4b1@suse.cz>
References: <20170614135143.25068-1-kirill.shutemov@linux.intel.com>
 <eed279c6-bf61-f2f3-c9f2-d9a94568e2e3@linux.vnet.ibm.com>
 <20170614165513.GD17632@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20170614165513.GD17632@arm.com>
Content-Language: en-US
Sender: owner-linux-mm@kvack.org
To: Will Deacon <will.deacon@arm.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Ralf Baechle <ralf@linux-mips.org>, "David S. Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com
List-Id: linux-arch.vger.kernel.org

On 06/14/2017 06:55 PM, Will Deacon wrote:
>>
>> May be we should relook at pmd PTE udpate interface. We really need an
>> interface that can update pmd entries such that we don't clear it in
>> between. IMHO, we can avoid the pmdp_invalidate() completely, if we can
>> switch from a pmd PTE entry to a pointer to PTE page (pgtable_t). We also
>> need this interface to avoid the madvise race fixed by
> 
> There's a good chance I'm not following your suggestion here, but it's
> probably worth me pointing out that swizzling a page table entry from a
> block mapping (e.g. a huge page mapped at the PMD level) to a table entry
> (e.g. a pointer to a page of PTEs) can lead to all sorts of horrible
> problems on ARM, including amalgamation of TLB entries and fatal aborts.

AFAIK some AMD x86_64 CPU's had the same problem and generated MCE's,
and on Intel there are some restrictions when you can do that. See the
large comment in __split_huge_pmd_locked().

> So we really need to go via an invalid entry, with appropriate TLB
> invalidation before installing the new entry.
> 
> Will
> 

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
