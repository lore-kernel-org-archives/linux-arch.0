From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH 1/8] ARC: perf: support RAW events
Date: Wed, 17 Jun 2015 18:02:57 +0530
Message-ID: <558168F9.2010101@synopsys.com>
References: <1433852372-29494-1-git-send-email-vgupta@synopsys.com> <1433852372-29494-2-git-send-email-vgupta@synopsys.com> <20150615153029.GE3644@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:34638 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752561AbbFQMeX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 17 Jun 2015 08:34:23 -0400
In-Reply-To: <20150615153029.GE3644@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, arc-linux-dev@synopsys.com, Arnaldo Carvalho de Melo <acme@kernel.org>

On Monday 15 June 2015 09:00 PM, Peter Zijlstra wrote:
> On Tue, Jun 09, 2015 at 05:49:25PM +0530, Vineet Gupta wrote:
>> +/*
>> + * Raw events are specified in hex value of ASCII chars:
>> + *
>> + * In PCT register CC_NAME{0,1} event name string[] is saved from LSB side:
>> + * e.g. cycles corresponds to ARC "crun" and is saved as 0x6e757263
>> + *							    n u r c
>> + * However in perf cmdline they are specified in human order as r6372756e
>> + *
>> + * Thus event from cmdline requires an word swap
>> + */
>> +static int arc_pmu_raw_event(u64 config)
>> +{
>> +	int i;
>> +	char name[sizeof(u64) + 1] = {0};
>> +	u64 swapped = __swab64(config);
>> +
>> +	/* Trim leading zeroes */
>> +	for (i = 0; i < sizeof(u64); i++)
>> +		if (!(swapped & 0xFF))
>> +			swapped = swapped >> 8;
>> +		else
>> +			break;
>> +
>> +	for (i = 0; i < arc_pmu->n_events; i++) {
>> +		if (swapped == arc_pmu->raw_events[i])
>> +			break;
>> +	}
>> +
>> +	if (i == arc_pmu->n_events)
>> +		return -ENOENT;
>> +
>> +	memcpy(name, &swapped, sizeof(u64));
>> +
>> +	pr_debug("Initializing raw event: %s\n", name);
>> +
>> +	return i;
>> +}
> 
> Urgh, what? Why?
> 
> raw is just that _raw_, no mucking about with the value.
> 
> If you want convenience, provide the event/format stuff so you can
> write:
> 
> 	perf record -e 'cpu/c=0xff,r=0cff,u=0xff,n=0xff'
> 
> Or whatever that syntax was again (I keep forgetting).


I'm not too familiar with elaborate raw events from other arches, but it seems
cpu/event style makes sense when there are params (e.g. umask etc) in addition to
event id.

For us raw is just the event id, albeit an ascii string, which can vary from 3 to
8 chars. PMU saves the event name as string in LSB so "crun" is 0x6e757263 which
corresponds to 'n' 'u' 'r' 'c'

The only convenience we are giving the user is ability to specify the raw event as
ASCII string in *human order* which we need to swap around for comparing against
what we have in the driver tables - setup at the time of probe

If you absolutely detest that, we can pre-swap those values in probe to save in
human order.

Perhaps it is batter that way anyways - what say you ?

-Vineet
