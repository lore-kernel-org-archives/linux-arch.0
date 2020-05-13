Return-Path: <SRS0=OnnN=63=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732496AbgEMLVR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 May 2020 07:21:17 -0400
Subject: Re: [PATCH 10/14] prctl.2: Add PR_SPEC_INDIRECT_BRANCH for
 SPECULATION_CTRL prctls
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
 <1589301419-24459-11-git-send-email-Dave.Martin@arm.com>
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <bd548916-11c8-a53f-67b5-876c79088258@gmail.com>
Date: Wed, 13 May 2020 13:21:12 +0200
MIME-Version: 1.0
In-Reply-To: <1589301419-24459-11-git-send-email-Dave.Martin@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: mtk.manpages@gmail.com, linux-man@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tim Chen <tim.c.chen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>
Message-ID: <20200513112112.VTQ8LiUwuhmlu0UXBMlftTapxLGh32zjYaKN5ra68oc@z>

Hello Dave,

On 5/12/20 6:36 PM, Dave Martin wrote:
> Add the PR_SPEC_INDIRECT_BRANCH "misfeature" added in Linux 4.20
> for PR_SET_SPECULATION_CTRL and PR_GET_SPECULATION_CTRL.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>

Thanks. Patch applied, but not yet pushed while I wait to see if any
Review/Ack arrives.

Also, could you please check the tweaks I note below.

> ---
>  man2/prctl.2 | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/man2/prctl.2 b/man2/prctl.2
> index e8eaf95..66417cf 100644
> --- a/man2/prctl.2
> +++ b/man2/prctl.2
> @@ -1213,11 +1213,20 @@ arguments must be specified as 0; otherwise the call fails with the error
>  .\" commit 356e4bfff2c5489e016fdb925adbf12a1e3950ee
>  Sets the state of the speculation misfeature specified in
>  .IR arg2 .
> -Currently, the only permitted value for this argument is
> +Currently, this argument must be one of:
> +.RS
> +.TP
>  .B PR_SPEC_STORE_BYPASS
> -(otherwise the call fails with the error
> +speculative store bypass control, or

s/speculative/enable speculative/

> +.\" commit 9137bb27e60e554dab694eafa4cca241fa3a694f
> +.TP
> +.BR PR_SPEC_INDIRECT_BRANCH " (since Linux 4.20)"
> +indirect branch speculation control.

s/indirect/enable indirect/

> +.RE
> +.IP
> +(Otherwise the call fails with the error
>  .BR ENODEV ).
> -This setting is a per-thread attribute.
> +These settings are per-thread attributes.
>  The
>  .IR arg3
>  argument is used to hand in the control value,
> @@ -1235,13 +1244,16 @@ Same as
>  .BR PR_SPEC_DISABLE ,
>  but cannot be undone.
>  A subsequent
> -.B
> -prctl(..., PR_SPEC_ENABLE)
> +.BR prctl (\c
> +.IR arg2 ,
> +.BR PR_SPEC_ENABLE )
> +with the same value for
> +.I arg2
>  will fail with the error
>  .BR EPERM .
>  .RE
>  .IP
> -Any other value in
> +Any unsupported value in
>  .IR arg3
>  will result in the call failing with the error
>  .BR ERANGE .

Cheers,

Michael



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
