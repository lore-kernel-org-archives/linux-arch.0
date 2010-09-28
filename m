From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH 6/6] sh: oprofile: Use perf-events oprofile backend
Date: Tue, 28 Sep 2010 09:33:56 +0100
Message-ID: <20100928083355.GA4037@console-pimps.org>
References: <cover.1284357372.git.matt@console-pimps.org> <e75f8fa563b4bfb2b4cf62fe64ae398ea5e1831a.1284357372.git.matt@console-pimps.org> <20100916143254.GC13563@erda.amd.com> <20100927200138.GG28588@console-pimps.org> <20100927220703.GV13563@erda.amd.com> <20100927222627.GH28588@console-pimps.org> <20100927224551.GX13563@erda.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100927224551.GX13563@erda.amd.com>
Sender: linux-sh-owner@vger.kernel.org
To: Robert Richter <robert.richter@amd.com>
Cc: Will Deacon <will.deacon@arm.com>, Paul Mundt <lethal@linux-sh.org>, Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, Frederic Weisbecker <fweisbec@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Sep 28, 2010 at 12:45:51AM +0200, Robert Richter wrote:
> On 27.09.10 18:26:27, Matt Fleming wrote:
> > 
> > I don't see why we should pollute the perf namespace with a function
> > that is only being used inside the SH oprofile code? There would be
> > exactly one use of this function and I doubt the perf guys will want
> > this function exposed. In it's current state, it really is no use to any
> > architecture other than SH.
> > 
> > We can always add a generic perf_pmu_name() function later if needed,
> > but it's definitely not needed at the moment.
> 
> Ok, so then let's implement sh_pmu_name() in
> arch/sh/oprofile/common.c, we import asm/perf_event.h to get access to
> struct sh_pmu. This could be implemented as a static function then and
> we also get rid of this interface thing.

That seems OK to me s'long as Paul (the author of the perf events code
for SH) doesn't have a problem with us exposing the struct sh_pmu *
outside of arch/sh/kernel/perf_event.c
