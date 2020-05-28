From: "Michael Kerrisk (man-pages)" <mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/6] prctl.2: ffix use literal hyphens when referencing
 kernel docs
Date: Thu, 28 May 2020 08:05:02 +0200
Message-ID: <43a7fb5b-7626-0f05-a13f-a4d35eb3289f@gmail.com>
References: <1590614258-24728-1-git-send-email-Dave.Martin@arm.com>
 <1590614258-24728-2-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1590614258-24728-2-git-send-email-Dave.Martin-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-US
Sender: linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>
Cc: mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On 5/27/20 11:17 PM, Dave Martin wrote:
> There is one case of a cross-reference to a kernel documentation
> filename that uses unescaped hyphens.
> 
> To avoid misrendering, escape these as \- similarly to other
> instances.
> 
> Signed-off-by: Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>
> ---
>  man2/prctl.2 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/man2/prctl.2 b/man2/prctl.2
> index 968a75a..dc99218 100644
> --- a/man2/prctl.2
> +++ b/man2/prctl.2
> @@ -1261,7 +1261,7 @@ This parameter may enforce a read-only policy which will result in the
>  call failing with the error
>  .BR ENXIO .
>  For further details, see the kernel source file
> -.IR Documentation/admin-guide/kernel-parameters.txt .
> +.IR Documentation/admin\-guide/kernel\-parameters.txt .
>  .\"
>  .\" prctl PR_TASK_PERF_EVENTS_DISABLE
>  .TP

Thanks, Dave. Applied.

Cheers,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
