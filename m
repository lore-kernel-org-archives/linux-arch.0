From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V2 18/19] clocksource: add C-SKY clocksource drivers
Date: Thu, 5 Jul 2018 11:23:36 +0200
Message-ID: <afdcf591-31cd-7610-0ff6-e345895ce4a4@linaro.org>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <aba005fd5005c066a2e3d760c334bb55f902d771.1530465326.git.ren_guo@c-sky.com>
 <bc765809-2d97-5ff8-d2ac-65479ce91ef2@linaro.org>
 <20180705033020.GA8023@guoren>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180705033020.GA8023@guoren>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

On 05/07/2018 05:30, Guo Ren wrote:

[ ... ]

>>
>> You can get the value from the timer-of in all the places it is needed.
> Ok, I could remove them.
> 
> But in csky_timer_v1_init: ret = timer_of_init(np, to)
> We only init 1th cpu's timer_of struct, and others just static inited by:
> 
> DEFINE_PER_CPU(struct timer_of, csky_to) = {
> 	.flags = TIMER_OF_CLOCK | TIMER_OF_IRQ,
> 
> 	.clkevt = {
> 		.name = "C-SKY SMP Timer V1",
> 		.rating = 300,
> 		.features = CLOCK_EVT_FEAT_PERCPU | CLOCK_EVT_FEAT_ONESHOT,
> 		.set_state_shutdown		= csky_timer_shutdown,
> 		.set_state_oneshot		= csky_timer_oneshot,
> 		.set_state_oneshot_stopped	= csky_timer_oneshot_stopped,
> 		.set_next_event			= csky_timer_set_next_event,
> 	},
> 
> 	.of_irq = {
> 		.handler = timer_interrupt,
> 		.flags = IRQF_TIMER,
> 		.percpu = 1,
> 	},
> };
> 
> So I still need "for_each_cpu(cpu, cpu_possible_mask)" to init every
> csky_to ...

That is what is unclear for me. percpu or IRQF_PERCPU ?

Have a look at the commit 9995f4f184613fb02ee73092b03545520a72b104,
changelog and the comment in the init function.

Can you give a similar description for this timer ?

[ ... ]


>>> +struct clocksource csky_clocksource = {
>>> +	.name = "csky_timer_v1_clksrc",
>>
>> "csky"
> struct clocksource csky_clocksource = {
> 	.name = "csky,mptimer",
> Hmm?

Yes

[ ... ]

>> v1, v2, etc ... has no sense here.
> TIMER_OF_DECLARE(csky_610, "nationachip,ck610-timer", natchip_timer_init);
> TIMER_OF_DECLARE(csky_807, "csky,ck807-timer", csky_timer_init);
> TIMER_OF_DECLARE(csky_810, "csky,ck810-timer", csky_timer_init);
> TIMER_OF_DECLARE(csky_860, "csky,ck860-timer", csky_timer_init);
> TIMER_OF_DECLARE(csky_860mp, "csky,ck860-mptimer", csky_mptimer_init);
> 
> Hmm?

Yep, fine.

>>> +#define STATUS_clr	BIT(0)
>>> +
>>> +#define CONTRL_rst	BIT(0)
>>> +#define CONTRL_start	BIT(1)
>>> +
>>> +#define CONFIG_en	BIT(0)
>>> +#define CONFIG_irq_en	BIT(1)
>>
>> Prefix the macros with a shortened timer name and don't mix lower case
>> and uppercase.
> Ok.
> 
> #define STATUS_CLR	BIT(0)
> 
> #define CONTRL_RST	BIT(0)
> #define CONTRL_START	BIT(1)
> 
> #define CONFIG_EN	BIT(0)
> #define CONFIG_IRQ_EN	BIT(1)

NATCHIP_STATUS_CLR
NATCHIP_CONTROL_RST
NATCHIP_CONTROL_START

NATCHIP_CONFIG_EN
NATCHIP_CONFIG_IRQ_EN

>> NC_ is too short, something like NATCHIP may be better.
> Ok, good name.
> 
>>> +static irqreturn_t timer_interrupt(int irq, void *dev)
>>
>> Fix the function name.
> static irqreturn_t natchip_timer_interrupt(int irq, void *dev)
> Hmm?

Fine.

>>> +static struct timer_of to = {
>>> +	.flags = TIMER_OF_IRQ | TIMER_OF_BASE | TIMER_OF_CLOCK,
>>> +
>>> +	.clkevt = {
>>> +		.name = TIMER_NAME,
>>
>> Let the node name.
> Ok, remove it.
>  
>>> +		.rating = 300,
>>> +		.features = CLOCK_EVT_FEAT_DYNIRQ | CLOCK_EVT_FEAT_PERIODIC |
>>> +			CLOCK_EVT_FEAT_ONESHOT,
>>> +		.set_state_shutdown	= nc_timer_shutdown,
>>> +		.set_state_periodic	= nc_timer_set_periodic,
>>> +		.set_next_event		= nc_timer_set_next_event,
>>
>> set_oneshot ?
> Yes oneshort, but also could support periodic. But in fact, it only
> works with oneshort.

In the flags, it is specified periodic and oneshot but only the
set_periodic ops is set.

[ ... ]

>>> +	div = timer_of_rate(&to)/TIMER_FREQ - 1;
>>
>> space ' / '
>>
>> Is it
>>   (timer_of_rate(&to) / TIMER_FREQ) - 1
>> or
>>   timer_of_rate(&to) / (TIMER_FREQ - 1)
>>
>> ?
> Thx, I'll modify it like this:
> div = (timer_of_rate(&to) / TIMER_FREQ) - 1;

I wanted to be sure it wasn't the latter. In this case, you don't need
parenthesis, so just add the spaces around the '/' operator.




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
