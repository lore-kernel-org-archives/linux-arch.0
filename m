From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH 0/2 v2] locking/qrwlock: Fix interrupt handling problem
Date: Tue,  9 Jun 2015 11:19:11 -0400
Message-ID: <1433863153-30722-1-git-send-email-Waiman.Long@hp.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g4t3427.houston.hp.com ([15.201.208.55]:59225 "EHLO
	g4t3427.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752981AbbFIPTV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2015 11:19:21 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>, Waiman Long <Waiman.Long@hp.com>

v1->v2:
 - Add microbenchmark data for the second patch

This patch series contains 2 patches on qrwlock. The first one is just
a recap of the patch that I sent a few weeks ago. The second one is to
optimize the writer slowpath.

Waiman Long (2):
  locking/qrwlock: Fix bug in interrupt handling code
  locking/qrwlock: Don't contend with readers when setting _QW_WAITING

 include/asm-generic/qrwlock.h |    4 +-
 kernel/locking/qrwlock.c      |   42 +++++++++++++++++++++++++++++++---------
 2 files changed, 34 insertions(+), 12 deletions(-)
