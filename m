From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 04/15] arm64: __NR_compat_syscalls fix
Date: Tue, 22 Apr 2014 17:58:15 +0100
Message-ID: <20140422165814.GH10224@arm.com>
References: <1397211951-20549-1-git-send-email-miklos@szeredi.hu>
 <1397211951-20549-5-git-send-email-miklos@szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1397211951-20549-5-git-send-email-miklos@szeredi.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Miklos Szeredi <mszeredi@suse.cz>
List-Id: linux-arch.vger.kernel.org

On Fri, Apr 11, 2014 at 11:25:40AM +0100, Miklos Szeredi wrote:
> From: Miklos Szeredi <mszeredi@suse.cz>
> 
> Signed-off-by: Miklos Szeredi <mszeredi@suse.cz>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/include/asm/unistd32.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
> index bb8eb8a78e67..faa0e1ce59df 100644
> --- a/arch/arm64/include/asm/unistd32.h
> +++ b/arch/arm64/include/asm/unistd32.h
> @@ -404,7 +404,7 @@ __SYSCALL(379, sys_finit_module)
>  __SYSCALL(380, sys_sched_setattr)
>  __SYSCALL(381, sys_sched_getattr)
>  
> -#define __NR_compat_syscalls		379
> +#define __NR_compat_syscalls		382

I picked up this patch, together with a Cc: stable and longer comment.

What's your plan with the other patches? Do you submit them as a series
or would like the arch maintainers to pick them up?

Thanks.

-- 
Catalin
