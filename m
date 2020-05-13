Return-Path: <SRS0=OnnN=63=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732606AbgEMKbK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 May 2020 06:31:10 -0400
Subject: Re: [PATCH 09/14] prctl.2: tfix minor punctuation in SPECULATION_CTRL
 prctls
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
 <1589301419-24459-10-git-send-email-Dave.Martin@arm.com>
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <6322d3db-75d0-7539-b61c-252d222f932f@gmail.com>
Date: Wed, 13 May 2020 12:31:06 +0200
MIME-Version: 1.0
In-Reply-To: <1589301419-24459-10-git-send-email-Dave.Martin@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: mtk.manpages@gmail.com, linux-man@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20200513103106.X5Q8uueeCojpEJO79-bzs6bMcRQIujjKpyAKF8uUPGE@z>

On 5/12/20 6:36 PM, Dave Martin wrote:
> Fix a few very minor bits of punctuation in
> PR_SET_SPECULATION_CTRL and PR_GET_SPECULATION_CTRL.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

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
