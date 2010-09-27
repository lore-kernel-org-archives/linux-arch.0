From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH 6/6] sh: oprofile: Use perf-events oprofile backend
Date: Mon, 27 Sep 2010 21:01:38 +0100
Message-ID: <20100927200138.GG28588@console-pimps.org>
References: <cover.1284357372.git.matt@console-pimps.org>
 <e75f8fa563b4bfb2b4cf62fe64ae398ea5e1831a.1284357372.git.matt@console-pimps.org>
 <20100916143254.GC13563@erda.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100916143254.GC13563@erda.amd.com>
Sender: linux-sh-owner@vger.kernel.org
To: Robert Richter <robert.richter@amd.com>
Cc: Will Deacon <will.deacon@arm.com>, Paul Mundt <lethal@linux-sh.org>, Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, Frederic Weisbecker <fweisbec@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Sep 16, 2010 at 04:32:54PM +0200, Robert Richter wrote:
> > diff --git a/arch/sh/kernel/perf_event.c b/arch/sh/kernel/perf_event.c
> > index 2cb9ad5..3c3fc9a 100644
> > --- a/arch/sh/kernel/perf_event.c
> > +++ b/arch/sh/kernel/perf_event.c
> > @@ -59,6 +59,14 @@ static inline int sh_pmu_initialized(void)
> >  	return !!sh_pmu;
> >  }
> >  
> > +const char *sh_pmu_name(void)
> > +{
> > +	if (!sh_pmu)
> > +		return NULL;
> > +
> > +	return sh_pmu->name;
> > +}
> 
> Couldn't we make this a generic function like perf_num_counters()?

Well, ARM doesn't have names as strings for its pmus currently. What's
more, ARM wouldn't use it; SH would be the only user of this function. I
don't think this one makes sense to be a generic function.
