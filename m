Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:51746 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753034Ab0DWHVv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 23 Apr 2010 03:21:51 -0400
MIME-Version: 1.0
In-Reply-To: <20100422161223.796194683@suse.de>
References: <20100422160613.723698029@suse.de>
	 <20100422161223.796194683@suse.de>
Date: Fri, 23 Apr 2010 09:21:49 +0200
Message-ID: <x2z10f740e81004230021mb9febf4fjad729ed856ee9e49@mail.gmail.com>
Subject: Re: [patch 07/14] m68k: invoke oom-killer from page fault
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: npiggin@suse.de
Cc: linux-arch@vger.kernel.org, David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, linux-m68k@vger.kernel.org
Message-ID: <20100423072149.Ba0Uon-855vDkzrtztPIiS_K_SoxE3EX1PEt1MwBuR4@z>

On Thu, Apr 22, 2010 at 18:06,  <npiggin@suse.de> wrote:
> As explained in commit 1c0fe6e3bd, we want to call the architecture independent
> oom killer when getting an unexplained OOM from handle_mm_fault, rather than
> simply killing current.
>
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Nick Piggin <npiggin@suse.de>
> ---
> Index: linux-2.6/arch/m68k/mm/fault.c
> ===================================================================
> --- linux-2.6.orig/arch/m68k/mm/fault.c
> +++ linux-2.6/arch/m68k/mm/fault.c
> @@ -180,15 +180,10 @@ good_area:
>  */
>  out_of_memory:
>        up_read(&mm->mmap_sem);
> -       if (is_global_init(current)) {
> -               yield();
> -               down_read(&mm->mmap_sem);
> -               goto survive;
> -       }
> -
> -       printk("VM: killing process %s\n", current->comm);
> -       if (user_mode(regs))
> -               do_group_exit(SIGKILL);
> +       if (!user_mode(regs))
> +               goto no_context;
> +       pagefault_out_of_memory();
> +       return;
>
>  no_context:
>        current->thread.signo = SIGBUS;

Will apply after unintroducing 2 compiler warnings::

diff --git a/arch/m68k/mm/fault.c b/arch/m68k/mm/fault.c
index 0adfcb6..2db6099 100644
--- a/arch/m68k/mm/fault.c
+++ b/arch/m68k/mm/fault.c
@@ -140,7 +140,6 @@ good_area:
 	 * the fault.
 	 */

- survive:
 	fault = handle_mm_fault(mm, vma, address, write ? FAULT_FLAG_WRITE : 0);
 #ifdef DEBUG
 	printk("handle_mm_fault returns %d\n",fault);
@@ -169,7 +168,7 @@ out_of_memory:
 	if (!user_mode(regs))
 		goto no_context;
 	pagefault_out_of_memory();
-	return;
+	return 0;

 no_context:
 	current->thread.signo = SIGBUS;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
