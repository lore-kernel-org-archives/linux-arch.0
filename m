From: Noam Camus <noamca@mellanox.com>
Subject: RE: Interesting csd deadlock on ARC
Date: Tue, 23 Feb 2016 10:58:29 +0000
Message-ID: <HE1PR05MB162584392E880F4306659593AAA40@HE1PR05MB1625.eurprd05.prod.outlook.com>
References: <56C6BA82.1060909@synopsys.com> <56CBEC66.2030401@synopsys.com>
 <20160223095824.GH6356@twins.programming.kicks-ass.net>
 <56CC32A3.5020804@synopsys.com>
 <20160223103950.GJ6356@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160223103950.GJ6356@twins.programming.kicks-ass.net>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Peter Zijlstra <peterz@infradead.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, arcml <linux-snps-arc@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>
List-Id: linux-arch.vger.kernel.org

>From: Peter Zijlstra [mailto:peterz@infradead.org] 
>Sent: Tuesday, February 23, 2016 12:40 PM

>The only requirement for irq_work is that it runs after the NMI completes and runs from regular IRQ context. >There are no strict interrupt priority requirements, only that it happens.

We here already use self IPI and irq_work on ARC (with no NMI concerns).
Please see patch at:
https://github.com/EZchip/linux/commit/e42556738e610295f917c79dae166373cd11de88

Noam
