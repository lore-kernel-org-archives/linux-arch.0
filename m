From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Interesting csd deadlock on ARC
Date: Tue, 23 Feb 2016 11:39:50 +0100
Message-ID: <20160223103950.GJ6356@twins.programming.kicks-ass.net>
References: <56C6BA82.1060909@synopsys.com> <56CBEC66.2030401@synopsys.com>
 <20160223095824.GH6356@twins.programming.kicks-ass.net>
 <56CC32A3.5020804@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <56CC32A3.5020804@synopsys.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, Frederic Weisbecker <fweisbec@gmail.com>, lkml <linux-kernel@vger.kernel.org>, Noam Camus <noamc@ezchip.com>, arcml <linux-snps-arc@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Feb 23, 2016 at 03:51:23PM +0530, Vineet Gupta wrote:
> > 
> > Now the distinct difference between arch_irq_work_raise() and
> > arch_send_call_function_single_ipi() is that arch_irq_work_raise()
> > should be NMI-safe.
> 
> Ok - so when I implement interrupt priorities (aka NMI for ARC), this needs to be
> highest.

So on x86 the issue is that the NMI can interrupt someone else writing
to the lapic. So there's a bit of extra care to be taken.

If your platform doesn't suffer such issues, then that should be fine.

The only requirement for irq_work is that it runs after the NMI
completes and runs from regular IRQ context. There are no strict
interrupt priority requirements, only that it happens.

> > I seem to have forgotten the status of NMIs on ARC, but this is
> > something to make a note of.
> 
> Not had a chance to go back to it since we last discussed.
> I've just been swamped with bug fixing like this one :-(

Yeah, I'm familiar with the problem ...
