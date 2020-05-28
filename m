Return-Path: <SRS0=7GPW=7K=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgE1G6B (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 May 2020 02:58:01 -0400
MIME-Version: 1.0
References: <1590614258-24728-1-git-send-email-Dave.Martin@arm.com> <1590614258-24728-4-git-send-email-Dave.Martin@arm.com>
In-Reply-To: <1590614258-24728-4-git-send-email-Dave.Martin@arm.com>
Reply-To: mtk.manpages@gmail.com
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date: Thu, 28 May 2020 08:57:49 +0200
Message-ID: <CAKgNAkg4P4GTVEoVXZd6yzpr97S0H+N8pdtwptJXaJBHfLAzKQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] prctl.2: Add PR_SPEC_DISABLE_NOEXEC for
 SPECULATION_CTRL prctls
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-man <linux-man@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Waiman Long <longman@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
Message-ID: <20200528065749.Q5jIFJpa5bfefA1eSbGMNdpNSDvahExa657c0T96iJE@z>

Hi Dave,

On Wed, 27 May 2020 at 23:18, Dave Martin <Dave.Martin@arm.com> wrote:
>
> Add the PR_SPEC_DISABLE_NOEXEC mode added in Linux 5.1
> for the PR_SPEC_STORE_BYPASS "misfeature" of
> PR_SET_SPECULATION_CTRL and PR_GET_SPECULATION_CTRL.
>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>

I had already applied your earlier send of this patch (in a private
branch). I'll push those changes shortly.

Cheers,

Michael

> ---
>  man2/prctl.2 | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/man2/prctl.2 b/man2/prctl.2
> index b6fb51c..cab9915 100644
> --- a/man2/prctl.2
> +++ b/man2/prctl.2
> @@ -1187,6 +1187,12 @@ The speculation feature is disabled, mitigation is enabled.
>  Same as
>  .B PR_SPEC_DISABLE
>  but cannot be undone.
> +.TP
> +.BR PR_SPEC_DISABLE_NOEXEC " (since Linux 5.1)"
> +Same as
> +.BR PR_SPEC_DISABLE ,
> +but but the state will be cleared on
> +.BR execve (2).
>  .RE
>  .IP
>  If all bits are 0,
> @@ -1251,6 +1257,17 @@ with the same value for
>  .I arg2
>  will fail with the error
>  .BR EPERM .
> +.\" commit 71368af9027f18fe5d1c6f372cfdff7e4bde8b48
> +.TP
> +.BR PR_SPEC_DISABLE_NOEXEC " (since Linux 5.1)"
> +Same as
> +.BR PR_SPEC_DISABLE ,
> +but but the state will be cleared on
> +.BR execve (2).
> +Currently only supported for
> +.I arg2
> +equal to
> +.B PR_SPEC_STORE_BYPASS.
>  .RE
>  .IP
>  Any unsupported value in
> @@ -1899,11 +1916,12 @@ was
>  .BR PR_SET_SPECULATION_CTRL
>  and
>  .IR arg3
> -is neither
> +is not
>  .BR PR_SPEC_ENABLE ,
>  .BR PR_SPEC_DISABLE ,
> +.BR PR_SPEC_FORCE_DISABLE ,
>  nor
> -.BR PR_SPEC_FORCE_DISABLE .
> +.BR PR_SPEC_DISABLE_NOEXEC .
>  .SH VERSIONS
>  The
>  .BR prctl ()
> --
> 2.1.4
>


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
