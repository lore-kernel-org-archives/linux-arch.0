From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH 6/7] sh: oprofile: Use perf-events oprofile backend
Date: Wed, 6 Oct 2010 20:45:07 +0100
Message-ID: <20101006194507.GA30419@console-pimps.org>
References: <cover.1286222593.git.matt@console-pimps.org>
 <db62cbe463d5bce89196d6456ad386129ce0022a.1286222593.git.matt@console-pimps.org>
 <20101006183549.GW13563@erda.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20101006183549.GW13563@erda.amd.com>
Sender: linux-sh-owner@vger.kernel.org
To: Robert Richter <robert.richter@amd.com>
Cc: Will Deacon <will.deacon@arm.com>, Paul Mundt <lethal@linux-sh.org>, Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, Frederic Weisbecker <fweisbec@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Deng-Cheng Zhu <dengcheng.zhu@gmail.com>, Grant Likely <grant.likely@secretlab.ca>
List-Id: linux-arch.vger.kernel.org

On Wed, Oct 06, 2010 at 08:35:49PM +0200, Robert Richter wrote:
> On 04.10.10 16:44:24, Matt Fleming wrote:
> > Now that we've got a generic perf-events based oprofile backend we might
> > as well make use of it seeing as SH doesn't do anything special with its
> > oprofile backend. Also introduce a new CONFIG_HW_PERF_EVENTS symbol so
> > that we can fallback to using the timer interrupt for oprofile if the
> > CPU doesn't support perf events.
> > 
> > Signed-off-by: Matt Fleming <matt@console-pimps.org>
> > ---
> >  arch/sh/Kconfig            |   13 +++++
> >  arch/sh/oprofile/Makefile  |    4 ++
> >  arch/sh/oprofile/common.c  |  109 ++++---------------------------------------
> >  arch/sh/oprofile/op_impl.h |   33 -------------
> >  4 files changed, 28 insertions(+), 131 deletions(-)
> >  delete mode 100644 arch/sh/oprofile/op_impl.h
> 
> This patch looks good.
> 
> We might merge it with patch 7/7.

This patch was broken out for Paul's benefit to ease review. If he's
happy for me to merge this with 7/7 then that's fine with me.
