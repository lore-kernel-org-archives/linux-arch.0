Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate4.de.ibm.com ([195.212.29.153]:30528 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S932201AbWIEQcy
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 5 Sep 2006 12:32:54 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.7/8.13.7) with ESMTP id k85GWrEM026606
	for <linux-arch@vger.kernel.org>; Tue, 5 Sep 2006 16:32:53 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k85GbGTG2650204
	for <linux-arch@vger.kernel.org>; Tue, 5 Sep 2006 18:37:16 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k85GWrEf004647
	for <linux-arch@vger.kernel.org>; Tue, 5 Sep 2006 18:32:53 +0200
Received: from localhost (dyn-9-152-216-78.boeblingen.de.ibm.com [9.152.216.78])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k85GWrGh004644
	for <linux-arch@vger.kernel.org>; Tue, 5 Sep 2006 18:32:53 +0200
Date: Tue, 5 Sep 2006 18:32:52 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 0/5] Kconfig: cover sheet.
Message-ID: <20060905163252.GA6510@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

I spent some more time on my kconfig rework in order to get s390
use the standard drivers/Kconfig instead of the home-brewn
drivers/s390/Kconfig. Most important improvement compared to
older patches: the disable command can now be placed anywhere.

With all 5 patches applied on-top of 2.6.18-rc5-mm1 s390 now has a
decent configuration while including all the standard Kconfig files.
Trying to get the current -mm tree to work is another issue.
allnoconfig doesn't link because blk_congestion_end is not defined.
Enabling the block layer gets it to compile but the kernel is
naturally pretty useless.
It compiles fine with allmodconfig and compiles almost with
allyesconfig. There is a bug in the cachefiles filesystem (misplaced
__exit). These two kernels didn't boot as well, there are still many
problems left in -mm in regard to s390. The likely/unlikely profiler
doesn't work, the lock dependency validator still has problems,
atm crashes ...
I stopped there, dealing with a 17MB allyesconfig kernel is too
scary, the listing of vmlinux had 1,46 GB.

The only stain left in regard to Kconfig is the following warning:
    drivers/hwmon/Kconfig:533:warning: 'select' used by config symbol
    'SENSORS_HDAPS' refer to undefined symbol 'THINKPAD_EC'
THINKPAD_EC is defined in drivers/firmware/Kconfig which is only
included for i386, ia64 and x86_64. Imho, a common Kconfig should
never refer to a symbol that is only available for a subset of
architectures.

What I'd like to see is a decision about the proposed "disable"
command. Should it be added or not? The alternative solution for
the s390 config problem would be to add more "depends on !S390"
to the features that are disabled.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.

