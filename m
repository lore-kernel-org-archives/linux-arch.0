Return-Path: <SRS0=7GPW=7K=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58601 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390432AbgE1NpH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 28 May 2020 09:45:07 -0400
Subject: Re: [PATCH v2 3/6] prctl.2: Add PR_SPEC_DISABLE_NOEXEC for
 SPECULATION_CTRL prctls
References: <1590614258-24728-1-git-send-email-Dave.Martin@arm.com>
 <1590614258-24728-4-git-send-email-Dave.Martin@arm.com>
From: Waiman Long <longman@redhat.com>
Message-ID: <35acb48d-6703-bed5-8c6d-739411eea679@redhat.com>
Date: Thu, 28 May 2020 09:45:00 -0400
MIME-Version: 1.0
In-Reply-To: <1590614258-24728-4-git-send-email-Dave.Martin@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>, Michael Kerrisk <mtk.manpages@gmail.com>
Cc: linux-man@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>
Message-ID: <20200528134500.T1AG84GLQhgQk1s-j3UFC1AN3LiKb-M4UuH6QHbV9i4@z>

On 5/27/20 5:17 PM, Dave Martin wrote:
> Add the PR_SPEC_DISABLE_NOEXEC mode added in Linux 5.1
> for the PR_SPEC_STORE_BYPASS "misfeature" of
> PR_SET_SPECULATION_CTRL and PR_GET_SPECULATION_CTRL.
>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>   man2/prctl.2 | 22 ++++++++++++++++++++--
>   1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/man2/prctl.2 b/man2/prctl.2
> index b6fb51c..cab9915 100644
> --- a/man2/prctl.2
> +++ b/man2/prctl.2
> @@ -1187,6 +1187,12 @@ The speculation feature is disabled, mitigation is enabled.
>   Same as
>   .B PR_SPEC_DISABLE
>   but cannot be undone.
> +.TP
> +.BR PR_SPEC_DISABLE_NOEXEC " (since Linux 5.1)"
> +Same as
> +.BR PR_SPEC_DISABLE ,
> +but but the state will be cleared on
> +.BR execve (2).
>   .RE
>   .IP
>   If all bits are 0,
> @@ -1251,6 +1257,17 @@ with the same value for
>   .I arg2
>   will fail with the error
>   .BR EPERM .
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
>   .RE
>   .IP
>   Any unsupported value in
> @@ -1899,11 +1916,12 @@ was
>   .BR PR_SET_SPECULATION_CTRL
>   and
>   .IR arg3
> -is neither
> +is not
>   .BR PR_SPEC_ENABLE ,
>   .BR PR_SPEC_DISABLE ,
> +.BR PR_SPEC_FORCE_DISABLE ,
>   nor
> -.BR PR_SPEC_FORCE_DISABLE .
> +.BR PR_SPEC_DISABLE_NOEXEC .
>   .SH VERSIONS
>   The
>   .BR prctl ()

Acked-by: Waiman Long <longman@redhat.com>
