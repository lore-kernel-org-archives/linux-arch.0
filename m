Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S266534AbUHMSOY@vger.kernel.org>
Received: from mtagate1.de.ibm.com ([195.212.29.150]:17397 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S266532AbUHMSOX
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 13 Aug 2004 14:14:23 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.12.10/8.12.10) with ESMTP id i7DIEKGP133838
	for <linux-arch@vger.kernel.org>; Fri, 13 Aug 2004 18:14:20 GMT
Received: from mschwid3.boeblingen.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id i7DIEKcL068362
	for <linux-arch@vger.kernel.org>; Fri, 13 Aug 2004 20:14:20 +0200
Received: from sky by mschwid3.boeblingen.de.ibm.com with local (Exim 3.36 #1 (Debian))
	id 1BvgZn-0000UK-00
	for <linux-arch@vger.kernel.org>; Fri, 13 Aug 2004 20:14:51 +0200
Date: Fri, 13 Aug 2004 20:14:51 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [RFC] cputime patches.
Message-ID: <20040813181451.GA1862@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Hi folks,
finally found the fixed point divide exception that kept haunting me.
Here is the latest and greatest cputime patch set. It works nicely on
s390 and doesn't seem to break anything on my thinkpad.

Jan's virtual cputime time slice patch is now ready as well, so there
are 7 patches:

[PATCH] cputime (1/7): move call to update_process_times.
[PATCH] cputime (2/7): remove unused definitions from timex.h.
[PATCH] cputime (3/7): move jiffies stuff to jiffies.h
[PATCH] cputime (4/7): introduce cputime.
[PATCH] cputime (5/7): microsecond based cputime for s390.
[PATCH] cputime (6/7): introduce timeslices timer.
[PATCH] cputime (7/7): add cpu steal time fields to procps.

With all these patches we finally have decent (that means usable) cpu
accounting numbers on s390 and a fairer scheduling.

The patches are against 2.6.8-rc4. I'll keep the fingers crossed
that I didn't break any architecture.

Now what do you guys think about it?

blue skies,
  Martin.
