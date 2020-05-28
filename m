Return-Path: <SRS0=7GPW=7K=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbgE1GFI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 May 2020 02:05:08 -0400
Subject: Re: [PATCH v2 1/6] prctl.2: ffix use literal hyphens when referencing
 kernel docs
References: <1590614258-24728-1-git-send-email-Dave.Martin@arm.com>
 <1590614258-24728-2-git-send-email-Dave.Martin@arm.com>
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <43a7fb5b-7626-0f05-a13f-a4d35eb3289f@gmail.com>
Date: Thu, 28 May 2020 08:05:02 +0200
MIME-Version: 1.0
In-Reply-To: <1590614258-24728-2-git-send-email-Dave.Martin@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: mtk.manpages@gmail.com, linux-man@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20200528060502.vAePya2yjiJMDwvMLS1gy5Xln3tfXsGMoc5okgYjNAE@z>

On 5/27/20 11:17 PM, Dave Martin wrote:
> There is one case of a cross-reference to a kernel documentation
> filename that uses unescaped hyphens.
> 
> To avoid misrendering, escape these as \- similarly to other
> instances.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
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
