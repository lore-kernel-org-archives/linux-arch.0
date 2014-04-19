Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:62438 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754851AbaDSSyJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 19 Apr 2014 14:54:09 -0400
Message-ID: <5352C64C.1040204@gmx.de>
Date: Sat, 19 Apr 2014 20:54:04 +0200
From: Helge Deller <deller@gmx.de>
MIME-Version: 1.0
Subject: Re: [PATCH 09/15] parisc: add renameat2 syscall
References: <1397211951-20549-1-git-send-email-miklos@szeredi.hu> <1397211951-20549-10-git-send-email-miklos@szeredi.hu>
In-Reply-To: <1397211951-20549-10-git-send-email-miklos@szeredi.hu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Miklos Szeredi <mszeredi@suse.cz>
Message-ID: <20140419185404.dwmzPPfoEIQ37LKEcwRzOqYzeAH6rG03ZC5J0tCHaDU@z>

On 04/11/2014 12:25 PM, Miklos Szeredi wrote:
> From: Miklos Szeredi <mszeredi@suse.cz>

Thanks Miklos!
 
> Signed-off-by: Miklos Szeredi <mszeredi@suse.cz>
> Cc: Helge Deller <deller@gmx.de>

Acked-by: Helge Deller <deller@gmx.de>

Can you please push it with the other arches.

Helge

> ---
>  arch/parisc/include/uapi/asm/unistd.h | 3 ++-
>  arch/parisc/kernel/syscall_table.S    | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/parisc/include/uapi/asm/unistd.h b/arch/parisc/include/uapi/asm/unistd.h
> index 265ae5190b0a..47e0e21d2272 100644
> --- a/arch/parisc/include/uapi/asm/unistd.h
> +++ b/arch/parisc/include/uapi/asm/unistd.h
> @@ -829,8 +829,9 @@
>  #define __NR_sched_setattr	(__NR_Linux + 334)
>  #define __NR_sched_getattr	(__NR_Linux + 335)
>  #define __NR_utimes		(__NR_Linux + 336)
> +#define __NR_renameat2		(__NR_Linux + 337)
>  
> -#define __NR_Linux_syscalls	(__NR_utimes + 1)
> +#define __NR_Linux_syscalls	(__NR_renameat2 + 1)
>  
>  
>  #define __IGNORE_select		/* newselect */
> diff --git a/arch/parisc/kernel/syscall_table.S b/arch/parisc/kernel/syscall_table.S
> index 80e5dd248934..a595266fdb4d 100644
> --- a/arch/parisc/kernel/syscall_table.S
> +++ b/arch/parisc/kernel/syscall_table.S
> @@ -432,6 +432,7 @@
>  	ENTRY_SAME(sched_setattr)
>  	ENTRY_SAME(sched_getattr)	/* 335 */
>  	ENTRY_COMP(utimes)
> +	ENTRY_COMP(renameat2)
>  
>  	/* Nothing yet */
>  
> 

