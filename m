From: "Michael Kerrisk (man-pages)" <mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 09/14] prctl.2: tfix minor punctuation in SPECULATION_CTRL
 prctls
Date: Wed, 13 May 2020 12:31:06 +0200
Message-ID: <6322d3db-75d0-7539-b61c-252d222f932f@gmail.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
 <1589301419-24459-10-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1589301419-24459-10-git-send-email-Dave.Martin-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-US
Sender: linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>
Cc: mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On 5/12/20 6:36 PM, Dave Martin wrote:
> Fix a few very minor bits of punctuation in
> PR_SET_SPECULATION_CTRL and PR_GET_SPECULATION_CTRL.
> 
> Signed-off-by: Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>

Thanks, Dave. Patch applied.

Cheers,

Michael

> ---
>  man2/prctl.2 | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/man2/prctl.2 b/man2/prctl.2
> index 1e04859..e8eaf95 100644
> --- a/man2/prctl.2
> +++ b/man2/prctl.2
> @@ -1175,13 +1175,13 @@ The return value uses bits 0-3 with the following meaning:
>  .TP
>  .BR PR_SPEC_PRCTL
>  Mitigation can be controlled per thread by
> -.B PR_SET_SPECULATION_CTRL
> +.BR PR_SET_SPECULATION_CTRL .
>  .TP
>  .BR PR_SPEC_ENABLE
>  The speculation feature is enabled, mitigation is disabled.
>  .TP
>  .BR PR_SPEC_DISABLE
> -The speculation feature is disabled, mitigation is enabled
> +The speculation feature is disabled, mitigation is enabled.
>  .TP
>  .BR PR_SPEC_FORCE_DISABLE
>  Same as
> @@ -1228,11 +1228,11 @@ which is one of the following:
>  The speculation feature is enabled, mitigation is disabled.
>  .TP
>  .BR PR_SPEC_DISABLE
> -The speculation feature is disabled, mitigation is enabled
> +The speculation feature is disabled, mitigation is enabled.
>  .TP
>  .BR PR_SPEC_FORCE_DISABLE
>  Same as
> -.B PR_SPEC_DISABLE
> +.BR PR_SPEC_DISABLE ,
>  but cannot be undone.
>  A subsequent
>  .B
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
