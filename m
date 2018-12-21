From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 2/2] ARC: show_regs: fix lockdep splat for good
Date: Fri, 21 Dec 2018 14:04:04 +0100
Message-ID: <20181221130404.GF16107@dhcp22.suse.cz>
References: <1545159239-30628-1-git-send-email-vgupta@synopsys.com>
 <1545159239-30628-3-git-send-email-vgupta@synopsys.com>
 <20181220130450.GB17350@dhcp22.suse.cz>
 <C2D7FE5348E1B147BCA15975FBA23075014642389B@US01WEMBX2.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075014642389B@US01WEMBX2.internal.synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vineet Gupta <vineet.gupta1@synopsys.com>
Cc: "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-arch.vger.kernel.org

On Thu 20-12-18 18:45:48, Vineet Gupta wrote:
> On 12/20/18 5:04 AM, Michal Hocko wrote:
> > On Tue 18-12-18 10:53:59, Vineet Gupta wrote:
> >> signal handling core calls ARCH show_regs() with preemption disabled
> >> which causes __might_sleep functions such as mmput leading to lockdep
> >> splat.  Workaround by re-enabling preemption temporarily.
> >>
> >> This may not be as bad as it sounds since the preemption disabling
> >> itself was introduced for a supressing smp_processor_id() warning in x86
> >> code by commit 3a9f84d354ce ("signals, debug: fix BUG: using
> >> smp_processor_id() in preemptible code in print_fatal_signal()")
> > The commit you are referring to here sounds dubious in itself.
> 
> Indeed that was my thought as well, but it did introduce the preemption disabling
> logic aroung core calling show_regs() !
> 
> > We do not
> > want to stick a preempt_disable just to silence a warning.
> 
> I presume you are referring to original commit, not my anti-change in ARC code,
> which is actually re-enabling it.

Yes, but you are building on a broken concept I believe. What
implications does re-enabling really have? Now you could reschedule and
you can move to another CPU. Is this really safe? I believe that yes
because the preemption disabling is simply bogus. Which doesn't sound
like a proper justification, does it?
 
> > show_regs is
> > called from preemptible context at several places (e.g. __warn).
> 
> Right, but do we have other reports which show this, perhaps not too many distros
> have CONFIG__PREEMPT enabled ?

I do not follow. If there is some path to require show_regs to run with
preemption disabled while others don't then something is clearly wrong.

> > Maybe
> > this was not the case in 2009 when the change was introduced but this
> > seems like a relict from the past. So can we fix the actual problem
> > rather than build on top of it instead?
> 
> The best/correct fix is to remove the preempt diabling in core code, but that
> affects every arch out there and will likely trip dormant land mines, needed
> localized fixes like I'm dealing with now.

Yes, the fix might be more involved but I would much rather prefer a
correct code which builds on solid assumptions.

-- 
Michal Hocko
SUSE Labs
