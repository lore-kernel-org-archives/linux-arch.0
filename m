From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] asm-generic/tlb: stub out pmd_free_tlb() if
 __PAGETABLE_PMD_FOLDED
Date: Mon, 14 Oct 2019 10:41:18 -0700
Message-ID: <CAHk-=whLs=TrRzmB9KRLxcPERq0QXPUUkbD8vzKzaDszBcUspg@mail.gmail.com>
References: <20191011121951.nxna6hruuskvdxod@box>
 <20191011223818.7238-1-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191011223818.7238-1-vgupta@synopsys.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nick Piggin <npiggin@gmail.com>, Linux-MM <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, linux-snps-arc@lists.infradead.org, Will Deacon <will@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Oct 11, 2019 at 3:38 PM Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:
>
> This is inine with similar patches for nopud [1] and nop4d [2] cases.

I don't think your patch is wrong, but wouldn't it be easier and
cleaner to just do this instead

    --- a/include/asm-generic/pgtable-nopmd.h
    +++ b/include/asm-generic/pgtable-nopmd.h
    @@ -60,7 +60,7 @@ static inline pmd_t * pmd_offset(pud_t * pud,
unsigned long address)
     static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
     {
     }
    -#define __pmd_free_tlb(tlb, x, a)          do { } while (0)
    +#define pmd_free_tlb(tlb, x, a)            do { } while (0)

     #undef  pmd_addr_end
     #define pmd_addr_end(addr, end)                    (end)

and just rely on the regular "#ifndef pmd_free_tlb" in
include/asm-generic/tlb.h?

Completely untested.

              Linus
