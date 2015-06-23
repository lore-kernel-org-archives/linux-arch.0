From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH 1/8] ARC: perf: support RAW events
Date: Tue, 23 Jun 2015 17:50:49 +0530
Message-ID: <55894F21.2040706@synopsys.com>
References: <1433852372-29494-1-git-send-email-vgupta@synopsys.com> <1433852372-29494-2-git-send-email-vgupta@synopsys.com> <20150615153029.GE3644@twins.programming.kicks-ass.net> <4881796E12491D4BB15146FE0209CE64656C9E81@DE02WEMBXB.internal.synopsys.com> <20150617133358.GR3644@twins.programming.kicks-ass.net> <55817FDD.7060902@synopsys.com> <20150622144157.GV3644@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150622144157.GV3644@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, jolsa@kernel.org
List-Id: linux-arch.vger.kernel.org

On Monday 22 June 2015 08:11 PM, Peter Zijlstra wrote:
> On Wed, Jun 17, 2015 at 07:40:37PM +0530, Vineet Gupta wrote:
>>> I would much prefer the raw thing to remain a number; it puts you in
>>> pretty much the same place as most other archs, including x86.
>>
>> Sure, but that doesn't mean we start using the index of event as a raw ID. There
>> are zillion ways to configure cores and the index will certainly start varying.
>> Which means that user has to determine at run time (using whatever /proc/xxx) what
>> crun corresponds to. Why inflict such pain on poor guy.
>>
>> The current raw event, despite representing an ASCII string is still a u64 number.
>> So it is not more "raw" than what others have. We can get rid of the swapping
>> business when setting up a raw event, by making sure that cached values from probe
>> are already in same format.
>>
>> But using index as a event id is no go sorry...
> 
> Well, you're still stuck converting an 8 char ASCII string to hex, which
> arguably isn't too hard, but still rather ugly.

I agree that it might not be pretty, but using the h/w index as raw event ID is
not feasible since it is not ABI stable. ARC cores are highly configurable and if
u strip out a component, the related counters vanish, so the index of same counter
can change across h/w builds for say 16k vs. 32k L1 dcache builds.

Arguably we could setup a /proc or sysfs entry for mapping which user would have
to lookup. But it is not as clean/obvious as him looking up the Processor Manual
which describes the conditions with a human readable name - after all our
designers went to a stretch, to really call them out by names and not some obscure
numbers :-)

So I presume that we agree with not using h/w index itself for ID and need to look
for on/more solutions you allude to below.

> Furthermore, the 'raw' interface is what is used to pass in hardware
> configuration otherwise not exposed. If all you currently have is event
> idx that's not too interesting.
> 
> However, your patch 6 already introduces event modifiers:
> 
> +#define ARC_REG_PCT_CONFIG_USER        (1 << 18)       /* count in user mode */
> +#define ARC_REG_PCT_CONFIG_KERN        (1 << 19)       /* count in kernel mode */
> 
> Those should also be available through the raw interface.
> 
> That is, your perf_event_attr::config should pretty much end up in your
> hardware unmodified -- with the obvious exception of things like
> 'interrupt enable' because we want the kernel to be in control of that.

The value which goes in hardware is h/w index, which we can't pass from userspace
due to ABI reasons I describe above. Some alteration has to be made to any value
we pass from userspace, before it goes into the pct itself.

> 
> So if you 'overload' your TYPE_RAW to mean something else entirely, you
> also loose the ability to specify event modifiers not otherwise modelled
> in perf.

Just like normal events, raw event specification also allows :u or :k suffix,
which are passed additionally as event->attr.exclude_{user,kernel}
But I understand you POV here.

> There are things you could do though; you could for instance interpret a
> !0 perf_event_attr::config1 as the name field and replace the
> perf_event_attr::config's event idx with whatever comes out of that
> name->idx map -- and/or require perf_event_attr::config's event idx to
> be 0 in that case.
> 
> This of course assumes there will never be an other valid use for
> ::config1.

Indeed that could be done, I don't think ARC PCT will have more use of config1.
And perhaps if it does, then there's config2 for future needs !


> Alternatively you can register a second pmu "cpu_name" and interpret its
> ::config as the name.
> 
> 
> Also, ideally you'd convince acme/jolsa to extend the event parser with
> this 8-char ASCII format so you can do all the text munging in userspace
> and not have to do the ugly you propose here.

So lets say such parsing facility did exist, what would it pass down to kernel. It
can't be the h/w index itself, so it has to be some other number which we then map
to the h/w index when setting up the event - so again it helps if that number is
what is present in prog ref manual.

FWIW, last time I'd proposed that we can stop the ugly looking string conversion
in raw event setup code, but it still won't be the exact raw value which goes into
h/w. Something like completely untested below:
--------------->

+static int arc_pmu_raw_event(u64 config)
+{
+       int i;
+
+       for (i = 0; i < arc_pmu->n_events; i++) {
+               if (config == arc_pmu->raw_events[i])
+                       return i;
+       }
+
+       return -ENOENT;
+}
+

@@ -309,6 +334,21 @@ static int arc_pmu_device_probe(struct platform_device *pdev)
                cc_name.indiv.word0 = read_aux_reg(ARC_REG_CC_NAME0);
                cc_name.indiv.word1 = read_aux_reg(ARC_REG_CC_NAME1);

+               /*
+                * In PCT register CC_NAME{0,1} event name string[] is saved
+                * from LSB side:
+                * e.g. cycles corresponds to "crun" and is saved as 0x6e757263
+                *                                                     n u r c
+                * However in perf cmdline they are specified in human order as
+                * r6372756e
+                *
+                * Thus save a 64bit swapped value for quick cross check at the
+                * time of raw event request
+                */
+               arc_pmu->raw_events[j] = ((u64)cc_name.indiv.word1 << 32) |
+                                               cc_name.indiv.word0;
+               arc_pmu->raw_events[j] = __swab64(arc_pmu->raw_events[j]);
