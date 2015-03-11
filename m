Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:51650 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262AbbCKQpJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 11 Mar 2015 12:45:09 -0400
From: Kamal Mostafa <kamal@canonical.com>
Subject: [3.13.y-ckt stable] Patch "vm: make stack guard page errors return VM_FAULT_SIGSEGV rather than SIGBUS" has been added to staging queue
Date: Wed, 11 Mar 2015 09:45:03 -0700
Message-ID: <1426092303-9659-1-git-send-email-kamal@canonical.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-arch@vger.kernel.org, Kamal Mostafa <kamal@canonical.com>, kernel-team@lists.ubuntu.com
Message-ID: <20150311164503.uiTXx6eccRI4wlXXnwQ5V3nBt6CRlqSu-GPDI0XgPNE@z>

This is a note to let you know that I have just added a patch titled

    vm: make stack guard page errors return VM_FAULT_SIGSEGV rather than SIGBUS

to the linux-3.13.y-queue branch of the 3.13.y-ckt extended stable tree 
which can be found at:

 http://kernel.ubuntu.com/git?p=ubuntu/linux.git;a=shortlog;h=refs/heads/linux-3.13.y-queue

This patch is scheduled to be released in version 3.13.11-ckt17.

If you, or anyone else, feels it should not be added to this tree, please 
reply to this email.

For more information about the 3.13.y-ckt tree, see
https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable

Thanks.
-Kamal

------
