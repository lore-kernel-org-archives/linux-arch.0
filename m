Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34485 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753906AbdCFUt5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Mar 2017 15:49:57 -0500
Received: by mail-wr0-f195.google.com with SMTP id u48so23278845wrc.1
        for <linux-arch@vger.kernel.org>; Mon, 06 Mar 2017 12:49:22 -0800 (PST)
Date: Mon, 6 Mar 2017 23:23:39 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCHv4 28/33] x86/mm: add support of additional page table
 level during early boot
Message-ID: <20170306202339.GC27719@node.shutemov.name>
References: <20170306135357.3124-1-kirill.shutemov@linux.intel.com>
 <20170306135357.3124-29-kirill.shutemov@linux.intel.com>
 <7e78a76a-f5e8-bb60-e5be-a91a84faa1f9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e78a76a-f5e8-bb60-e5be-a91a84faa1f9@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, xen-devel <xen-devel@lists.xen.org>, Juergen Gross <jgross@suse.com>
Message-ID: <20170306202339.qrtu33gGtCK8iR2wRRT__ZQbI_xHPskiIYqVwfm67rY@z>

On Mon, Mar 06, 2017 at 03:05:49PM -0500, Boris Ostrovsky wrote:
> 
> > diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
> > index 9991224f6238..c9e41f1599dd 100644
> > --- a/arch/x86/include/asm/pgtable_64.h
> > +++ b/arch/x86/include/asm/pgtable_64.h
> > @@ -14,15 +14,17 @@
> >  #include <linux/bitops.h>
> >  #include <linux/threads.h>
> >  
> > +extern p4d_t level4_kernel_pgt[512];
> > +extern p4d_t level4_ident_pgt[512];
> >  extern pud_t level3_kernel_pgt[512];
> >  extern pud_t level3_ident_pgt[512];
> >  extern pmd_t level2_kernel_pgt[512];
> >  extern pmd_t level2_fixmap_pgt[512];
> >  extern pmd_t level2_ident_pgt[512];
> >  extern pte_t level1_fixmap_pgt[512];
> > -extern pgd_t init_level4_pgt[];
> > +extern pgd_t init_top_pgt[];
> >  
> > -#define swapper_pg_dir init_level4_pgt
> > +#define swapper_pg_dir init_top_pgt
> >  
> >  extern void paging_init(void);
> >  
> 
> 
> This means you also need
> 
> 
> diff --git a/arch/x86/xen/xen-pvh.S b/arch/x86/xen/xen-pvh.S
> index 5e24671..e1a5fbe 100644
> --- a/arch/x86/xen/xen-pvh.S
> +++ b/arch/x86/xen/xen-pvh.S
> @@ -87,7 +87,7 @@ ENTRY(pvh_start_xen)
>         wrmsr
>  
>         /* Enable pre-constructed page tables. */
> -       mov $_pa(init_level4_pgt), %eax
> +       mov $_pa(init_top_pgt), %eax
>         mov %eax, %cr3
>         mov $(X86_CR0_PG | X86_CR0_PE), %eax
>         mov %eax, %cr0
> 
> 

Ah. Thanks. I've missed that.

The fix is folded.

-- 
 Kirill A. Shutemov
