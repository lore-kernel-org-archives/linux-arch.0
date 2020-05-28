From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: Re: [PATCH v2 0/6] prctl.2 man page updates for Linux 5.6
Date: Thu, 28 May 2020 09:11:40 +0200
Message-ID: <CAKgNAkhHzrNHjpRAKo_cU7+0-OGP9eyvmdA=AD3OgvVDq8vjcQ@mail.gmail.com>
References: <1590614258-24728-1-git-send-email-Dave.Martin@arm.com>
Reply-To: mtk.manpages@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE1HLw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 May 2020 03:11:52 -0400
In-Reply-To: <1590614258-24728-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-man <linux-man@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Amit Daniel Kachhap <amit.kachhap@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Tim Chen <tim.c.chen@linux.intel.com>, Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>

Hi Dave

On Wed, 27 May 2020 at 23:17, Dave Martin <Dave.Martin@arm.com> wrote:
>
> A bunch of updates to the prctl(2) man page to fill in missing
> prctls (mostly) up to Linux 5.6 (along with a few other tweaks and
> fixes).
>
> Patches from the v1 series [1] that have been applied or rejected
> already have been dropped.
>
> People not Cc'd on the whole series can find the whole series at
> https://lore.kernel.org/linux-man/ .
>
> Patches:
>
>  * Patch 1 is a new (but trivial) formatting fix, unrelated to the new
>    prctls.

Applied.

>  * Patches 2-3 relate to the speculation control prctls.  These are
>    unmodified from v1, but need review.

Applied, and pushed (since there were no review comments from last version).

>  * Patches 4-5 relate to the arm64 prctls from v1, with reviewer
>    feedback incorporated.  (See notes in the patches.)

I'll hold off on these patches, to see if review comments come in.

>  * Patch 6 is *draft* wording for the arm64 address tagging prctls.
>    The semantics of address tagging is particularly slippery, so
>    this needs discussion before merging.

Okay -- I'll hold off with that patch too.

Cheers,

Michael

> [1] https://lore.kernel.org/linux-man/29a02b16-dd61-6186-1340-fcc7d5225ad0@gmail.com/T/#t
>
>
> Dave Martin (6):
>   prctl.2: ffix use literal hyphens when referencing kernel docs
>   prctl.2: Add PR_SPEC_INDIRECT_BRANCH for SPECULATION_CTRL prctls
>   prctl.2: Add PR_SPEC_DISABLE_NOEXEC for SPECULATION_CTRL prctls
>   prctl.2: Add SVE prctls (arm64)
>   prctl.2: Add PR_PAC_RESET_KEYS (arm64)
>   prctl.2: Add tagged address ABI control prctls (arm64)
>
>  man2/prctl.2 | 444 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 435 insertions(+), 9 deletions(-)
>
> --
> 2.1.4
>
