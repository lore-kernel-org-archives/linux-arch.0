From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: perf documentation (was Re: [PATCH v3 3/6] ARCv2: perf: Support
 sampling events using overflow interrupts)
Date: Mon, 19 Oct 2015 15:31:51 +0530
Message-ID: <5624BF8F.1050006@synopsys.com>
References: <1440426023-2792-1-git-send-email-abrodkin@synopsys.com>
 <1440426023-2792-4-git-send-email-abrodkin@synopsys.com>
 <20150826131225.GD19282@twins.programming.kicks-ass.net>
 <20150826142547.GK18673@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:50669 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182AbbJSKCM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 19 Oct 2015 06:02:12 -0400
In-Reply-To: <20150826142547.GK18673@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Vineet.Gupta1@synopsys.com, arc-linux-dev@synopsys.com, arnd@arndb.de, Arnaldo Carvalho de Melo <acme@kernel.org>

On Wednesday 26 August 2015 07:55 PM, Peter Zijlstra wrote:
> On Wed, Aug 26, 2015 at 03:12:25PM +0200, Peter Zijlstra wrote:
>> On Mon, Aug 24, 2015 at 05:20:20PM +0300, Alexey Brodkin wrote:
>>> @@ -295,6 +317,16 @@ static int arc_pmu_add(struct perf_event *event, int flags)
>>>  	}
>>>  
>>>  	write_aux_reg(ARC_REG_PCT_INDEX, idx);
>>> +
>>> +	arc_pmu->act_counter[idx] = event;
>>> +
>>> +	if (is_sampling_event(event)) {
>>> +		/* Mimic full counter overflow as other arches do */
>>> +		write_aux_reg(ARC_REG_PCT_INT_CNTL, (u32)arc_pmu->max_period);
>>> +		write_aux_reg(ARC_REG_PCT_INT_CNTH,
>>> +			      (arc_pmu->max_period >> 32));
>>> +	}
>>> +
>>
>> pmu::add should call pmu::start when PERF_EF_START, without that it
>> should not start the counter, only schedule it.
>>
>> (although currently all pmu::add() calls will have EF_START set)
>>
>>>  	write_aux_reg(ARC_REG_PCT_CONFIG, 0);
>>>  	write_aux_reg(ARC_REG_PCT_COUNTL, 0);
>>>  	write_aux_reg(ARC_REG_PCT_COUNTH, 0);
> 
> Does the below clarify things a bit? If there's still some uncertainty
> please say what/where and I'll try and expand.


Peter this is awesome documentation and would be a shame to get lost in lkml
archives. Can it please make it's way into git :-)

> 
> 
> 
> ---
>  include/linux/perf_event.h | 100 +++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 87 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 2027809433b3..8f78a0b7bfe5 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -140,27 +140,60 @@ struct hw_perf_event {
>  		};
>  #endif
>  	};
> +	/*
> +	 * If the event is a per task event, this will point to the task in
> +	 * question. See the comment in perf_event_alloc().
> +	 */
>  	struct task_struct		*target;
> +
> +/*
> + * hw_perf_event::state flags; used to track the PERF_EF_* state.
> + */
> +#define PERF_HES_STOPPED	0x01 /* the counter is stopped */
> +#define PERF_HES_UPTODATE	0x02 /* event->count up-to-date */
> +#define PERF_HES_ARCH		0x04
> +
>  	int				state;
> +
> +	/*
> +	 * The last observed hardware counter value, updated with a
> +	 * local64_cmpxchg() such that pmu::read() can be called nested.
> +	 */
>  	local64_t			prev_count;
> +
> +	/*
> +	 * The period to start the next sample with.
> +	 */
>  	u64				sample_period;
> +
> +	/*
> +	 * The period we started this sample with.
> +	 */
>  	u64				last_period;
> +
> +	/*
> +	 * However much is left of the current period; note that this is
> +	 * a full 64bit value and allows for generation of periods longer
> +	 * than hardware might allow.
> +	 */
>  	local64_t			period_left;
> +
> +	/*
> +	 * State for throttling the event, see __perf_event_overflow() and
> +	 * perf_adjust_freq_unthr_context().
> +	 */
>  	u64                             interrupts_seq;
>  	u64				interrupts;
>  
> +	/*
> +	 * State for freq target events, see __perf_event_overflow() and
> +	 * perf_adjust_freq_unthr_context().
> +	 */
>  	u64				freq_time_stamp;
>  	u64				freq_count_stamp;
>  #endif
>  };
>  
> -/*
> - * hw_perf_event::state flags
> - */
> -#define PERF_HES_STOPPED	0x01 /* the counter is stopped */
> -#define PERF_HES_UPTODATE	0x02 /* event->count up-to-date */
> -#define PERF_HES_ARCH		0x04
> -
>  struct perf_event;
>  
>  /*
> @@ -210,7 +243,19 @@ struct pmu {
>  
>  	/*
>  	 * Try and initialize the event for this PMU.
> -	 * Should return -ENOENT when the @event doesn't match this PMU.
> +	 *
> +	 * Returns:
> +	 *  -ENOENT	-- @event is not for this PMU
> +	 *
> +	 *  -ENODEV	-- @event is for this PMU but PMU not present
> +	 *  -EBUSY	-- @event is for this PMU but PMU temporarily unavailable
> +	 *  -EINVAL	-- @event is for this PMU but @event is not valid
> +	 *  -EOPNOTSUPP -- @event is for this PMU, @event is valid, but not supported
> +	 *  -EACCESS	-- @event is for this PMU, @event is valid, but no privilidges
> +	 *
> +	 *  0		-- @event is for this PMU and valid
> +	 *
> +	 * Other error return values are allowed.
>  	 */
>  	int (*event_init)		(struct perf_event *event);
>  
> @@ -221,27 +266,56 @@ struct pmu {
>  	void (*event_mapped)		(struct perf_event *event); /*optional*/
>  	void (*event_unmapped)		(struct perf_event *event); /*optional*/
>  
> +	/*
> +	 * Flags for ->add()/->del()/ ->start()/->stop(). There are
> +	 * matching hw_perf_event::state flags.
> +	 */
>  #define PERF_EF_START	0x01		/* start the counter when adding    */
>  #define PERF_EF_RELOAD	0x02		/* reload the counter when starting */
>  #define PERF_EF_UPDATE	0x04		/* update the counter when stopping */
>  
>  	/*
> -	 * Adds/Removes a counter to/from the PMU, can be done inside
> -	 * a transaction, see the ->*_txn() methods.
> +	 * Adds/Removes a counter to/from the PMU, can be done inside a
> +	 * transaction, see the ->*_txn() methods.
> +	 *
> +	 * The add/del callbacks will reserve all hardware resources required
> +	 * to service the event, this includes any counter constraint
> +	 * scheduling etc.
> +	 *
> +	 * Called with IRQs disabled and the PMU disabled.
> +	 *
> +	 * ->add() called without PERF_EF_START should result in the same state
> +	 *  as ->add() followed by ->stop().
> +	 *
> +	 * ->del() must always PERF_EF_UPDATE stop an event. If it calls
> +	 *  ->stop() that must deal with already being stopped without
> +	 *  PERF_EF_UPDATE.
>  	 */
>  	int  (*add)			(struct perf_event *event, int flags);
>  	void (*del)			(struct perf_event *event, int flags);
>  
>  	/*
> -	 * Starts/Stops a counter present on the PMU. The PMI handler
> -	 * should stop the counter when perf_event_overflow() returns
> -	 * !0. ->start() will be used to continue.
> +	 * Starts/Stops a counter present on the PMU.
> +	 *
> +	 * The PMI handler should stop the counter when perf_event_overflow()
> +	 * returns !0. ->start() will be used to continue.
> +	 *
> +	 * Also used to change the sample period.
> +	 *
> +	 * ->stop() with PERF_EF_UPDATE will read the counter and update
> +	 *  period/count values like ->read() would.
> +	 *
> +	 * ->start() with PERF_EF_RELOAD will reprogram the the counter
> +	 *  value, must be preceded by a ->stop() with PERF_EF_UPDATE.
>  	 */
>  	void (*start)			(struct perf_event *event, int flags);
>  	void (*stop)			(struct perf_event *event, int flags);
>  
>  	/*
>  	 * Updates the counter value of the event.
> +	 *
> +	 * For sampling capable PMUs this will also update the software period
> +	 * hw_perf_event::period_left field.
>  	 */
>  	void (*read)			(struct perf_event *event);
>  
> 
