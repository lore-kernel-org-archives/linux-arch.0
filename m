From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: Re: [PATCH 03/14] prctl.2: tfix mis-description of thread ID values
 in procfs
Date: Wed, 13 May 2020 10:36:48 +0200
Message-ID: <8e93c847-9fea-26f0-f872-42cf35d5f8f4@gmail.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
 <1589301419-24459-4-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgEMIgv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 May 2020 04:36:51 -0400
In-Reply-To: <1589301419-24459-4-git-send-email-Dave.Martin@arm.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: mtk.manpages@gmail.com, linux-man@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 5/12/20 6:36 PM, Dave Martin wrote:
> Under PR_SET_NAME, the [tid] value seen in procfs as
> /proc/self/task/[tid] is mistakenly described as the name of the
> thread, whereas really the name is on /proc/self/task/[tid]/comm.
> 
> Fix it.

Thanks, Dave. Patch applied.

Cheers,

Michael

> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
>  man2/prctl.2 | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/man2/prctl.2 b/man2/prctl.2
> index a35b748..9736434 100644
> --- a/man2/prctl.2
> +++ b/man2/prctl.2
> @@ -808,8 +808,10 @@ and retrieved using
>  The attribute is likewise accessible via
>  .IR /proc/self/task/[tid]/comm ,
>  where
> -.I tid
> -is the name of the calling thread.
> +.I [tid]
> +is the the thread ID of the calling thread, as returned by
> +.BR gettid (2).
> +.\" prctl PR_GET_NAME
>  .TP
>  .BR PR_GET_NAME " (since Linux 2.6.11)"
>  Return the name of the calling thread,
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
