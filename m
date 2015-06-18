Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g2t1383g.austin.hp.com ([15.217.136.92]:9907 "EHLO
	g2t1383g.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750702AbbFRCUq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 17 Jun 2015 22:20:46 -0400
Received: from g1t5424.austin.hp.com (g1t5424.austin.hp.com [15.216.225.54])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by g2t1383g.austin.hp.com (Postfix) with ESMTPS id 27EFD3FDF
	for <linux-arch@vger.kernel.org>; Thu, 18 Jun 2015 02:20:45 +0000 (UTC)
From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH v4 0/2] locking/qrwlock: More optimizations in qrwlock
Date: Wed, 17 Jun 2015 22:20:21 -0400
Message-ID: <1434594023-43589-1-git-send-email-Waiman.Long@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>, Waiman Long <Waiman.Long@hp.com>
Message-ID: <20150618022021.D-16Y-NMqFBNn3F0m4s3hjjt89CrBdl2P_063uY7PYY@z>

v3->v4:
 - Remove the unnecessary _QW_WMASK check in
   queue_read_lock_slowpath().

v2->v3:
 - Fix incorrect commit log message in patch 1.

v1->v2:
 - Add microbenchmark data for the second patch

This patch set contains 2 patches on qrwlock. The first one is to
optimize the interrupt context reader slowpath.  The second one is
to optimize the writer slowpath.

Waiman Long (2):
  locking/qrwlock: Better optimization for interrupt context readers
  locking/qrwlock: Don't contend with readers when setting _QW_WAITING

 include/asm-generic/qrwlock.h |    4 ++--
 kernel/locking/qrwlock.c      |   41 +++++++++++++++++++++++++++++++----------
 2 files changed, 33 insertions(+), 12 deletions(-)

