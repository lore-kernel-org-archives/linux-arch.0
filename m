From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH v8 01/17] h8300: Assembly headers.
Date: Mon, 20 Apr 2015 16:00:34 +0200
Message-ID: <20150420140034.GB9990@distanz.ch>
References: <1429510413-14869-1-git-send-email-ysato@users.sourceforge.jp>
 <1429510413-14869-2-git-send-email-ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1429510413-14869-2-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 2015-04-20 at 08:13:17 +0200, Yoshinori Sato <ysato@users.sourceforge.jp> wrote:
[...]
> diff --git a/arch/h8300/include/asm/pgtable.h b/arch/h8300/include/asm/pgtable.h
> new file mode 100644
> index 0000000..8341db6
> --- /dev/null
> +++ b/arch/h8300/include/asm/pgtable.h
> @@ -0,0 +1,49 @@
> +#ifndef _H8300_PGTABLE_H
> +#define _H8300_PGTABLE_H
> +#include <asm-generic/pgtable-nopud.h>
> +#include <asm-generic/pgtable.h>
> +#define pgtable_cache_init()   do { } while (0)
> +extern void paging_init(void);
> +#define PAGE_NONE		__pgprot(0)    /* these mean nothing to NO_MM */
> +#define PAGE_SHARED		__pgprot(0)    /* these mean nothing to NO_MM */
> +#define PAGE_COPY		__pgprot(0)    /* these mean nothing to NO_MM */
> +#define PAGE_READONLY	__pgprot(0)    /* these mean nothing to NO_MM */
> +#define PAGE_KERNEL		__pgprot(0)    /* these mean nothing to NO_MM */
> +#define __swp_type(x)		(0)
> +#define __swp_offset(x)		(0)
> +#define __swp_entry(typ, off)	((swp_entry_t) { ((typ) | ((off) << 7)) })
> +#define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
> +#define __swp_entry_to_pte(x)	((pte_t) { (x).val })
> +#define kern_addr_valid(addr)	(1)
> +#define pgprot_writecombine(prot)  (prot)
> +#define pgprot_noncached pgprot_writecombine
> +
> +static inline int pte_file(pte_t pte) { return 0; }

No need to define pte_file() anymore, remap_file_pages(2) implementation
was replaced by emulation.

> +#define swapper_pg_dir ((pgd_t *) 0)
> +/*
> + * ZERO_PAGE is a global shared page that is always zero: used
> + * for zero-mapped memory areas etc..
> + */
> +#define ZERO_PAGE(vaddr)	(virt_to_page(0))
> +
> +/*
> + * These would be in other places but having them here reduces the diffs.
> + */
> +extern unsigned int kobjsize(const void *objp);

This prototypes doesn't need to be defined here, it's already in
linux/mm.h which is included where kobjsize is used.

> +extern int is_in_rom(unsigned long);

This function is no longer defined nor used in the rest of the tree, no
need for this prototype as well.

[...]
> diff --git a/arch/h8300/include/asm/sh_bios.h b/arch/h8300/include/asm/sh_bios.h
> new file mode 100644
> index 0000000..9ce513c
> --- /dev/null
> +++ b/arch/h8300/include/asm/sh_bios.h
> @@ -0,0 +1,4 @@
> +#ifndef SH_BIOS_H
> +#define SH_BIOS_H
> +
> +#endif

Why this empty header? Can it be removed?
