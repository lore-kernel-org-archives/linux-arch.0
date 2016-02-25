From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Interesting csd deadlock on ARC
Date: Thu, 25 Feb 2016 15:06:54 +0100
Message-ID: <20160225140654.GL6357@twins.programming.kicks-ass.net>
References: <56C6BA82.1060909@synopsys.com> <56CBEC66.2030401@synopsys.com>
 <20160223095824.GH6356@twins.programming.kicks-ass.net>
 <56CD36CD.2080303@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <56CD36CD.2080303@synopsys.com>
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
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, Marc Zyngier <marc.zyngier@arm.com>, Frederic Weisbecker <fweisbec@gmail.com>, lkml <linux-kernel@vger.kernel.org>, Noam Camus <noamc@ezchip.com>, arcml <linux-snps-arc@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Feb 24, 2016 at 10:21:25AM +0530, Vineet Gupta wrote:
> >> What I actually meant was is it OK for irq_work_queue_on() to be called locally
> >> (is this a sched bug/optimization(. Further if it is OK to be called, does it need
> >> to do behave more like irq_work_queue() i.e. call arch_irq_work_raise() or
> >> arch_send_call_function_single_ipi() is expected to handle sending IPI to self !
> > 
> > Right, so I'm not actually sure we started out with this requirement.
> > But you're not the first to run into this, see:
> > 
> >   lkml.kernel.org/r/CAJZ5v0gLankSuziQq25qTCyNqeOX43yD9jnJu_XXwbdyajfmKg@mail.gmail.com
> > 
> > Initially I think irq_work_queue_on() was only used remotely, but I
> > think it makes sense to allow the current cpu, esp. since people seem to
> > be using it like that.
> 
> So it seems Russell's questions in the thread above stands still. IMO we need to
> massage irq_work_queue_on() to handle the case of called for local cpu. This will
> automatically take care of CONFIG_SMP kernel running on UP hardware.

Hmm, I missed that there was still an open question.

Afaict the only thing that needs doing to the generic code is drop the
CONFIG_SMP guard, no?
