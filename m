From: Konstantin Khlebnikov <koct9i@gmail.com>
Subject: Re: [PATCH 0/3] mm/mmap.c: don't unmap the overlapping VMA(s)
Date: Sun, 3 Apr 2016 08:52:35 +0300
Message-ID: <CALYGNiNosCEJ7T2wvAmsAOEN0n4O=rDtzOV=Y7iYa60T49U7rg@mail.gmail.com>
References: <1459624654-7955-1-git-send-email-kwapulinski.piotr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:34093 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995AbcDCFwi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 3 Apr 2016 01:52:38 -0400
In-Reply-To: <1459624654-7955-1-git-send-email-kwapulinski.piotr@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Piotr Kwapulinski <kwapulinski.piotr@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Michael Kerrisk-manpages <mtk.manpages@gmail.com>, cmetcalf@mellanox.com, Arnd Bergmann <arnd@arndb.de>, Al Viro <viro@zeniv.linux.org.uk>, mszeredi@suse.cz, Davidlohr Bueso <dave@stgolabs.net>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Vlastimil Babka <vbabka@suse.cz>, Ingo Molnar <mingo@kernel.org>, dan.j.williams@intel.com, Dave Hansen <dave.hansen@linux.intel.com>, Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>, xiexiuqi@huawei.com, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Oleg Nesterov <oleg@redhat.com>, Chen Gang <gang.chen.5i5j@gmail.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, David Rientjes <rientjes@google.com>, denc716@gmail.com, toshi.kani@hpe.com, ldufour@linux.vnet.ibm.com, kuleshovmail@gmail.com, Linux

On Sat, Apr 2, 2016 at 10:17 PM, Piotr Kwapulinski
<kwapulinski.piotr@gmail.com> wrote:
> Currently the mmap(MAP_FIXED) discards the overlapping part of the
> existing VMA(s).
> Introduce the new MAP_DONTUNMAP flag which forces the mmap to fail
> with ENOMEM whenever the overlapping occurs and MAP_FIXED is set.
> No existing mapping(s) is discarded.

How userspace is supposed to use this and handle failure?

For now you can get the same behavior in couple syscalls:
mmap without MAP_FIXED if resulting address differs unmmap and handle error.
Twice slower but this is error-path so you anyway have to some extra actions.

> The implementation tests the MAP_DONTUNMAP flag right before unmapping
> the VMA. The tile arch is the dependency of mmap_flags.
>
> I did the isolated tests and also tested it with Gentoo full
> installation.
>
> Signed-off-by: Piotr Kwapulinski <kwapulinski.piotr@gmail.com>
> ---
>  arch/tile/mm/elf.c                     |  1 +
>  include/linux/mm.h                     |  3 ++-
>  include/uapi/asm-generic/mman-common.h |  1 +
>  mm/mmap.c                              | 10 +++++++---
>  4 files changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/arch/tile/mm/elf.c b/arch/tile/mm/elf.c
> index 6225cc9..dae4b33 100644
> --- a/arch/tile/mm/elf.c
> +++ b/arch/tile/mm/elf.c
> @@ -142,6 +142,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm,
>         if (!retval) {
>                 unsigned long addr = MEM_USER_INTRPT;
>                 addr = mmap_region(NULL, addr, INTRPT_SIZE,
> +                                  MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE,
>                                    VM_READ|VM_EXEC|
>                                    VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC, 0);
>                 if (addr > (unsigned long) -PAGE_SIZE)
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ed6407d..31dcdfb 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2048,7 +2048,8 @@ extern int install_special_mapping(struct mm_struct *mm,
>  extern unsigned long get_unmapped_area(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
>
>  extern unsigned long mmap_region(struct file *file, unsigned long addr,
> -       unsigned long len, vm_flags_t vm_flags, unsigned long pgoff);
> +       unsigned long len, unsigned long mmap_flags,
> +       vm_flags_t vm_flags, unsigned long pgoff);
>  extern unsigned long do_mmap(struct file *file, unsigned long addr,
>         unsigned long len, unsigned long prot, unsigned long flags,
>         vm_flags_t vm_flags, unsigned long pgoff, unsigned long *populate);
> diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
> index 5827438..3655be3 100644
> --- a/include/uapi/asm-generic/mman-common.h
> +++ b/include/uapi/asm-generic/mman-common.h
> @@ -19,6 +19,7 @@
>  #define MAP_TYPE       0x0f            /* Mask for type of mapping */
>  #define MAP_FIXED      0x10            /* Interpret addr exactly */
>  #define MAP_ANONYMOUS  0x20            /* don't use a file */
> +#define MAP_DONTUNMAP  0x40            /* don't unmap overlapping VMA */
>  #ifdef CONFIG_MMAP_ALLOW_UNINITIALIZED
>  # define MAP_UNINITIALIZED 0x4000000   /* For anonymous mmap, memory could be uninitialized */
>  #else
> diff --git a/mm/mmap.c b/mm/mmap.c
> index bd2e1a53..ab429c3 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1286,7 +1286,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>                         vm_flags |= VM_NORESERVE;
>         }
>
> -       addr = mmap_region(file, addr, len, vm_flags, pgoff);
> +       addr = mmap_region(file, addr, len, flags, vm_flags, pgoff);
>         if (!IS_ERR_VALUE(addr) &&
>             ((vm_flags & VM_LOCKED) ||
>              (flags & (MAP_POPULATE | MAP_NONBLOCK)) == MAP_POPULATE))
> @@ -1422,7 +1422,8 @@ static inline int accountable_mapping(struct file *file, vm_flags_t vm_flags)
>  }
>
>  unsigned long mmap_region(struct file *file, unsigned long addr,
> -               unsigned long len, vm_flags_t vm_flags, unsigned long pgoff)
> +               unsigned long len, unsigned long mmap_flags,
> +               vm_flags_t vm_flags, unsigned long pgoff)
>  {
>         struct mm_struct *mm = current->mm;
>         struct vm_area_struct *vma, *prev;
> @@ -1448,7 +1449,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>         /* Clear old maps */
>         while (find_vma_links(mm, addr, addr + len, &prev, &rb_link,
>                               &rb_parent)) {
> -               if (do_munmap(mm, addr, len))
> +               const bool dont_unmap =
> +                               (mmap_flags & (MAP_DONTUNMAP | MAP_FIXED))
> +                               == (MAP_DONTUNMAP | MAP_FIXED);
> +               if (dont_unmap || do_munmap(mm, addr, len))
>                         return -ENOMEM;
>         }
>
> --
> 2.7.4
>
