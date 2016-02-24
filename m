From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: Interesting csd deadlock on ARC
Date: Wed, 24 Feb 2016 10:15:34 +0530
Message-ID: <56CD356E.3010704@synopsys.com>
References: <56C6BA82.1060909@synopsys.com> <56CBEC66.2030401@synopsys.com>
 <20160223095824.GH6356@twins.programming.kicks-ass.net>
 <56CC32A3.5020804@synopsys.com>
 <20160223103950.GJ6356@twins.programming.kicks-ass.net>
 <HE1PR05MB162584392E880F4306659593AAA40@HE1PR05MB1625.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <HE1PR05MB162584392E880F4306659593AAA40@HE1PR05MB1625.eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Noam Camus <noamca@mellanox.com>, Peter Zijlstra <peterz@infradead.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, Frederic Weisbecker <fweisbec@gmail.com>, lkml <linux-kernel@vger.kernel.org>, arcml <linux-snps-arc@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

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
