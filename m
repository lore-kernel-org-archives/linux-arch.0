From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 0/7] 5-level paging: prepare generic code
Date: Wed, 8 Mar 2017 15:25:01 +0100
Message-ID: <20170308142501.GB11034@dhcp22.suse.cz>
References: <20170306204514.1852-1-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20170306204514.1852-1-kirill.shutemov@linux.intel.com>
Sender: owner-linux-mm@kvack.org
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Btw. my build test machinery has reported this:
microblaze/allnoconfig
In file included from ./arch/microblaze/include/asm/pgtable.h:550:0,
                 from ./include/linux/mm.h:68,
                 from ./arch/microblaze/include/asm/io.h:17,
                 from ./include/linux/io.h:25,
                 from ./include/linux/irq.h:24,
                 from ./include/asm-generic/hardirq.h:12,
                 from ./arch/microblaze/include/asm/hardirq.h:1,
                 from ./include/linux/hardirq.h:8,
                 from ./include/linux/interrupt.h:12,
                 from ./include/linux/kernel_stat.h:8,
                 from arch/microblaze/kernel/asm-offsets.c:14:
./include/asm-generic/pgtable.h:886:32: error: unknown type name 'p4d_t'
 static inline int p4d_set_huge(p4d_t *p4d, phys_addr_t addr, pgprot_t prot)
                                ^
./include/asm-generic/pgtable.h:898:34: error: unknown type name 'p4d_t'
 static inline int p4d_clear_huge(p4d_t *p4d)
                                  ^
In file included from ./arch/microblaze/include/asm/io.h:17:0,
                 from ./include/linux/io.h:25,
                 from ./include/linux/irq.h:24,
                 from ./include/asm-generic/hardirq.h:12,
                 from ./arch/microblaze/include/asm/hardirq.h:1,
                 from ./include/linux/hardirq.h:8,
                 from ./include/linux/interrupt.h:12,
                 from ./include/linux/kernel_stat.h:8,
                 from arch/microblaze/kernel/asm-offsets.c:14:
./include/linux/mm.h:1580:39: error: unknown type name 'p4d_t'
 int __pud_alloc(struct mm_struct *mm, p4d_t *p4d, unsigned long address);
                                       ^
In file included from ./arch/microblaze/include/asm/io.h:17:0,
                 from ./include/linux/io.h:25,
                 from ./include/linux/irq.h:24,
                 from ./include/asm-generic/hardirq.h:12,
                 from ./arch/microblaze/include/asm/hardirq.h:1,
                 from ./include/linux/hardirq.h:8,
                 from ./include/linux/interrupt.h:12,
                 from ./include/linux/kernel_stat.h:8,
                 from arch/microblaze/kernel/asm-offsets.c:14:
./include/linux/mm.h:2409:1: error: unknown type name 'p4d_t'
 p4d_t *vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node);
 ^
./include/linux/mm.h:2410:29: error: unknown type name 'p4d_t'
 pud_t *vmemmap_pud_populate(p4d_t *p4d, unsigned long addr, int node);
                             ^
make[1]: *** [arch/microblaze/kernel/asm-offsets.s] Error 1
make: *** [prepare0] Error 2
-- 
Michal Hocko
SUSE Labs

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
