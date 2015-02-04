Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:56532 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752997AbbBDLcG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 4 Feb 2015 06:32:06 -0500
From: Luis Henriques <luis.henriques@canonical.com>
Subject: [3.16.y-ckt stable] Patch "vm: make stack guard page errors return VM_FAULT_SIGSEGV rather than SIGBUS" has been added to staging queue
Date: Wed,  4 Feb 2015 11:32:41 +0000
Message-ID: <1423049561-1513-1-git-send-email-luis.henriques@canonical.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-arch@vger.kernel.org, Luis Henriques <luis.henriques@canonical.com>, kernel-team@lists.ubuntu.com
Message-ID: <20150204113241.bCMcj6ZtexMDd71OF8bFdXfQ4nY8o2PVDiybWZ-heYk@z>

This is a note to let you know that I have just added a patch titled

    vm: make stack guard page errors return VM_FAULT_SIGSEGV rather than SIGBUS

to the linux-3.16.y-queue branch of the 3.16.y-ckt extended stable tree 
which can be found at:

 http://kernel.ubuntu.com/git?p=ubuntu/linux.git;a=shortlog;h=refs/heads/linux-3.16.y-queue

This patch is scheduled to be released in version 3.16.7-ckt6.

If you, or anyone else, feels it should not be added to this tree, please 
reply to this email.

For more information about the 3.16.y-ckt tree, see
https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable

Thanks.
-Luis

------
