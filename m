Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp11.uk.ibm.com ([195.75.94.107]:59786 "EHLO
	e06smtp11.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875AbaK0RK2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 27 Nov 2014 12:10:28 -0500
Received: from /spool/local
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <dahi@linux.vnet.ibm.com>;
	Thu, 27 Nov 2014 17:10:26 -0000
From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: [PATCH RFC 0/2] Reenable might_sleep() checks for might_fault() when atomic
Date: Thu, 27 Nov 2014 18:10:15 +0100
Message-ID: <1417108217-42687-1-git-send-email-dahi@linux.vnet.ibm.com>
In-Reply-To: <1416915806-24757-1-git-send-email-dahi@linux.vnet.ibm.com>
References: <1416915806-24757-1-git-send-email-dahi@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org, heiko.carstens@de.ibm.com, dahi@linux.vnet.ibm.com, schwidefsky@de.ibm.com, borntraeger@de.ibm.com, mst@redhat.com, tglx@linutronix.de, David.Laight@ACULAB.COM
Message-ID: <20141127171015.TrUNG9WTMtwVmIeoHNsQqkYCRWgnlk9QVE2fMf36jc0@z>

Simple prototype to enable might_sleep() checks in might_fault(), avoiding false
positives for scenarios involving explicit pagefault_disable().

So this should work:
	spin_lock(&lock); /* also if left away */
	pagefault_disable()
	rc = copy_to_user(...)
	pagefault_enable();
	spin_unlock(&lock); /*

And this should report a warning again:
	spin_lock(&lock);
	rc = copy_to_user(...);
	spin_unlock(&lock);

Still missing:
- Split of preempt documentation update + preempt_active define reshuffle
- Debug version to test for over/underflows
- Change documentation of user access methods to reflect the real behavior
- Don't touch the preempt counter, only the pagefault disable counter (future
  work)

David Hildenbrand (2):
  preempt: track pagefault_disable() calls in the preempt counter
  mm, sched: trigger might_sleep() in might_fault() when pagefaults are
    disabled

 include/linux/kernel.h       |  9 +++++++--
 include/linux/preempt_mask.h | 24 +++++++++++++++++++-----
 include/linux/uaccess.h      | 21 ++++++++++++++-------
 mm/memory.c                  | 15 ++++-----------
 4 files changed, 44 insertions(+), 25 deletions(-)

-- 
1.8.5.5

