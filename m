Return-Path: <SRS0=OnnN=63=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732174AbgEMIaZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 May 2020 04:30:25 -0400
Subject: Re: [PATCH 01/14] prctl.2: tfix clarify that prctl can apply to
 threads
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
 <1589301419-24459-2-git-send-email-Dave.Martin@arm.com>
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <d15dd1a7-4358-f08c-9149-4a70a7c339ee@gmail.com>
Date: Wed, 13 May 2020 10:30:20 +0200
MIME-Version: 1.0
In-Reply-To: <1589301419-24459-2-git-send-email-Dave.Martin@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: mtk.manpages@gmail.com, linux-man@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20200513083020.QLJKxJ-OEYjk9j3xaA3c6KY6XVahjyIm-SOV4YlUuVY@z>

On 5/12/20 6:36 PM, Dave Martin wrote:
> The current synopsis for prctl(2) misleadingly claims that prctl
> operates on a process.  Rather, some (in fact, most) prctls operate
> on a thread.
> 
> The wording probably dates back to the old days when Linux didn't
> really have threads at all.
> 
> Reword as appropriate.

Thanks, Dave. Patch applied.

Cheers,

Michael

> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
>  man2/prctl.2 | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/man2/prctl.2 b/man2/prctl.2
> index 7a5af76..7932ada 100644
> --- a/man2/prctl.2
> +++ b/man2/prctl.2
> @@ -53,7 +53,7 @@
>  .\"
>  .TH PRCTL 2 2020-04-11 "Linux" "Linux Programmer's Manual"
>  .SH NAME
> -prctl \- operations on a process
> +prctl \- operations on a process or thread
>  .SH SYNOPSIS
>  .nf
>  .B #include <sys/prctl.h>
> @@ -63,6 +63,10 @@ prctl \- operations on a process
>  .fi
>  .SH DESCRIPTION
>  .BR prctl ()
> +manipulates various aspects of the behavior
> +of the calling thread or process.
> +.PP
> +.BR prctl ()
>  is called with a first argument describing what to do
>  (with values defined in \fI<linux/prctl.h>\fP), and further
>  arguments with a significance depending on the first one.
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
