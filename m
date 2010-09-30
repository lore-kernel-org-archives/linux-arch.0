From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 6/6] sh: oprofile: Use perf-events oprofile backend
Date: Thu, 30 Sep 2010 09:14:25 +0100
Message-ID: <1285834465.9104.7.camel@e102144-lin.cambridge.arm.com>
References: <cover.1284357372.git.matt@console-pimps.org>
	 <e75f8fa563b4bfb2b4cf62fe64ae398ea5e1831a.1284357372.git.matt@console-pimps.org>
	 <20100916143254.GC13563@erda.amd.com>
	 <20100927200138.GG28588@console-pimps.org>
	 <20100927220703.GV13563@erda.amd.com>
	 <20100927222627.GH28588@console-pimps.org>
	 <20100930010407.GA18073@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20100930010407.GA18073@linux-sh.org>
Sender: linux-sh-owner@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: Matt Fleming <matt@console-pimps.org>, linux-arch@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-sh@vger.kernel.org, Robert Richter <robert.richter@amd.com>, Frederic Weisbecker <fweisbec@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

Paul,

On Thu, 2010-09-30 at 02:04 +0100, Paul Mundt wrote:
> On Mon, Sep 27, 2010 at 11:26:27PM +0100, Matt Fleming wrote:
> > On Tue, Sep 28, 2010 at 12:07:03AM +0200, Robert Richter wrote:
> > > On 27.09.10 16:01:38, Matt Fleming wrote:
> > > > Well, ARM doesn't have names as strings for its pmus currently. What's
> > > > more, ARM wouldn't use it; SH would be the only user of this function. I
> > > > don't think this one makes sense to be a generic function.
> > >
> 
> Er, what? Yes it does. It has this silly id to string mapping thing that
> is at present duplicated between the perf and the oprofile code for no
> reason. Having a generic (albeit optional) perf_pmu_name() would allow
> this to be cleaned up.
> 

It's not as silly as it appears. As you mention below, OProfile uses
strings to identify the correct CPU model in userspace. With ARM, there
is some horrible legacy here which means that the strings are extremely
misleading (arm/mpcore => arm/11mpcore, arm/armv7 => Cortex A8). Rather
than continue this mess into perf, I decided to separate the two and use
a common numeric scheme for when they have to talk to each other.

> > > As the implementation of the function would be optional, why should we
> > > make it architectural?
> >
> > I don't see why we should pollute the perf namespace with a function
> > that is only being used inside the SH oprofile code? There would be
> > exactly one use of this function and I doubt the perf guys will want
> > this function exposed. In it's current state, it really is no use to any
> > architecture other than SH.
> >
> This has nothing at all to do with the SH oprofile code and everything to
> do with oprofile in general. This is the vary basis for the CPU model
> matching in the oprofile userspace tools, it's string based by design.
> Given that we're already seeing architetures double up their strings in
> both places, this really wants a consensus and to be dealt with before
> other architetures start getting the wrong idea.


I agree that if you have sane strings for OProfile then there's no
reason to define new ones for perf.

Will

