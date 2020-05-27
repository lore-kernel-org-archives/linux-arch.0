From: Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 0/6] prctl.2 man page updates for Linux 5.6
Date: Wed, 27 May 2020 22:17:32 +0100
Message-ID: <1590614258-24728-1-git-send-email-Dave.Martin@arm.com>
Return-path: <linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Kerrisk <mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Amit Daniel Kachhap <amit.kachhap-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Dave Hansen <dave.hansen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Tim Chen <tim.c.chen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Waiman Long <longman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Will Deacon <will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vincenzo Frascino <vincenzo.frascino-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

A bunch of updates to the prctl(2) man page to fill in missing
prctls (mostly) up to Linux 5.6 (along with a few other tweaks and
fixes).

Patches from the v1 series [1] that have been applied or rejected
already have been dropped.

People not Cc'd on the whole series can find the whole series at
https://lore.kernel.org/linux-man/ .

Patches:

 * Patch 1 is a new (but trivial) formatting fix, unrelated to the new
   prctls.

 * Patches 2-3 relate to the speculation control prctls.  These are
   unmodified from v1, but need review.

 * Patches 4-5 relate to the arm64 prctls from v1, with reviewer
   feedback incorporated.  (See notes in the patches.)

 * Patch 6 is *draft* wording for the arm64 address tagging prctls.
   The semantics of address tagging is particularly slippery, so
   this needs discussion before merging.


[1] https://lore.kernel.org/linux-man/29a02b16-dd61-6186-1340-fcc7d5225ad0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org/T/#t


Dave Martin (6):
  prctl.2: ffix use literal hyphens when referencing kernel docs
  prctl.2: Add PR_SPEC_INDIRECT_BRANCH for SPECULATION_CTRL prctls
  prctl.2: Add PR_SPEC_DISABLE_NOEXEC for SPECULATION_CTRL prctls
  prctl.2: Add SVE prctls (arm64)
  prctl.2: Add PR_PAC_RESET_KEYS (arm64)
  prctl.2: Add tagged address ABI control prctls (arm64)

 man2/prctl.2 | 444 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 435 insertions(+), 9 deletions(-)

-- 
2.1.4
