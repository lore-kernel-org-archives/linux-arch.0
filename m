Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate1.de.ibm.com ([195.212.29.150]:40934 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750726AbWIRMUD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 18 Sep 2006 08:20:03 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.8/8.13.8) with ESMTP id k8ICK1N9056066
	for <linux-arch@vger.kernel.org>; Mon, 18 Sep 2006 12:20:01 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k8ICOjrX2383964
	for <linux-arch@vger.kernel.org>; Mon, 18 Sep 2006 14:24:45 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k8ICK0ZB000664
	for <linux-arch@vger.kernel.org>; Mon, 18 Sep 2006 14:20:01 +0200
Date: Mon, 18 Sep 2006 14:19:59 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 0/3] Directed yield.
Message-ID: <20060918121959.GA3290@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
To: akpm@osdl.org
Cc: linux-arch@vger.kernel.org, mingo@elte.hu, paulus@samba.org
List-ID: <linux-arch.vger.kernel.org>

Hi Andrew,
nobody has complained about my spinlock yield patches. There are
now three patches in the patch set: the _raw_[spin,read,write]_relax
introduction, the powerpc enablement and the s390 diag 0x9c patch.
Please add to -mm.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.
