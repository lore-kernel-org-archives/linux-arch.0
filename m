Return-Path: <SRS0=9CnN=7J=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from foss.arm.com ([217.140.110.172]:44720 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbgE0VRp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 27 May 2020 17:17:45 -0400
From: Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH v2 0/6] prctl.2 man page updates for Linux 5.6
Date: Wed, 27 May 2020 22:17:32 +0100
Message-ID: <1590614258-24728-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: linux-man@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Amit Daniel Kachhap <amit.kachhap@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Tim Chen <tim.c.chen@linux.intel.com>, Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <20200527211732.vQ6XIeivX1U0uUBUpyuixL44Jk22ECvZz0pLKXn4esE@z>

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


[1] https://lore.kernel.org/linux-man/29a02b16-dd61-6186-1340-fcc7d5225ad0@gmail.com/T/#t


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
