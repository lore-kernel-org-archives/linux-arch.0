From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCHv4 28/33] x86/mm: add support of additional page table
 level during early boot
Date: Mon, 6 Mar 2017 15:05:49 -0500
Message-ID: <7e78a76a-f5e8-bb60-e5be-a91a84faa1f9@oracle.com>
References: <20170306135357.3124-1-kirill.shutemov@linux.intel.com>
 <20170306135357.3124-29-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20170306135357.3124-29-kirill.shutemov@linux.intel.com>
Sender: owner-linux-mm@kvack.org
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, xen-devel <xen-devel@lists.xen.org>, Juergen Gross <jgross@suse.com>
List-Id: linux-arch.vger.kernel.org


> diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/p=
gtable_64.h
> index 9991224f6238..c9e41f1599dd 100644
> --- a/arch/x86/include/asm/pgtable_64.h
> +++ b/arch/x86/include/asm/pgtable_64.h
> @@ -14,15 +14,17 @@
>  #include <linux/bitops.h>
>  #include <linux/threads.h>
> =20
> +extern p4d_t level4_kernel_pgt[512];
> +extern p4d_t level4_ident_pgt[512];
>  extern pud_t level3_kernel_pgt[512];
>  extern pud_t level3_ident_pgt[512];
>  extern pmd_t level2_kernel_pgt[512];
>  extern pmd_t level2_fixmap_pgt[512];
>  extern pmd_t level2_ident_pgt[512];
>  extern pte_t level1_fixmap_pgt[512];
> -extern pgd_t init_level4_pgt[];
> +extern pgd_t init_top_pgt[];
> =20
> -#define swapper_pg_dir init_level4_pgt
> +#define swapper_pg_dir init_top_pgt
> =20
>  extern void paging_init(void);
> =20


This means you also need


diff --git a/arch/x86/xen/xen-pvh.S b/arch/x86/xen/xen-pvh.S
index 5e24671..e1a5fbe 100644
--- a/arch/x86/xen/xen-pvh.S
+++ b/arch/x86/xen/xen-pvh.S
@@ -87,7 +87,7 @@ ENTRY(pvh_start_xen)
        wrmsr
=20
        /* Enable pre-constructed page tables. */
-       mov $_pa(init_level4_pgt), %eax
+       mov $_pa(init_top_pgt), %eax
        mov %eax, %cr3
        mov $(X86_CR0_PG | X86_CR0_PE), %eax
        mov %eax, %cr0


-boris

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
