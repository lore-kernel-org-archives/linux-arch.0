From: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 09/15] parisc: add renameat2 syscall
Date: Sat, 19 Apr 2014 20:54:04 +0200
Message-ID: <5352C64C.1040204@gmx.de>
References: <1397211951-20549-1-git-send-email-miklos@szeredi.hu> <1397211951-20549-10-git-send-email-miklos@szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1397211951-20549-10-git-send-email-miklos@szeredi.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Miklos Szeredi <miklos@szeredi.hu>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Miklos Szeredi <mszeredi@suse.cz>
List-Id: linux-arch.vger.kernel.org

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
