Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.12.10/8.12.10) with ESMTP id j228NqFa125676
	for <linux-arch@vger.kernel.org>; Wed, 2 Mar 2005 08:23:52 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com [9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j228NqJ8135304
	for <linux-arch@vger.kernel.org>; Wed, 2 Mar 2005 09:23:52 +0100
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11/8.12.11) with ESMTP id j228Nq8F031821
	for <linux-arch@vger.kernel.org>; Wed, 2 Mar 2005 09:23:52 +0100
In-Reply-To: <20050301153000.0aaf5ec2.davem@davemloft.net>
Subject: Re: [PATCH] set_pte() part 1 (was Re: [PATCH] ppc32: Wrong vaddr in flush_hash_one_pte())
Message-ID: <OF3ACFEB2C.D58E6D6B-ON41256FB8.002D58E5-41256FB8.002E20EF@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Wed, 2 Mar 2005 09:23:50 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
To: "David S. Miller" <davem@davemloft.net>
Cc: benh@au1.ibm.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

> But you will need to address this should you ever want to
> experiment with batched TLB flushing.  And I highly encourage
> anyone with TLBs lacking true range flushing in hardware to
> do so :-)  It is such an incredible improvement.

IDTE would be the instruction of choise on s390 for tlb range
flushing. I wanted to do some tlb work anyway to get rid of
the repeated flushes after process exit. There is no need to
flush every 500 odd pages, once is enough.

blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH
