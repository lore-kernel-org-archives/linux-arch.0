Return-Path: <SRS0=MbEv=AF=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from foss.arm.com ([217.140.110.172]:47362 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404908AbgFXRgI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Jun 2020 13:36:08 -0400
From: Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH v3 0/2] prctl.2 man page updates for Linux 5.6
Date: Wed, 24 Jun 2020 18:36:00 +0100
Message-ID: <1593020162-9365-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: linux-man@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <20200624173600.AmoQT1czks4orCQIvfkoKNZzTrRKSWSA3mc8J57QZ14@z>

A bunch of updates to the prctl(2) man page to fill in missing
prctls (mostly) up to Linux 5.6 (along with a few other tweaks and
fixes).

Patches from the v2 series [1] that have been applied or rejected
already have been dropped.

All that remain here now are the SVE and tagged address ABI controls
for arm64.



[1] https://lore.kernel.org/linux-man/1590614258-24728-1-git-send-email-Dave.Martin@arm.com/


Dave Martin (2):
  prctl.2: Add SVE prctls (arm64)
  prctl.2: Add tagged address ABI control prctls (arm64)

 man2/prctl.2 | 331 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 331 insertions(+)

-- 
2.1.4
