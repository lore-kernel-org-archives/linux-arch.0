From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 06/28] kernel: Define gettimeofday vdso common code
Date: Fri, 8 Feb 2019 20:28:07 +0100 (CET)
Message-ID: <alpine.DEB.2.21.1902081950260.1662@nanos.tec.linutronix.de>
References: <20181129170530.37789-1-vincenzo.frascino@arm.com>
 <20181129170530.37789-7-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1811292230430.1657@nanos.tec.linutronix.de>
 <20181207175321.GA11430@edgewater-inn.cambridge.arm.com>
 <20190208173539.GD24375@fuggles.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190208173539.GD24375@fuggles.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Peter Collingbourne <pcc@google.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

Will,

On Fri, 8 Feb 2019, Will Deacon wrote:
> On Fri, Dec 07, 2018 at 05:53:21PM +0000, Will Deacon wrote:
> > Anyway, moving the counter read into the protected region is a little fiddly
> > because the memory barriers we have in there won't give us the ordering we
> > need. We'll instead need to do something nasty, like create a dependency
> > from the counter read to the read of the seqlock:
> > 
> > Maybe the untested crufty hack below, although this will be a nightmare to
> > implement in C.
> 
> We discussed this in person this week, but you couldn't recall the details
> off the top of your head so I'm replying here. Please could you clarify what
> your concern was with the existing code, and whether or not I've got the
> wrong end of the stick?

If you just collect the variables under the seqcount protection and have
the readout of the timer outside of it then you are not guaranteeing
consistent state.

The problem is:

	do {
		seq = read_seqcount_begin(d->seq);
		last = d->cycle_last;
		mult = d->mult;
		shift = d->shift;
		ns = d->ns_base;
	while (read_seqcount_retry(d->seq, seq));

	ns += ((read_clock() - last) * mult);
	ns >>= shift;

So on the first glance this looks consistent because you collect all data
and then do the read and calc outside the loop.

But if 'd->mult' gets updated _before_ read_clock() then you can run into a
situation where time goes backwards with the next read.

Here is the flow you need for that:

t1 = gettime()
     {
	collect_data()

     ---> Interrupt, updates mult (mult becomes smaller)

     	  This can expand over a very long time when the task is scheduled
     	  out here and there are multiple updates in between. The farther
     	  out the read is delayed, the more likely the problem is going to
     	  observable.

     	read_clock_and_calc()
     }

t2 = gettime()
     {
	collect_data()
     	read_clock_and_calc()
     }

This second read uses updated data, i.e. the smaller mult. So depending on
the distance of the two reads and the difference of the mult, the caller
can observe t2 < t1, which is a NONO. You can observe it on a single
CPU. No virt, SMP, migration needed at all.

Thanks,

	tglx
