From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: Re: [PATCH 12/14] prctl.2: Clarify the unsupported hardware case of
 EINVAL
Date: Wed, 13 May 2020 12:48:50 +0200
Message-ID: <12b559c1-21c9-833f-1a5e-37ddad284880@gmail.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
 <1589301419-24459-13-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730734AbgEMKs4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 May 2020 06:48:56 -0400
In-Reply-To: <1589301419-24459-13-git-send-email-Dave.Martin@arm.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: mtk.manpages@gmail.com, linux-man@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello Dave,

On 5/12/20 6:36 PM, Dave Martin wrote:
> prctls that are architecture-specific won't work on other
> architectures, and arch-specific prctls that manipulate optional
> hardware features likewise won't work if that hardware feature is
> not present.
> 
> The established pattern seems to be to treat such prctls as if they
> are unimplemented, when attempted on the wrong hardware.
> 
> Cover these cases with some generic weasel words in the closet
> existing EINVAL clause.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Thanks. Patch applied

Cheers,

Michael

> ---
>  man2/prctl.2 | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/man2/prctl.2 b/man2/prctl.2
> index 2361b44..7f511d2 100644
> --- a/man2/prctl.2
> +++ b/man2/prctl.2
> @@ -1616,7 +1616,8 @@ is an invalid address.
>  .B EINVAL
>  The value of
>  .I option
> -is not recognized.
> +is not recognized,
> +or not supported on this system.
>  .TP
>  .B EINVAL
>  .I option
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
