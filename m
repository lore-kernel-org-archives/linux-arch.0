Return-Path: <SRS0=OnnN=63=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgEMKK2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 May 2020 06:10:28 -0400
Subject: Re: [PATCH 02/14] prctl.2: Add health warning
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
 <1589301419-24459-3-git-send-email-Dave.Martin@arm.com>
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <93c5bfe6-fbbe-93ca-ef9c-91228c99d31b@gmail.com>
Date: Wed, 13 May 2020 12:10:25 +0200
MIME-Version: 1.0
In-Reply-To: <1589301419-24459-3-git-send-email-Dave.Martin@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: mtk.manpages@gmail.com, linux-man@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20200513101025.IH0WEN5WQ9pU4q3R3uIUoW9EbrY8de50RRxFTbwaOkg@z>

Hi Dave,

On 5/12/20 6:36 PM, Dave Martin wrote:
> In reality, almost every prctl interferes with assumptions that the
> compiler and C library / runtime rely on.  prctl() can therefore
> make userspace explode in a variety ways that are likely to be hard
> to debug.
> 
> This is not obvious to the uninitiated, so add a warning.

Patch applied. But see my comments on patch 04. I may want to 
circle back on this patch later, since the wording feels a 
little strong to me (we simply must use prctl for some things, 
and not all of those things break user-space/runtime as far 
as I know). If you have some thoughts on softening the warning,
let me know.

Cheers,

Michael

> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
>  man2/prctl.2 | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/man2/prctl.2 b/man2/prctl.2
> index 7932ada..a35b748 100644
> --- a/man2/prctl.2
> +++ b/man2/prctl.2
> @@ -66,6 +66,11 @@ prctl \- operations on a process or thread
>  manipulates various aspects of the behavior
>  of the calling thread or process.
>  .PP
> +Note that careless use of
> +.BR prctl ()
> +can confuse the userspace run-time environment,
> +so these operations should be used with care (if at all).
> +.PP
>  .BR prctl ()
>  is called with a first argument describing what to do
>  (with values defined in \fI<linux/prctl.h>\fP), and further
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
