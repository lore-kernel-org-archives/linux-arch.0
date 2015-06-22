From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH 4/8] ARCv2: perf: Support sampling events using overflow
 interrupts
Date: Mon, 22 Jun 2015 15:57:23 +0000
Message-ID: <1434988643.4269.108.camel@synopsys.com>
References: <1433852372-29494-1-git-send-email-vgupta@synopsys.com>
	 <1433852372-29494-5-git-send-email-vgupta@synopsys.com>
	 <20150615154816.GG3644@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:33740 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751482AbbFVP5a convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Jun 2015 11:57:30 -0400
In-Reply-To: <20150615154816.GG3644@twins.programming.kicks-ass.net>
Content-Language: en-US
Content-ID: <72A5B29ABDB561489037078AE5491D36@internal.synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "peterz@infradead.org" <peterz@infradead.org>
Cc: "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "acme@kernel.org" <acme@kernel.org>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>

Hi Peter,

On Mon, 2015-06-15 at 17:48 +-0200, Peter Zijlstra wrote:
+AD4- On Tue, Jun 09, 2015 at 05:49:28PM +-0530, Vineet Gupta wrote:
+AD4- +AD4- From: Alexey Brodkin +ADw-abrodkin+AEA-synopsys.com+AD4-
+AD4- 
+AD4- -ENOCHANGELOG
+AD4- 
+AD4- +AD4- Cc: Peter Zijlstra +ADw-peterz+AEA-infradead.org+AD4-
+AD4- +AD4- Cc: Arnaldo Carvalho de Melo +ADw-acme+AEA-kernel.org+AD4-
+AD4- +AD4- Signed-off-by: Alexey Brodkin +ADw-abrodkin+AEA-synopsys.com+AD4-
+AD4- +AD4- Signed-off-by: Vineet Gupta +ADw-vgupta+AEA-synopsys.com+AD4-
+AD4- +AD4- ---
+AD4- 
+AD4- +AD4-  struct arc+AF8-pmu +AHs-
+AD4- +AD4-     struct pmu      pmu+ADs-
+AD4- +AD4- +-   int             has+AF8-interrupts+ADs-
+AD4- 
+AD4- we have pmu::flags +ACY- PERF+AF8-PMU+AF8-CAP+AF8-NO+AF8-INTERRUPT

Ah... if we set that flag perf+AF8-event+AF8-open() won't allow user to use
sampling events anyways so we may drop +ACI-arc+AF8-pmu.has+AF8-interrupts+ACI-
completely, right?

+AD4- 
+AD4- +AD4- +AEAAQA- -186,7 +-189,8 +AEAAQA- static int arc+AF8-pmu+AF8-event+AF8-init(struct perf+AF8-event 
+AD4- +AD4- +ACo-event)
+AD4- +AD4-             hwc-+AD4-last+AF8-period +AD0- hwc-+AD4-sample+AF8-period+ADs-
+AD4- +AD4-             local64+AF8-set(+ACY-hwc-+AD4-period+AF8-left, hwc
+AD4- +AD4- -+AD4-sample+AF8-period)+ADs-
+AD4- +AD4-     +AH0- else
+AD4- +AD4- -           return -ENOENT+ADs-
+AD4- +AD4- +-           if (+ACE-arc+AF8-pmu-+AD4-has+AF8-interrupts)
+AD4- +AD4- +-                   return -ENOENT+ADs-
+AD4- 
+AD4- Same as before, first determine if the event is yours, then return a
+AD4- fatal error.

Indeed with my note above that check makes no sense - perf framework
will do that same check instead.

+AD4- +AD4- +AEAAQA- -307,6 +-311,17 +AEAAQA- static void arc+AF8-pmu+AF8-stop(struct perf+AF8-event 
+AD4- +AD4- +ACo-event, int flags)
+AD4- +AD4-     struct hw+AF8-perf+AF8-event +ACo-hwc +AD0- +ACY-event-+AD4-hw+ADs-
+AD4- +AD4-     int idx +AD0- hwc-+AD4-idx+ADs-
+AD4- +AD4-  
+AD4- +AD4- +-   /+ACo- Disable interrupt for this counter +ACo-/
+AD4- +AD4- +-   if (is+AF8-sampling+AF8-event(event)) +AHs-
+AD4- 
+AD4- but but but, a sampling event needs the interrupt enabled?

Indeed sampling event needs the interrupt enabled. What's wrong with
that fact? Or I'm missing something?

+AD4- +AD4- +-           /+ACo-
+AD4- +AD4- +-            +ACo- Reset interrupt flag by writing of 1. This is 
+AD4- +AD4- required
+AD4- +AD4- +-            +ACo- to make sure pending interrupt was not left.
+AD4- +AD4- +-            +ACo-/
+AD4- 
+AD4- Would not typically the interrupt latch be a property of the 
+AD4- interrupt
+AD4- controller, not the device generating it?
+AD4- 
+AD4- That is, how can the device programming affect pending interrupts?

The point here is our hardware counters are built in CPU core and
interrupt line from PMU block is wired directly to the top-level INTC.

Moreover that one IRQ line from PMU (or HW event counters how we call
them) is a logical OR of interrupts from each even counter (we may have
from 1 to 32 counters built-in). That means to clear a pending
interrupt from PMU block we need to clear states of individual
interrupts (per counter) in PMU.

+AD4- +AD4- +-           write+AF8-aux+AF8-reg(ARC+AF8-REG+AF8-PCT+AF8-INT+AF8-ACT, 1 +ADwAPA- idx)+ADs-
+AD4- +AD4- +-           write+AF8-aux+AF8-reg(ARC+AF8-REG+AF8-PCT+AF8-INT+AF8-CTRL,
+AD4- +AD4- +-                    
+AD4- +AD4-      read+AF8-aux+AF8-reg(ARC+AF8-REG+AF8-PCT+AF8-INT+AF8-CTRL) +ACY- +AH4-(1 +ADwAPA- idx))+ADs-
+AD4- +AD4- +-   +AH0-
+AD4- +AD4- +-
+AD4- 
+AD4- +AD4- +-   if (is+AF8-sampling+AF8-event(event)) +AHs-
+AD4- +AD4- +-           /+ACo- Mimic full counter overflow as other arches do 
+AD4- +AD4- +ACo-/
+AD4- 
+AD4- With this you mean the pretending we have 63bit of overflow counter?

Correct. In more details it is covered in my comments in +AFs-PATCH 3/8+AF0-.

+AD4- +AD4- +-           write+AF8-aux+AF8-reg(ARC+AF8-REG+AF8-PCT+AF8-INT+AF8-CNTL, arc+AF8-pmu
+AD4- +AD4- -+AD4-max+AF8-period +ACY-
+AD4- +AD4- +-                                               0xffffffff)+ADs-
+AD4- 
+AD4- Would not (u32)arc+AF8-pmu-+AD4-max+AF8-period, be clearer?

True, makes sense.

+AD4- +AD4- +-           write+AF8-aux+AF8-reg(ARC+AF8-REG+AF8-PCT+AF8-INT+AF8-CNTH,
+AD4- +AD4- +-                         (arc+AF8-pmu-+AD4-max+AF8-period +AD4APg- 32))+ADs-
+AD4- 
+AD4- But should you not program: min(period, max+AF8-period) instead? If the
+AD4- requested period is shorter than your max period you do not want to
+AD4- program the max. Or are you missing a negative somewhere?

Here we just program the limit which is used for triggering an
interrupt. We don't care about +ACI-period+ACI- being +AD4- than +ACI-max+AF8-period+ACI-
because in arc+AF8-pmu+AF8-start()-+AD4-arc+AF8-pmu+AF8-event+AF8-set+AF8-period() we do that check
when actually setting start value of a counter.

+AD4- That is, program the max+AF8-period for +ACE-sampling events to deal with
+AD4- overflow folding.

Once again we deal with overflow folding in arc+AF8-pmu+AF8-event+AF8-set+AF8-period()
even for +ACE-sampling events. But there's no need to program max+AF8-period in
PMU registers because hardware doesn't care about it - we just use that
value in software. Moreover if HW lacks PMU IRQ support then attempt to
access missing registers (for example ARC+AF8-REG+AF8-PCT+AF8-INT+AF8-CNT) will
inevitably lead to instruction error exception.

-Alexey--
To unsubscribe from this list: send the line "unsubscribe linux-arch" in
