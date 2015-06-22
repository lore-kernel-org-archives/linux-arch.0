From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH 3/8] ARCv2: perf: implement "event_set_period" for
 future use with interrupts
Date: Mon, 22 Jun 2015 15:26:21 +0000
Message-ID: <1434986780.4269.85.camel@synopsys.com>
References: <1433852372-29494-1-git-send-email-vgupta@synopsys.com>
	 <1433852372-29494-4-git-send-email-vgupta@synopsys.com>
	 <20150615153831.GF3644@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:33089 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753652AbbFVP1C convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Jun 2015 11:27:02 -0400
In-Reply-To: <20150615153831.GF3644@twins.programming.kicks-ass.net>
Content-Language: en-US
Content-ID: <E24E272A357BF94CBDA6674AC4965167@internal.synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "peterz@infradead.org" <peterz@infradead.org>
Cc: "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "acme@kernel.org" <acme@kernel.org>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>

Hi Peter,

On Mon, 2015-06-15 at 17:38 +-0200, Peter Zijlstra wrote:
+AD4- On Tue, Jun 09, 2015 at 05:49:27PM +-0530, Vineet Gupta wrote:
+AD4- +AD4- +AEAAQA- -99,8 +-99,7 +AEAAQA- static void arc+AF8-perf+AF8-event+AF8-update(struct 
+AD4- +AD4- perf+AF8-event +ACo-event,
+AD4- +AD4-     +AH0- while (local64+AF8-cmpxchg(+ACY-hwc-+AD4-prev+AF8-count, prev+AF8-raw+AF8-count,
+AD4- +AD4-                              new+AF8-raw+AF8-count) +ACEAPQ- 
+AD4- +AD4- prev+AF8-raw+AF8-count)+ADs-
+AD4- +AD4-  
+AD4- +AD4- -   delta +AD0- (new+AF8-raw+AF8-count - prev+AF8-raw+AF8-count) +ACY-
+AD4- +AD4- -           ((1ULL +ADwAPA- arc+AF8-pmu-+AD4-counter+AF8-size) - 1ULL)+ADs-
+AD4- +AD4- +-   delta +AD0- (new+AF8-raw+AF8-count - prev+AF8-raw+AF8-count) +ACY- arc+AF8-pmu
+AD4- +AD4- -+AD4-max+AF8-period+ADs-
+AD4- 
+AD4- I don't know how your PMU works, but you seem to be assuming new+AF8-raw
+AD4- prev+AF8-raw, which implies its counting up.
+AD4- 
+AD4- Now, typically these things trigger when they reach 0, so when we're
+AD4- counting up that would mean your values are negative.
+AD4- 
+AD4- In that case, where's the sign extension?

Our HW even counters work that way:
Each counter counts from programmed start value (set in
ARC+AF8-REG+AF8-PCT+AF8-COUNT) to a limit value (set in ARC+AF8-REG+AF8-PCT+AF8-INT+AF8-CNT) and
once limit value is reached this timer generates an interrupt.

Even though this HW implementation allows for more flexibility in Linux
kernel we decided to mimic behavior of other architectures in this way:

 +AFs-1+AF0- Set limit value as half of counter's max value:
 ----------+AD4-8-----------
 arc+AF8-pmu-+AD4-max+AF8-period +AD0- (1ULL +ADwAPA- counter+AF8-size) / 2 - 1ULL+ADs-
 ----------+AD4-8-----------

 +AFs-2+AF0- Set start value as +ACI-arc+AF8-pmu-+AD4-max+AF8-period - sample+AF8-period+ACI- and then
count up to the limit

Our event counters don't stop on reaching max value (the one we set in
ARC+AF8-REG+AF8-PCT+AF8-INT+AF8-CNT) but continue to count until kernel explicitly
stops each of them.

And setting a limit as half of counter capacity is done to allow
capturing of additional events in between moment when interrupt was
triggered until we're actually processing PMU interrupts. That way
we're trying to be more precise.

For example if we count CPU cycles we keep track of cycles while
running through generic IRQ handling code:

 +AFs-1+AF0- We set counter period as say 100+AF8-000 events of type +ACI-crun+ACI-
 +AFs-2+AF0- Counter reaches that limit and raises its interrupt
 +AFs-3+AF0- Once we get in PMU IRQ handler we read current counter value from
ARC+AF8-REG+AF8-PCT+AF8-SNAP ans see there something like 105+AF8-000.

If counters stop on reaching a limit value then we would miss
additional 5000 cycles.

+AD4- 
+AD4- 
+AD4- +AD4- +AEAAQA- -182,6 +-181,13 +AEAAQA- static int arc+AF8-pmu+AF8-event+AF8-init(struct 
+AD4- +AD4- perf+AF8-event +ACo-event)
+AD4- +AD4-     struct hw+AF8-perf+AF8-event +ACo-hwc +AD0- +ACY-event-+AD4-hw+ADs-
+AD4- +AD4-     int ret+ADs-
+AD4- +AD4-  
+AD4- +AD4- +-   if (+ACE-is+AF8-sampling+AF8-event(event)) +AHs-
+AD4- +AD4- +-           hwc-+AD4-sample+AF8-period  +AD0- arc+AF8-pmu-+AD4-max+AF8-period+ADs-
+AD4- +AD4- +-           hwc-+AD4-last+AF8-period +AD0- hwc-+AD4-sample+AF8-period+ADs-
+AD4- +AD4- +-           local64+AF8-set(+ACY-hwc-+AD4-period+AF8-left, hwc
+AD4- +AD4- -+AD4-sample+AF8-period)+ADs-
+AD4- +AD4- +-   +AH0- else
+AD4- +AD4- +-           return -ENOENT+ADs-
+AD4- 
+AD4- -ENOENT is wrong for is+AF8-sampling+AF8-event().
+AD4- 
+AD4- Either the event is for this PMU, in which case you should return a
+AD4- fatal error, or its not (-ENOENT is correct in that case).

Frankly I didn't quite understand that comment.

What is meant in that code - our hardware may have support of
interrupts in HW counters or not. And that is not only dependent on ARC
core version (in fact ARC 700 may have only interrupt-less PMU) but
could be configured during designing of ASIC (i.e. ARC HS38 may have
PMU with or without interrupts).

That's why we check for event type and if we cannot handle it due to
limitation of current HW then we return -ENOENT.

-Alexey
