Return-Path: <SRS0=OnnN=63=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732741AbgEMKbB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 May 2020 06:31:01 -0400
Subject: Re: [PATCH 08/14] prctl.2: Work around bogus constant "maxsig" in
 PR_SET_PDEATHSIG
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
 <1589301419-24459-9-git-send-email-Dave.Martin@arm.com>
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <4f7bee2a-1db6-1cf5-6561-b24397c33707@gmail.com>
Date: Wed, 13 May 2020 12:30:58 +0200
MIME-Version: 1.0
In-Reply-To: <1589301419-24459-9-git-send-email-Dave.Martin@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: mtk.manpages@gmail.com, linux-man@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20200513103058.kYqQxRpnW6mfKA02Z0TTvCy5ZuXsipTZoM0TefCug7Q@z>

On 5/12/20 6:36 PM, Dave Martin wrote:
> The description of PR_SET_PDEATHSIG refers to "maxsig", which is
> apparently intended to stand for the maximum defined signal number.
> 
> maxsig seems not to be a thing, even in the kernel.
> 
> Reword to use the standard constant NSIG.  (Discussion of SIGRTMIN
> and SIGRTMAX seems out of scope here, and anyway is not relevant to
> the kernel.)

Thanks, Dave. Patch applied.

Cheers,

Michael

> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
>  man2/prctl.2 | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/man2/prctl.2 b/man2/prctl.2
> index a84fb1d..1e04859 100644
> --- a/man2/prctl.2
> +++ b/man2/prctl.2
> @@ -955,7 +955,9 @@ will operate in the privilege-restricting mode described above.
>  .BR PR_SET_PDEATHSIG " (since Linux 2.1.57)"
>  Set the parent-death signal
>  of the calling process to \fIarg2\fP (either a signal value
> -in the range 1..maxsig, or 0 to clear).
> +in the range 1 ..
> +.BR NSIG " \-"
> +1, or 0 to clear).
>  This is the signal that the calling process will get when its
>  parent dies.
>  .IP
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
