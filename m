Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:64229 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932361AbWH1CRP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 27 Aug 2006 22:17:15 -0400
Received: from midway.site ([71.117.233.155]) by xenotime.net for <linux-arch@vger.kernel.org>; Sun, 27 Aug 2006 19:17:14 -0700
Date: Sun, 27 Aug 2006 19:20:30 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH 2/7] rename the provided execve functions to
 kernel_execve
Message-Id: <20060827192030.633cf467.rdunlap@xenotime.net>
In-Reply-To: <20060827215636.091665000@klappe.arndb.de>
References: <20060827214734.252316000@klappe.arndb.de>
	<20060827215636.091665000@klappe.arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Bjoern Steinbrink <B.Steinbrink@gmx.de>, Arjan van de Ven <arjan@infradead.org>, Chase Venters <chase.venters@clientec.com>, Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>, rusty@rustcorp.com.au
List-ID: <linux-arch.vger.kernel.org>

On Sun, 27 Aug 2006 23:47:36 +0200 Arnd Bergmann wrote:

> --- linux-cg.orig/drivers/sbus/char/envctrl.c	2006-08-27 23:36:36.000000000 +0200
> +++ linux-cg/drivers/sbus/char/envctrl.c	2006-08-27 23:36:42.000000000 +0200
> @@ -19,9 +19,6 @@
>   *              Daniele Bellucci <bellucda@tiscali.it>
>   */
>  
> -#define __KERNEL_SYSCALLS__
> -static int errno;
> -
>  #include <linux/module.h>
>  #include <linux/sched.h>
>  #include <linux/kthread.h>
> @@ -982,7 +979,7 @@
>  
>  	inprog = 1;
>  	printk(KERN_CRIT "kenvctrld: WARNING: Shutting down the system now.\n");
> -	if (0 > execve("/sbin/shutdown", argv, envp)) {
> +	if (0 > kernel_execve("/sbin/shutdown", argv, envp)) {
>  		printk(KERN_CRIT "kenvctrld: WARNING: system shutdown failed!\n"); 
>  		inprog = 0;  /* unlikely to succeed, but we could try again */
>  	}

Linux just educated the git mailing list (yesterday) about ordering
of comparisons, so while here, please change the order inside the if()
to be like the others:
	if (kernel_execv(...) < 0)


> Index: linux-cg/include/linux/syscalls.h
> ===================================================================
> --- linux-cg.orig/include/linux/syscalls.h	2006-08-27 23:36:36.000000000 +0200
> +++ linux-cg/include/linux/syscalls.h	2006-08-27 23:36:42.000000000 +0200
> @@ -597,4 +597,6 @@
>  asmlinkage long sys_set_robust_list(struct robust_list_head __user *head,
>  				    size_t len);
>  
> +int kernel_execve(const char *filename, char *const argv[], char *const envp[]);
> +
>  #endif

Question:
All other syscalls (in syscalls.h) return long or unsigned long
or ssize_t etc.  I.e., none of them return int.  Does this one
return int because it's strictly an inside-the-kernel "syscall",
not exposed to userspace?


---
~Randy
