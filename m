From: <Vineet.Gupta1@synopsys.com>
Subject: [PATCH] sysctl: some arch specific unaligned access knobs made generic
Date: Thu, 20 Dec 2012 16:41:37 +0530
Message-ID: <1356001898-2960-1-git-send-email-vgupta@synopsys.com>
References: <50D2B75A.3000208@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hermes.synopsys.com ([198.182.44.81]:40322 "EHLO
	hermes.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781Ab2LTLMA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 20 Dec 2012 06:12:00 -0500
Received: from mailhost.synopsys.com (unknown [10.9.202.240])
	by hermes.synopsys.com (Postfix) with ESMTP id C7E1B16CCC1
	for <linux-arch@vger.kernel.org>; Thu, 20 Dec 2012 03:11:59 -0800 (PST)
Received: from mailhost.synopsys.com (localhost [127.0.0.1])
	by mailhost.synopsys.com (Postfix) with ESMTP id BD3EC59E
	for <linux-arch@vger.kernel.org>; Thu, 20 Dec 2012 03:11:59 -0800 (PST)
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
	by mailhost.synopsys.com (Postfix) with ESMTP id B84A859D
	for <linux-arch@vger.kernel.org>; Thu, 20 Dec 2012 03:11:59 -0800 (PST)
In-Reply-To: <50D2B75A.3000208@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>

From: Vineet Gupta <vgupta@synopsys.com>

This came out ARC Port's review by Arnd where he suggested using the existing
sysctl knobs in parisc and/or ia64 for runtime controlling unaligned access
emulation.

Turns out that ARC port needs bit of both.

The two common sysctl knobs are now #ifdef based on init/Kconfig options
which the corresponding arches now select in their Kconfigs.
No other arch code is touched.

P.S. I've deliberately NOT added the new items at the end of arch/*/Kconfig,
to avoid any merge conflicts going further - anyhow both the ia64/parisc
Kconfigs are not sorted either.

Vineet Gupta (1):
  sysctl: convert arch specific unaligned access regulators to generic
    ones

 arch/ia64/Kconfig   |    1 +
 arch/parisc/Kconfig |    1 +
 init/Kconfig        |   16 ++++++++++++++++
 kernel/sysctl.c     |   16 +++++++++++++---
 4 files changed, 31 insertions(+), 3 deletions(-)

-- 
1.7.4.1
