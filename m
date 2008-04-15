Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:54769 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755225AbYDOKCI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 15 Apr 2008 06:02:08 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1208195405.5721.45.camel@brick>
References: <1208195405.5721.45.camel@brick>
Subject: Re: [PATCHv4 2/2] kernel: Move arches to use common unaligned access
Date: Tue, 15 Apr 2008 11:01:54 +0100
Message-ID: <17632.1208253714@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: dhowells@redhat.com, Russell King <rmk@arm.linux.org.uk>, linux-arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20080415100154.-2R2Sc5L-V1Dr7gVzF5-vAuzZ3VSagucG2iBgXFfGJg@z>

Harvey Harrison <harvey.harrison@gmail.com> wrote:

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

From: David Howells <dhowells@redhat.com>

arch/frv/mm/unaligned.c should not be mentioned in the local Makefile once the
former has been deleted.

Signed-off-by: David Howells <dhowells@redhat.com>
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
