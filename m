Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from us02smtp2.synopsys.com ([198.182.60.77]:44695 "EHLO
	alvesta.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792Ab3ACGsO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 3 Jan 2013 01:48:14 -0500
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [RESEND PATCH] Convert IA64 sysctl to generic
Date: Thu, 3 Jan 2013 12:17:32 +0530
Message-ID: <1357195653-998-1-git-send-email-vgupta@synopsys.com>
In-Reply-To: <50D2B75A.3000208@synopsys.com>
References: <50D2B75A.3000208@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <20130103064732.tQhNC0Aoi9ktStCTziRq7Cw405Q1TbBXiHnGze47tlU@z>

Hi,

This came out ARC Port's review by Arnd where he suggested using the existing
sysctl knobs in parisc and/or ia64 for runtime controlling unaligned access
emulation.

Turns out that ARC port needs bit of both.

The common sysctl knobs are now #ifdef based on init/Kconfig options which
the corresponding arches now select in their Kconfigs.
No other arch code is touched (although code has not been compile tested).

If this patch is ACKable, I would request you to please take this patch
via your arch tree - to avoid any merge-hassles and other interdependencies
later.

P.S. I've deliberately NOT added the new items at the end of arch/*/Kconfig,
to avoid any merge conflicts going further - anyhow both the ia64/parisc
Kconfigs are not sorted either.

Thx,
-Vineet

Vineet Gupta (1):
  sysctl: Enable IA64 "ignore-unaligned-usertrap" to be used cross-arch

 arch/ia64/Kconfig |    1 +
 init/Kconfig      |    8 ++++++++
 kernel/sysctl.c   |    9 +++++++--
 3 files changed, 16 insertions(+), 2 deletions(-)

-- 
1.7.4.1

