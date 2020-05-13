From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: Re: [PATCH 00/14] prctl.2 man page updates for Linux 5.6
Date: Wed, 13 May 2020 13:28:23 +0200
Message-ID: <29a02b16-dd61-6186-1340-fcc7d5225ad0@gmail.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgEML21 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 May 2020 07:28:27 -0400
In-Reply-To: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: mtk.manpages@gmail.com, linux-man@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Amit Daniel Kachhap <amit.kachhap@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Tim Chen <tim.c.chen@linux.intel.com>, Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>

Hi Dave,

On 5/12/20 6:36 PM, Dave Martin wrote:
> A bunch of updates to the prctl(2) man page to fill in the missing
> prctls (mostly) up to Linux 5.6 (along with a few other tweaks fixes).
> 
> People not Cc'd on the whole series can find the whole series at
> https://lore.kernel.org/linux-man/ .
> 
> Patches:
> 
>  * Patches 1-6 and 8-9 are rather trivial optional tweaks and fixes
>    that don't make substantive changes.  I can live with some of these
>    being dropped.
> 
>  * Patch 7 (removal of the MPX prctls) could use an Ack, but should be
>    uncontroversial.
> 
>  * Patches 10-11 cover recent extensions to the speculation control
>    prctls.
> 
>  * Patch 12 adds one particular case Errors for EINVAL, applicable to
>    all arch-specific prctls.  I've not tried too hard to be 100%
>    comprehensive with the error conditions, since the list in its
>    current form looks in need of a major overhaul.
> 
>  * Patches 13-14 add the new arm64-specific prctls.
>    (PR_SET_TAGGED_ADDR_CTRL requires a bit more discussion and will be
>    posted separately.)

Thanks. This is great!

> Maintainer notes:
> 
>  * I'm *asssuming* that the datestamps in .TH are automatically
>    updated by maintainer scripts, since maintaining them by hand would
>    interact very badly with rebase.  If needed I can go update them by
>    hand though.
> 
>  * Similarly, in the days of git (and because I see no recent entries)
>    I'm assuming that in-file changelogs no longer need to be updated.

Correct.

>    Again, I'm happy to do that if needed.

(No need.)

Except as noted below, patches have been applied:

> Dave Martin (14):
>   prctl.2: tfix clarify that prctl can apply to threads
>   prctl.2: Add health warning
>   prctl.2: tfix mis-description of thread ID values in procfs
>   prctl.2: srcfix add comments for navigation
>   prctl.2: tfix listing order of prctls
>   prctl.2: ffix quotation mark tweaks
>   prctl.2: Document removal of Intel MPX prctls
>   prctl.2: Work around bogus constant "maxsig" in PR_SET_PDEATHSIG
>   prctl.2: tfix minor punctuation in SPECULATION_CTRL prctls
>   prctl.2: Add PR_SPEC_INDIRECT_BRANCH for SPECULATION_CTRL prctls

Applied, but not yet pushed.

>   prctl.2: Add PR_SPEC_DISABLE_NOEXEC for SPECULATION_CTRL prctls

Applied, but not yet pushed.

>   prctl.2: Clarify the unsupported hardware case of EINVAL
>   prctl.2: Add SVE prctls (arm64)

Will had comments. I'm presuming there will be a v2 of this patch.

>   prctl.2: Add PR_PAC_RESET_KEYS (arm64)

Will had comments. I'm presuming there will be a v2 of this patch.

Cheers,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
