Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:35215 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932171AbcBXEpx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 23 Feb 2016 23:45:53 -0500
Subject: Re: Interesting csd deadlock on ARC
References: <56C6BA82.1060909@synopsys.com> <56CBEC66.2030401@synopsys.com>
 <20160223095824.GH6356@twins.programming.kicks-ass.net>
 <56CC32A3.5020804@synopsys.com>
 <20160223103950.GJ6356@twins.programming.kicks-ass.net>
 <HE1PR05MB162584392E880F4306659593AAA40@HE1PR05MB1625.eurprd05.prod.outlook.com>
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <56CD356E.3010704@synopsys.com>
Date: Wed, 24 Feb 2016 10:15:34 +0530
MIME-Version: 1.0
In-Reply-To: <HE1PR05MB162584392E880F4306659593AAA40@HE1PR05MB1625.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Noam Camus <noamca@mellanox.com>, Peter Zijlstra <peterz@infradead.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, Frederic Weisbecker <fweisbec@gmail.com>, lkml <linux-kernel@vger.kernel.org>, arcml <linux-snps-arc@lists.infradead.org>
Message-ID: <20160224044534.0hNynvD3tcT5wMgMyfgftBqvn6GhMjxmc_PaiHfv1G8@z>

On Tuesday 23 February 2016 04:28 PM, Noam Camus wrote:
>> From: Peter Zijlstra [mailto:peterz@infradead.org] 
>> Sent: Tuesday, February 23, 2016 12:40 PM
> 
>> The only requirement for irq_work is that it runs after the NMI completes and runs from regular IRQ context. >There are no strict interrupt priority requirements, only that it happens.
> 
> We here already use self IPI and irq_work on ARC (with no NMI concerns).
> Please see patch at:
> https://github.com/EZchip/linux/commit/e42556738e610295f917c79dae166373cd11de88

So this relies on 2nd level intc providing the IPI.
For UP we still need the software triggered interrupt provided by core intc.

