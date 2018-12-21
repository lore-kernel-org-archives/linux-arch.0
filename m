From: Vineet Gupta <vineet.gupta1@synopsys.com>
Subject: Re: [PATCH 2/2] ARC: show_regs: fix lockdep splat for good
Date: Fri, 21 Dec 2018 09:55:34 -0800
Message-ID: <8b3739f1-a7d5-7253-362a-3a1c707b0f6d@synopsys.com>
References: <1545159239-30628-1-git-send-email-vgupta@synopsys.com>
 <1545159239-30628-3-git-send-email-vgupta@synopsys.com>
 <20181220130450.GB17350@dhcp22.suse.cz>
 <C2D7FE5348E1B147BCA15975FBA23075014642389B@US01WEMBX2.internal.synopsys.com>
 <20181221130404.GF16107@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181221130404.GF16107@dhcp22.suse.cz>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Hocko <mhocko@kernel.org>
Cc: "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-arch.vger.kernel.org

On 12/21/18 5:04 AM, Michal Hocko wrote:
>> I presume you are referring to original commit, not my anti-change in ARC code,
>> which is actually re-enabling it.
> 
> Yes, but you are building on a broken concept I believe.

Not sure where this is heading. Broken concept was introduced by disabling
preemption around show_regs() to silence x86 smp_processor_id() splat in 2009.

> What
> implications does re-enabling really have ? Now you could reschedule and> you can move to another CPU. Is this really safe?

From initial testing, none so far. show_regs() is simply pretty printing the
passed pt_regs and decoding the current task, which agreed could move to a
different CPU (likely will due to console/printk calls), but I don't see how that
could mess up its mm or othe rinternal plumbing which it prints.


> I believe that yes
> because the preemption disabling is simply bogus. Which doesn't sound
> like a proper justification, does it?

[snip]

> I do not follow. If there is some path to require show_regs to run with
> preemption disabled while others don't then something is clearly wrong.

[snip]

> Yes, the fix might be more involved but I would much rather prefer a
> correct code which builds on solid assumptions.

Right so the first step is reverting the disabled semantics for ARC and do some
heavy testing to make sure any fallouts are addressed etc. And if that works, then
propagate this change to core itself. Low risk strategy IMO - agree ?

Thx,
-Vineet
