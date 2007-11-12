Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate5.de.ibm.com ([195.212.29.154]:54610 "EHLO
	mtagate5.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752976AbXKLOkQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 12 Nov 2007 09:40:16 -0500
Message-Id: <20071112143009.425807965@de.ibm.com>
Date: Mon, 12 Nov 2007 15:30:09 +0100
From: schwidefsky@de.ibm.com
Subject: [patch 0/3] page table changes
Sender: linux-arch-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Hi Andrew,
more than 2 weeks have passed since I posted my six page table patches
to linux-kernel/linux-arch. Nobody complained so far (keeping fingers
crossed..) and Ben has a use for the first two patches on powerpc as
well. Next logical step would be to add the patches that affect common
code to the -mm tree, no?
The three patches in this patchset do apply against your snapshot
broken-out-2007-11-06-02-32.tar.gz. Please add.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

