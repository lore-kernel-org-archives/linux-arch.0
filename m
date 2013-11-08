Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:57128 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757457Ab3KHTve (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 8 Nov 2013 14:51:34 -0500
Subject: [PATCH v5 0/4] MCS Lock: MCS lock code cleanup and optimizations
From: Tim Chen <tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 08 Nov 2013 11:51:30 -0800
Message-ID: <1383940290.11046.413.camel@schen9-DESK>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Waiman Long <waiman.long@hp.com>, Andrea Arcangeli <aarcange@redhat.com>, Alex Shi <alex.shi@linaro.org>, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, Matthew R Wilcox <matthew.r.wilcox@intel.com>, Dave Hansen <dave.hansen@intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Rik van Riel <riel@redhat.com>, Peter Hurley <peter@hurleysoftware.com>, "Paul E.McKenney" <paulmck@linux.vnet.ibm.com>, Tim Chen <tim.c.chen@linux.intel.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, George Spelvin <linux@horizon.com>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Aswin Chandramouleeswaran <aswin@hp.com>, Scott J Norton <scott.norton@hp.com>, Will Deacon <will.deacon@arm.com>, "Figo.zhang" <figo1802@gmail.com>
Message-ID: <20131108195130.Aoc3PBrPdFxljE4d1gPxBXLr6rFdjou83zNd8jEI16c@z>

In this patch series, we separated out the MCS lock code which was
previously embedded in the mutex.c.  This allows for easier reuse of
MCS lock in other places like rwsem and qrwlock.  We also did some micro
optimizations and barrier cleanup.  

The original code has potential leaks between critical sections, which
was not a problem when MCS was embedded within the mutex but needs
to be corrected when allowing the MCS lock to be used by itself for
other locking purposes. 

Proper barriers are now embedded with the usage of smp_load_acquire() in
mcs_spin_lock() and smp_store_release() in mcs_spin_unlock.  See
http://marc.info/?l=linux-arch&m=138386254111507 for info on the
new smp_load_acquire() and smp_store_release() functions. 

One thing to note is the use of smp_load_acquire in a spin loop
to check for lock acquisition.  If there are concerns about 
a potential barrier being in the spin loop for some architectures, please let
us know.  

This patches were previously part of the rwsem optimization patch series
but now we spearate them out.

Tim Chen

Jason Law (1):
  MCS Lock: optimizations and extra comments

Tim Chen (1):
  MCS Lock: Restructure the MCS lock defines and locking code into its
    own file

Waiman Long (2):
  MCS Lock: Move mcs_lock/unlock function into its own file
  MCS Lock: Barrier corrections

 include/linux/mcs_spinlock.h  |   25 +++++++++
 include/linux/mutex.h         |    5 +-
 kernel/locking/Makefile       |    6 +-
 kernel/locking/mcs_spinlock.c |  108 +++++++++++++++++++++++++++++++++++++++++
 kernel/locking/mutex.c        |   60 +++--------------------
 5 files changed, 146 insertions(+), 58 deletions(-)
 create mode 100644 include/linux/mcs_spinlock.h
 create mode 100644 kernel/locking/mcs_spinlock.c

-- 
1.7.4.4


