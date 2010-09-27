From: Robert Richter <robert.richter@amd.com>
Subject: Re: [PATCH 6/6] sh: oprofile: Use perf-events oprofile backend
Date: Tue, 28 Sep 2010 00:45:51 +0200
Message-ID: <20100927224551.GX13563@erda.amd.com>
References: <cover.1284357372.git.matt@console-pimps.org>
	<e75f8fa563b4bfb2b4cf62fe64ae398ea5e1831a.1284357372.git.matt@console-pimps.org>
	<20100916143254.GC13563@erda.amd.com>
	<20100927200138.GG28588@console-pimps.org>
	<20100927220703.GV13563@erda.amd.com>
	<20100927222627.GH28588@console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20100927222627.GH28588@console-pimps.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Matt Fleming <matt@console-pimps.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <fweisbec@gmail.com>, Will Deacon <will.deacon@arm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Paul Mundt <lethal@linux-sh.org>, Ingo Molnar <mingo@elte.hu>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On 27.09.10 18:26:27, Matt Fleming wrote:
> On Tue, Sep 28, 2010 at 12:07:03AM +0200, Robert Richter wrote:
> > On 27.09.10 16:01:38, Matt Fleming wrote:
> > > On Thu, Sep 16, 2010 at 04:32:54PM +0200, Robert Richter wrote:
> > > > > diff --git a/arch/sh/kernel/perf_event.c b/arch/sh/kernel/perf_event.c
> > > > > index 2cb9ad5..3c3fc9a 100644
> > > > > --- a/arch/sh/kernel/perf_event.c
> > > > > +++ b/arch/sh/kernel/perf_event.c
> > > > > @@ -59,6 +59,14 @@ static inline int sh_pmu_initialized(void)
> > > > >  	return !!sh_pmu;
> > > > >  }
> > > > >  
> > > > > +const char *sh_pmu_name(void)
> > > > > +{
> > > > > +	if (!sh_pmu)
> > > > > +		return NULL;
> > > > > +
> > > > > +	return sh_pmu->name;
> > > > > +}
> > > > 
> > > > Couldn't we make this a generic function like perf_num_counters()?
> > > 
> > > Well, ARM doesn't have names as strings for its pmus currently. What's
> > > more, ARM wouldn't use it; SH would be the only user of this function. I
> > > don't think this one makes sense to be a generic function.
> > 
> > I didn't catch this with my first review, the function will need an
> > EXPORT_SYMBOL_GPL() to allow building modules. This will mean an
> > interface extension what should be non-arch. So, for architectures we
> > need the pmu name like SH we just implement the generic function. For
> > ARM we don't need to provide this function.
> 
> Yeah my bad, I just hit this EXPORT_SYMBOL_GPL issue when compiling
> oprofile as a module.
> 
> > Most of the interface is defined in linux/perf_event.h. We shouldn't
> > move this to asm/perf_event.h, so this is one more argument for the
> > non-arch implementation.
> 
> I'm not advocating moving this function to asm/perf_event.h.
> 
> > As the implementation of the function would be optional, why should we
> > make it architectural?
> 
> I don't see why we should pollute the perf namespace with a function
> that is only being used inside the SH oprofile code? There would be
> exactly one use of this function and I doubt the perf guys will want
> this function exposed. In it's current state, it really is no use to any
> architecture other than SH.
> 
> We can always add a generic perf_pmu_name() function later if needed,
> but it's definitely not needed at the moment.

Ok, so then let's implement sh_pmu_name() in
arch/sh/oprofile/common.c, we import asm/perf_event.h to get access to
struct sh_pmu. This could be implemented as a static function then and
we also get rid of this interface thing.

-Robert

-- 
Advanced Micro Devices, Inc.
Operating System Research Center
