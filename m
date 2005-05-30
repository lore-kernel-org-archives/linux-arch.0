Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.12.10/8.12.10) with ESMTP id j4UB2uC8185064
	for <linux-arch@vger.kernel.org>; Mon, 30 May 2005 11:02:56 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j4UB2tl5133008
	for <linux-arch@vger.kernel.org>; Mon, 30 May 2005 13:02:55 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11/8.13.3) with ESMTP id j4UB2tcm028596
	for <linux-arch@vger.kernel.org>; Mon, 30 May 2005 13:02:55 +0200
In-Reply-To: <4299523F.90502@yahoo.com.au>
Subject: Re: Lots of possible arch breakage in cpu_idle!!
Message-ID: <OF7BE04D3C.BB28882F-ONC1257011.003BCCE8-C1257011.003C987D@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Mon, 30 May 2005 13:01:52 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Chris Zankel <czankel@tensilica.com>, Ingo Molnar <mingo@elte.hu>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Hi Nick,

> s390 - local irq disable before checking need_resched doesn't gain
>         anything (removed, OK?)

Well, currently there seems to be only the pfault interrupt that can
set TIF_NEED_RESCHED and pfault interrupts can't happen for idle. So
it should work. But if there is any chance that an interrupt will ever
set TIF_NEED_RESCHED we have to disable the interrupts before doing
the resched check. As I implemented this I wanted to make absolutly
sure that we don't miss any reschedule. It works the way it is and
the additional cycles in idle() for local_irq_disable/local_irq_enable
won't hurt. I don't see the benefit of the change. Only chances that
it might break something we haven't thought of.

blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH
