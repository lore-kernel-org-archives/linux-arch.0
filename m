From: Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 00/14] prctl.2 man page updates for Linux 5.6
Date: Tue, 12 May 2020 17:36:45 +0100
Message-ID: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
Return-path: <linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Amit Daniel Kachhap <amit.kachhap-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Dave Hansen <dave.hansen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Tim Chen <tim.c.chen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Waiman Long <longman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Will Deacon <will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

A bunch of updates to the prctl(2) man page to fill in the missing
prctls (mostly) up to Linux 5.6 (along with a few other tweaks fixes).

People not Cc'd on the whole series can find the whole series at
https://lore.kernel.org/linux-man/ .

Patches:

 * Patches 1-6 and 8-9 are rather trivial optional tweaks and fixes
   that don't make substantive changes.  I can live with some of these
   being dropped.

 * Patch 7 (removal of the MPX prctls) could use an Ack, but should be
   uncontroversial.

 * Patches 10-11 cover recent extensions to the speculation control
   prctls.

 * Patch 12 adds one particular case Errors for EINVAL, applicable to
   all arch-specific prctls.  I've not tried too hard to be 100%
   comprehensive with the error conditions, since the list in its
   current form looks in need of a major overhaul.

 * Patches 13-14 add the new arm64-specific prctls.
   (PR_SET_TAGGED_ADDR_CTRL requires a bit more discussion and will be
   posted separately.)

Maintainer notes:

 * I'm *asssuming* that the datestamps in .TH are automatically
   updated by maintainer scripts, since maintaining them by hand would
   interact very badly with rebase.  If needed I can go update them by
   hand though.

 * Similarly, in the days of git (and because I see no recent entries)
   I'm assuming that in-file changelogs no longer need to be updated.
   Again, I'm happy to do that if needed.


Dave Martin (14):
  prctl.2: tfix clarify that prctl can apply to threads
  prctl.2: Add health warning
  prctl.2: tfix mis-description of thread ID values in procfs
  prctl.2: srcfix add comments for navigation
  prctl.2: tfix listing order of prctls
  prctl.2: ffix quotation mark tweaks
  prctl.2: Document removal of Intel MPX prctls
  prctl.2: Work around bogus constant "maxsig" in PR_SET_PDEATHSIG
  prctl.2: tfix minor punctuation in SPECULATION_CTRL prctls
  prctl.2: Add PR_SPEC_INDIRECT_BRANCH for SPECULATION_CTRL prctls
  prctl.2: Add PR_SPEC_DISABLE_NOEXEC for SPECULATION_CTRL prctls
  prctl.2: Clarify the unsupported hardware case of EINVAL
  prctl.2: Add SVE prctls (arm64)
  prctl.2: Add PR_PAC_RESET_KEYS (arm64)

 man2/prctl.2 | 496 +++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 384 insertions(+), 112 deletions(-)

-- 
2.1.4
