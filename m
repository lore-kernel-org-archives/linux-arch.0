From: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCHv4 2/2] kernel: Move arches to use common unaligned access
Date: Tue, 15 Apr 2008 11:01:54 +0100
Message-ID: <17632.1208253714@redhat.com>
References: <1208195405.5721.45.camel@brick>
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1208195405.5721.45.camel@brick>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Russell King <rmk-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>

Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

>  arch/frv/kernel/traps.c           |    7 +-
>  arch/frv/mm/unaligned.c           |  217 -------------------------------------

And arch/frv/mm/Makefile?  It still refers to unaligned.c.

> -#ifndef _ASM_UNALIGNED_H
> -#define _ASM_UNALIGNED_H
> +#ifndef _ASM_FRV_UNALIGNED_H
> +#define _ASM_FRV_UNALIGNED_H

Please don't!

David
---
[PATCH] FRV: Don't refer to arch/frv/mm/unaligned.c once it has been deleted

From: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

arch/frv/mm/unaligned.c should not be mentioned in the local Makefile once the
former has been deleted.

Signed-off-by: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---

 arch/frv/mm/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/arch/frv/mm/Makefile b/arch/frv/mm/Makefile
index fb8b1d8..1bca5ab 100644
--- a/arch/frv/mm/Makefile
+++ b/arch/frv/mm/Makefile
@@ -6,4 +6,4 @@ obj-y := init.o kmap.o
 
 obj-$(CONFIG_MMU) += \
 	pgalloc.o highmem.o fault.o extable.o cache-page.o tlb-flush.o tlb-miss.o \
-	mmu-context.o dma-alloc.o unaligned.o elf-fdpic.o
+	mmu-context.o dma-alloc.o elf-fdpic.o
