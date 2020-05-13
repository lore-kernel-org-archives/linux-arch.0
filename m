Return-Path: <SRS0=OnnN=63=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732382AbgEMKMA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 May 2020 06:12:00 -0400
Subject: Re: [PATCH 07/14] prctl.2: Document removal of Intel MPX prctls
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
 <1589301419-24459-8-git-send-email-Dave.Martin@arm.com>
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <3201c6e6-bd9e-aef4-fae5-70229e1b1abe@gmail.com>
Date: Wed, 13 May 2020 12:11:57 +0200
MIME-Version: 1.0
In-Reply-To: <1589301419-24459-8-git-send-email-Dave.Martin@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: mtk.manpages@gmail.com, linux-man@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>
Message-ID: <20200513101157.wPZ6_FwdRox-5mwk00p7RyRj60MwDtOhX7POKcxdDf4@z>

On 5/12/20 6:36 PM, Dave Martin wrote:
> The Intel MPX API was removed from Linux 5.4.  See Linux
> commit f240652b6032 ("x86/mpx: Remove MPX APIs")
> 
> Document this change.

Thanks. Patch applied, with Dave H's Acked-by.

Cheers,

Michael

> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  man2/prctl.2 | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/man2/prctl.2 b/man2/prctl.2
> index 7a3fc5c..a84fb1d 100644
> --- a/man2/prctl.2
> +++ b/man2/prctl.2
> @@ -784,7 +784,7 @@ option enabled.
>  .RE
>  .\" prctl PR_MPX_ENABLE_MANAGEMENT
>  .TP
> -.BR PR_MPX_ENABLE_MANAGEMENT ", " PR_MPX_DISABLE_MANAGEMENT " (since Linux 3.19) "
> +.BR PR_MPX_ENABLE_MANAGEMENT ", " PR_MPX_DISABLE_MANAGEMENT " (since Linux 3.19, removed in Linux 5.4; only on x86) "
>  .\" commit fe3d197f84319d3bce379a9c0dc17b1f48ad358c
>  .\" See also http://lwn.net/Articles/582712/
>  .\" See also https://gcc.gnu.org/wiki/Intel%20MPX%20support%20in%20the%20GCC%20compiler
> @@ -859,6 +859,12 @@ had been called.
>  .IP
>  For further information on Intel MPX, see the kernel source file
>  .IR Documentation/x86/intel_mpx.txt .
> +.IP
> +.\" commit f240652b6032b48ad7fa35c5e701cc4c8d697c0b
> +.\" See also https://lkml.kernel.org/r/20190705175321.DB42F0AD@viggo.jf.intel.com
> +Due to a lack of toolchain support,
> +.BR PR_MPX_ENABLE_MANAGEMENT " and " PR_MPX_DISABLE_MANAGEMENT
> +are not supported by Linux 5.4 or later.
>  .\" prctl PR_SET_NAME
>  .TP
>  .BR PR_SET_NAME " (since Linux 2.6.9)"
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
