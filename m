From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH 0/2] locking/qrwlock: Fix interrupt handling problem
Date: Mon,  8 Jun 2015 18:20:42 -0400
Message-ID: <1433802045-21298-1-git-send-email-Waiman.Long@hp.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g9t1613g.houston.hp.com ([15.240.0.71]:52363 "EHLO
	g9t1613g.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753558AbbFHWVI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 8 Jun 2015 18:21:08 -0400
Received: from g2t2352.austin.hp.com (g2t2352.austin.hp.com [15.217.128.51])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by g9t1613g.houston.hp.com (Postfix) with ESMTPS id CA971611EC
	for <linux-arch@vger.kernel.org>; Mon,  8 Jun 2015 22:21:07 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>, Waiman Long <Waiman.Long@hp.com>

This patch series contains 2 patches on qrwlock. The first one is just
a recap of the patch that I sent a few weeks ago. The second one is to
optimize the writer slowpath.

Waiman Long (2):
  locking/qrwlock: Fix bug in interrupt handling code
  locking/qrwlock: Don't contend with readers when setting _QW_WAITING

 include/asm-generic/qrwlock.h |    4 +-
 kernel/locking/qrwlock.c      |   42 +++++++++++++++++++++++++++++++---------
 2 files changed, 34 insertions(+), 12 deletions(-)
