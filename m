From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [patch 07/14] m68k: invoke oom-killer from page fault
Date: Fri, 23 Apr 2010 09:21:49 +0200
Message-ID: <x2z10f740e81004230021mb9febf4fjad729ed856ee9e49@mail.gmail.com>
References: <20100422160613.723698029@suse.de>
	 <20100422161223.796194683@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <20100422161223.796194683@suse.de>
Sender: linux-m68k-owner@vger.kernel.org
To: npiggin@suse.de
Cc: linux-arch@vger.kernel.org, David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, linux-m68k@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, Apr 22, 2010 at 18:06,  <npiggin@suse.de> wrote:
> As explained in commit 1c0fe6e3bd, we want to call the architecture i=
ndependent
> oom killer when getting an unexplained OOM from handle_mm_fault, rath=
er than
> simply killing current.
>
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Nick Piggin <npiggin@suse.de>
> ---
> Index: linux-2.6/arch/m68k/mm/fault.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/arch/m68k/mm/fault.c
> +++ linux-2.6/arch/m68k/mm/fault.c
> @@ -180,15 +180,10 @@ good_area:
> =C2=A0*/
> =C2=A0out_of_memory:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0up_read(&mm->mmap_sem);
> - =C2=A0 =C2=A0 =C2=A0 if (is_global_init(current)) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 yield();
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 down_read(&mm->mma=
p_sem);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto survive;
> - =C2=A0 =C2=A0 =C2=A0 }
> -
> - =C2=A0 =C2=A0 =C2=A0 printk("VM: killing process %s\n", current->co=
mm);
> - =C2=A0 =C2=A0 =C2=A0 if (user_mode(regs))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do_group_exit(SIGK=
ILL);
> + =C2=A0 =C2=A0 =C2=A0 if (!user_mode(regs))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto no_context;
> + =C2=A0 =C2=A0 =C2=A0 pagefault_out_of_memory();
> + =C2=A0 =C2=A0 =C2=A0 return;
>
> =C2=A0no_context:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0current->thread.signo =3D SIGBUS;

Will apply after unintroducing 2 compiler warnings::

diff --git a/arch/m68k/mm/fault.c b/arch/m68k/mm/fault.c
index 0adfcb6..2db6099 100644
--- a/arch/m68k/mm/fault.c
+++ b/arch/m68k/mm/fault.c
@@ -140,7 +140,6 @@ good_area:
 	 * the fault.
 	 */

- survive:
 	fault =3D handle_mm_fault(mm, vma, address, write ? FAULT_FLAG_WRITE =
: 0);
 #ifdef DEBUG
 	printk("handle_mm_fault returns %d\n",fault);
@@ -169,7 +168,7 @@ out_of_memory:
 	if (!user_mode(regs))
 		goto no_context;
 	pagefault_out_of_memory();
-	return;
+	return 0;

 no_context:
 	current->thread.signo =3D SIGBUS;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
							    -- Linus Torvalds
