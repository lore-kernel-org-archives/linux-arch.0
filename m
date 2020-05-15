From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 00/12] mm: consolidate definitions of page table
 accessors
Date: Fri, 15 May 2020 14:12:11 -0700
Message-ID: <20200515141211.653db07a4e7142107a57cf24@linux-foundation.org>
References: <20200514170327.31389-1-rppt@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <20200514170327.31389-1-rppt@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-m68k@vger.kernel.org, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, Matthew Wilcox <willy@infradead.org>, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, Vincent Chen <deanbo422@gmail.com>, Will Deacon <will@kernel.org>, Greg Ungerer <gerg@linux-m68k.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Brian Cain <bcain@codeaurora.org>, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Ley Foon Tan <ley.foon.tan@intel.com>, Mike Rapoport <rppt@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, Geert
List-Id: linux-arch.vger.kernel.org

On Thu, 14 May 2020 20:03:15 +0300 Mike Rapoport <rppt@kernel.org> wrote:

> The low level page table accessors (pXY_index(), pXY_offset()) are
> duplicated across all architectures and sometimes more than once. For
> instance, we have 31 definition of pgd_offset() for 25 supported
> architectures.
> 
> Most of these definitions are actually identical and typically it boils
> down to, e.g. 
> 
> static inline unsigned long pmd_index(unsigned long address)
> {
>         return (address >> PMD_SHIFT) & (PTRS_PER_PMD - 1);
> }
> 
> static inline pmd_t *pmd_offset(pud_t *pud, unsigned long address)
> {
>         return (pmd_t *)pud_page_vaddr(*pud) + pmd_index(address);
> }
> 
> These definitions can be shared among 90% of the arches provided XYZ_SHIFT,
> PTRS_PER_XYZ and xyz_page_vaddr() are defined.
> 
> For architectures that really need a custom version there is always
> possibility to override the generic version with the usual ifdefs magic.
> 
> These patches introduce include/linux/pgtable.h that replaces
> include/asm-generic/pgtable.h and add the definitions of the page table
> accessors to the new header.

hm,

>  712 files changed, 684 insertions(+), 2021 deletions(-)

big!

There's a lot of stuff going on at present (I suspect everyone is
sitting at home coding up a storm).  However this all merged up fairly
cleanly, haven't tried compiling it yet.
