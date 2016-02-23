Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-db5eur01on0044.outbound.protection.outlook.com ([104.47.2.44]:13664
	"EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751190AbcBWMcd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 23 Feb 2016 07:32:33 -0500
From: Noam Camus <noamca@mellanox.com>
Subject: RE: Interesting csd deadlock on ARC
Date: Tue, 23 Feb 2016 10:58:29 +0000
Message-ID: <HE1PR05MB162584392E880F4306659593AAA40@HE1PR05MB1625.eurprd05.prod.outlook.com>
References: <56C6BA82.1060909@synopsys.com> <56CBEC66.2030401@synopsys.com>
 <20160223095824.GH6356@twins.programming.kicks-ass.net>
 <56CC32A3.5020804@synopsys.com>
 <20160223103950.GJ6356@twins.programming.kicks-ass.net>
In-Reply-To: <20160223103950.GJ6356@twins.programming.kicks-ass.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, Frederic Weisbecker <fweisbec@gmail.com>, lkml <linux-kernel@vger.kernel.org>, arcml <linux-snps-arc@lists.infradead.org>
Message-ID: <20160223105829.A8luq_LEZuPuE51PhpyGWY_ewRHXXrfczWuPnGSGzh0@z>

>From: Peter Zijlstra [mailto:peterz@infradead.org] 
>Sent: Tuesday, February 23, 2016 12:40 PM

>The only requirement for irq_work is that it runs after the NMI completes and runs from regular IRQ context. >There are no strict interrupt priority requirements, only that it happens.

We here already use self IPI and irq_work on ARC (with no NMI concerns).
Please see patch at:
https://github.com/EZchip/linux/commit/e42556738e610295f917c79dae166373cd11de88

Noam
