From: Bernhard Walle <bwalle@suse.de>
Subject: [RFC] Add dev.mem.restricted sysctl
Date: Sun, 16 Nov 2008 01:03:41 +0100
Message-ID: <1226793823-32360-1-git-send-email-bwalle@suse.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:44594 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752221AbYKPADp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 15 Nov 2008 19:03:45 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Bernhard Walle <bwalle@suse.de>

While the first patch is only a small cleanup, the second patch adds a
new sysctl dev.mem.restricted. See that patch for a description why I
think that sysctl is needed.

Please give feedback and review. Thanks!


Signed-off-by: Bernhard Walle <bwalle@suse.de>
