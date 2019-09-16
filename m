Return-Path: <rppt@kernel.org>
Date: Mon, 16 Sep 2019 16:55:43 +0300
From: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH] arm64: use generic free_initrd_mem()
Message-ID: <20190916135542.GC5196@rapoport-lnx>
References: <1568618488-19055-1-git-send-email-rppt@kernel.org>
 <0ba20aa4-d2dd-2263-6b5f-16a5c8a39f67@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ba20aa4-d2dd-2263-6b5f-16a5c8a39f67@redhat.com>
To: Laura Abbott <labbott@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mike Rapoport <rppt@linux.ibm.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20190916135543.lvAMTA8eHs4b06aP9-70v9MhNxDGv6lXFW0H6NXP0U4@z>

(added linux-arch)

On Mon, Sep 16, 2019 at 08:23:29AM -0400, Laura Abbott wrote:
> On 9/16/19 8:21 AM, Mike Rapoport wrote:
> >From: Mike Rapoport <rppt@linux.ibm.com>
> >
> >arm64 calls memblock_free() for the initrd area in its implementation of
> >free_initrd_mem(), but this call has no actual effect that late in the boot
> >process. By the time initrd is freed, all the reserved memory is managed by
> >the page allocator and the memblock.reserved is unused, so there is no
> >point to update it.
> >
> 
> People like to use memblock for keeping track of memory even if it has no
> actual effect. We made this change explicitly (see 05c58752f9dc ("arm64: To remove
> initrd reserved area entry from memblock") That said, moving to the generic
> APIs would be nice. Maybe we can find another place to update the accounting?

Any other place in arch/arm64 would make it messy because it would have to
duplicate keepinitrd logic.

We could put the memblock_free() in the generic free_initrd_mem() with
something like:

diff --git a/init/initramfs.c b/init/initramfs.c
index c47dad0..403c6a0 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -531,6 +531,10 @@ void __weak free_initrd_mem(unsigned long start,
unsigned long end)
 {
        free_reserved_area((void *)start, (void *)end, POISON_FREE_INITMEM,
                        "initrd");
+
+#ifdef CONFIG_ARCH_KEEP_MEMBLOCK
+       memblock_free(__virt_to_phys(start), end - start);
+#endif
 }
 
 #ifdef CONFIG_KEXEC_CORE


Then powerpc and s390 folks will also be able to track the initrd memory :)

> >Without the memblock_free() call the only difference between arm64 and the
> >generic versions of free_initrd_mem() is the memory poisoning. Switching
> >arm64 to the generic version will enable the poisoning.
> >
> >Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> >---
> >
> >I've boot tested it on qemu and I've checked that kexec works.
> >
> >  arch/arm64/mm/init.c | 8 --------
> >  1 file changed, 8 deletions(-)
> >
> >diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> >index f3c7952..8ad2934 100644
> >--- a/arch/arm64/mm/init.c
> >+++ b/arch/arm64/mm/init.c
> >@@ -567,14 +567,6 @@ void free_initmem(void)
> >  	unmap_kernel_range((u64)__init_begin, (u64)(__init_end - __init_begin));
> >  }
> >-#ifdef CONFIG_BLK_DEV_INITRD
> >-void __init free_initrd_mem(unsigned long start, unsigned long end)
> >-{
> >-	free_reserved_area((void *)start, (void *)end, 0, "initrd");
> >-	memblock_free(__virt_to_phys(start), end - start);
> >-}
> >-#endif
> >-
> >  /*
> >   * Dump out memory limit information on panic.
> >   */
> >
> 

-- 
Sincerely yours,
Mike.
