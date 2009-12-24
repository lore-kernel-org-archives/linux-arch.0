From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 05/37] kdb: core for kgdb back end
Date: Thu, 24 Dec 2009 02:28:06 +0100
Message-ID: <87y6ktb1p5.fsf@basil.nowhere.org>
References: <1261603190-5036-1-git-send-email-jason.wessel@windriver.com>
	<1261603190-5036-2-git-send-email-jason.wessel@windriver.com>
	<1261603190-5036-3-git-send-email-jason.wessel@windriver.com>
	<1261603190-5036-4-git-send-email-jason.wessel@windriver.com>
	<1261603190-5036-5-git-send-email-jason.wessel@windriver.com>
	<1261603190-5036-6-git-send-email-jason.wessel@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:33948 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574AbZLXB2K (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 23 Dec 2009 20:28:10 -0500
In-Reply-To: <1261603190-5036-6-git-send-email-jason.wessel@windriver.com> (Jason Wessel's message of "Wed, 23 Dec 2009 15:19:18 -0600")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jason Wessel <jason.wessel@windriver.com>
Cc: linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, kdb@oss.sgi.com, mingo@elte.hu, mort@sgi.com, linux-arch@vger.kernel.org

Jason Wessel <jason.wessel@windriver.com> writes:

I remember going with kaos through all the code
outside kdb/ in his own patch and for nearly all hooks
outside we found some way to eliminate them. 

I think a lot of this is here too.

>  
> +#ifdef	CONFIG_KGDB_KDB
> +/* Like meminfo_proc_show() but without the locks and using kdb_printf() */
> +void kdb_meminfo_proc_show(void)

Are there even any locks in meminfo_proc_show()? I don't see any on a quick look.
Ah or is that only for swap_info? That could be a flag or perhaps that
access can be even made lockless (it looks like it could)

I guess a better way would be to have a kdb specific seq file implementation
and then just use the normal function, instead of copying everything.

>  void get_vmalloc_info(struct vmalloc_info *vmi)
>  {
>  	struct vm_struct *vma;
>  	unsigned long free_area_size;
>  	unsigned long prev_end;
> +#ifdef CONFIG_KGDB_KDB
> +	int get_lock = !KDB_IS_RUNNING();
> +#else
> +#define	get_lock 1
> +#endif
> +

A standard way to do such would be a __get_vmalloc_info with the 
lock in the caller

Didn't read everything in this gigantic patch.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
