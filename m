From: Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v3 0/2] prctl.2 man page updates for Linux 5.6
Date: Wed, 24 Jun 2020 18:36:00 +0100
Message-ID: <1593020162-9365-1-git-send-email-Dave.Martin@arm.com>
Return-path: <linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Kerrisk <mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vincenzo Frascino <vincenzo.frascino-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

A bunch of updates to the prctl(2) man page to fill in missing
prctls (mostly) up to Linux 5.6 (along with a few other tweaks and
fixes).

Patches from the v2 series [1] that have been applied or rejected
already have been dropped.

All that remain here now are the SVE and tagged address ABI controls
for arm64.



[1] https://lore.kernel.org/linux-man/1590614258-24728-1-git-send-email-Dave.Martin-5wv7dgnIgG8@public.gmane.org/


Dave Martin (2):
  prctl.2: Add SVE prctls (arm64)
  prctl.2: Add tagged address ABI control prctls (arm64)

 man2/prctl.2 | 331 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 331 insertions(+)

-- 
2.1.4
