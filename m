Return-Path: <willy@www.linux.org.uk>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37869 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261943AbUCaNKa
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 31 Mar 2004 08:10:30 -0500
Date: Wed, 31 Mar 2004 14:10:27 +0100
From: Matthew Wilcox <willy@debian.org>
Subject: Re: generalize/fix wchan calculation via ELF sections
Message-ID: <20040331131027.GP7709@parcelfarce.linux.theplanet.co.uk>
References: <20040331073539.GX791@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040331073539.GX791@holomorphy.com>
Sender: <willy@www.linux.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Mar 30, 2004 at 11:35:39PM -0800, William Lee Irwin III wrote:
> The following patch generalizes/fixes wchan calculations via ELF sections.
> I've tried to sweep all arches, which is where arch ppl come in.
> 
> Basically, I'm looking to see if I flubbed the patch and may not have
> swept all arches properly, or whether arch maintainers dislike whatever
> aspects of it since it goes poking around their code. Whatever kind of
> feedback may be relevant wrt. methods/cleanliness/etc. is also good.

Well, some nitpicks ...

> Index: sched-2.6.5-rc3/arch/alpha/kernel/process.c
> ===================================================================
> --- sched-2.6.5-rc3.orig/arch/alpha/kernel/process.c	2004-03-29 19:27:07.000000000 -0800
> +++ sched-2.6.5-rc3/arch/alpha/kernel/process.c	2004-03-30 23:25:36.000000000 -0800
> @@ -513,11 +513,6 @@
>  /*
>   * These bracket the sleeping functions..
>   */
> -extern void scheduling_functions_start_here(void);
> -extern void scheduling_functions_end_here(void);
> -#define first_sched	((unsigned long) scheduling_functions_start_here)
> -#define last_sched	((unsigned long) scheduling_functions_end_here)
> -
>  unsigned long
>  get_wchan(struct task_struct *p)
>  {

You really need to remove the comment if you're going to remove the things
the comment refers to.  Though you could make a smaller change by simply..

 /*
  * These bracket the sleeping functions..
  */
-extern void scheduling_functions_start_here(void);
-extern void scheduling_functions_end_here(void);
-#define first_sched  ((unsigned long) scheduling_functions_start_here)
-#define last_sched   ((unsigned long) scheduling_functions_end_here)
+#define first_sched	scheduling_functions_start_here
+#define last_sched	scheduling_functions_end_here

> @@ -536,7 +531,8 @@
>  	 */
>  
>  	pc = thread_saved_pc(p);
> -	if (pc >= first_sched && pc < last_sched) {
> +	if (pc >= scheduling_functions_start_here &&
> +			pc < scheduling_functions_end_here) {
>  		schedule_frame = ((unsigned long *)p->thread_info->pcb.ksp)[6];
>  		return ((unsigned long *)schedule_frame)[12];
>  	}

... then you wouldn't need this hunk.

> Index: sched-2.6.5-rc3/arch/alpha/kernel/semaphore.c
> ===================================================================
> --- sched-2.6.5-rc3.orig/arch/alpha/kernel/semaphore.c	2004-03-29 19:26:17.000000000 -0800
> +++ sched-2.6.5-rc3/arch/alpha/kernel/semaphore.c	2004-03-30 23:25:36.000000000 -0800
> @@ -7,6 +7,7 @@
>  
>  #include <linux/errno.h>
>  #include <linux/sched.h>
> +#include <linux/init.h>
>  
>  /*
>   * This is basically the PPC semaphore scheme ported to use
> @@ -60,7 +61,7 @@
>   * Either form may be used in conjunction with "up()".
>   */
>  
> -void
> +__sched void
>  __down_failed(struct semaphore *sem)
>  {
>  	struct task_struct *tsk = current;

Stylisitically, we prefer

void __init foo() over __init void voo()

so we should probably also prefer

void __sched foo() to __sched void foo()

Other than that, nice job.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
