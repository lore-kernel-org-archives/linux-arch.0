From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [arc-linux-dev] Re: [PATCH v3 3/6] ARCv2: perf: Support
 sampling events using overflow interrupts
Date: Wed, 26 Aug 2015 14:42:51 +0000
Message-ID: <1440600170.15478.53.camel@synopsys.com>
References: <1440426023-2792-1-git-send-email-abrodkin@synopsys.com>
	 <1440426023-2792-4-git-send-email-abrodkin@synopsys.com>
	 <20150826130752.GC19282@twins.programming.kicks-ass.net>
	 <1440595040.15478.44.camel@synopsys.com>
	 <20150826143518.GV16853@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:60644 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102AbbHZOmz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 26 Aug 2015 10:42:55 -0400
In-Reply-To: <20150826143518.GV16853@twins.programming.kicks-ass.net>
Content-Language: en-US
Content-ID: <064B87CA2B062E40825A0FB444753DBD@internal.synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>, "arnd@arndb.de" <arnd@arndb.de>, "acme@kernel.org" <acme@kernel.org>

Hi Peter,

On Wed, 2015-08-26 at 16:35 +-0200, Peter Zijlstra wrote:
+AD4- On Wed, Aug 26, 2015 at 01:17:20PM +-0000, Alexey Brodkin wrote:
+AD4- +AD4- Hi Peter,
+AD4- +AD4- 
+AD4- +AD4- On Wed, 2015-08-26 at 15:07 +-0200, Peter Zijlstra wrote:
+AD4- +AD4- +AD4- On Mon, Aug 24, 2015 at 05:20:20PM +-0300, Alexey Brodkin wrote:
+AD4- +AD4- +AD4- +AD4- +AEAAQA- -139,9 +-141,11 +AEAAQA- static int arc+AF8-pmu+AF8-event+AF8-init(struct perf+AF8-event +ACo-event)
+AD4- +AD4- +AD4- +AD4-  	struct hw+AF8-perf+AF8-event +ACo-hwc +AD0- +ACY-event-+AD4-hw+ADs-
+AD4- +AD4- +AD4- +AD4-  	int ret+ADs-
+AD4- +AD4- +AD4- +AD4-  
+AD4- +AD4- +AD4- +AD4- -	hwc-+AD4-sample+AF8-period  +AD0- arc+AF8-pmu-+AD4-max+AF8-period+ADs-
+AD4- +AD4- +AD4- +AD4- -	hwc-+AD4-last+AF8-period +AD0- hwc-+AD4-sample+AF8-period+ADs-
+AD4- +AD4- +AD4- +AD4- -	local64+AF8-set(+ACY-hwc-+AD4-period+AF8-left, hwc-+AD4-sample+AF8-period)+ADs-
+AD4- +AD4- +AD4- +AD4- +-	if (+ACE-is+AF8-sampling+AF8-event(event)) +AHs-
+AD4- +AD4- +AD4- +AD4- +-		hwc-+AD4-sample+AF8-period  +AD0- arc+AF8-pmu-+AD4-max+AF8-period+ADs-
+AD4- +AD4- +AD4- +AD4- +-		hwc-+AD4-last+AF8-period +AD0- hwc-+AD4-sample+AF8-period+ADs-
+AD4- +AD4- +AD4- +AD4- +-		local64+AF8-set(+ACY-hwc-+AD4-period+AF8-left, hwc-+AD4-sample+AF8-period)+ADs-
+AD4- +AD4- +AD4- +AD4- +-	+AH0-
+AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- So here we set a max+AF8-period sample period for +ACE-sampling events such that
+AD4- +AD4- +AD4- we can properly deal with (short) counter overflow and accumulate into a
+AD4- +AD4- +AD4- 64bit value.
+AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- +AD4-  	switch (event-+AD4-attr.type) +AHs-
+AD4- +AD4- +AD4- +AD4-  	case PERF+AF8-TYPE+AF8-HARDWARE:
+AD4- +AD4- +AD4- +AD4- +AEAAQA- -243,6 +-247,11 +AEAAQA- static void arc+AF8-pmu+AF8-start(struct perf+AF8-event +ACo-event, int flags)
+AD4- +AD4- +AD4- +AD4-  
+AD4- +AD4- +AD4- +AD4-  	arc+AF8-pmu+AF8-event+AF8-set+AF8-period(event)+ADs-
+AD4- +AD4- +AD4- +AD4-  
+AD4- +AD4- +AD4- +AD4- +-	/+ACo- Enable interrupt for this counter +ACo-/
+AD4- +AD4- +AD4- +AD4- +-	if (is+AF8-sampling+AF8-event(event))
+AD4- +AD4- +AD4- +AD4- +-		write+AF8-aux+AF8-reg(ARC+AF8-REG+AF8-PCT+AF8-INT+AF8-CTRL,
+AD4- +AD4- +AD4- +AD4- +-			      read+AF8-aux+AF8-reg(ARC+AF8-REG+AF8-PCT+AF8-INT+AF8-CTRL) +AHw- (1 +ADwAPA- idx))+ADs-
+AD4- +AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- Yet here you fail to actually enable the interrupt for the non sampling
+AD4- +AD4- +AD4- events, which makes the above not work.
+AD4- +AD4- 
+AD4- +AD4- Indeed we intentionally leave interrupts disabled for non-sampling events.
+AD4- +AD4-  +AFs-1+AF0- We have quite large counters so we don't expect to overflow normally
+AD4- +AD4-  +AFs-2+AF0- We may re-use the same code for hardware that lacks support of IRQs in PCT.
+AD4- +AD4-      See we check if IRQs are available and if not set PERF+AF8-PMU+AF8-CAP+AF8-NO+AF8-INTERRUPT
+AD4- +AD4-      that will guarantee we won't get sampling event and for non-sampling events
+AD4- +AD4-      we won't use IRQs.
+AD4- 
+AD4- Tricky, I was seeing is+AF8-isa+AF8-arcv2() calls elsewhere, so I figured you'd
+AD4- make it conditional on that.
+AD4- 
+AD4- But sure, if you think you can live with 1 this'll work.

Well indeed there's a room for improvement always.
But from our current experience existing implementation works pretty fine.

Moreover having now PCT IRQs we mostly use sampling events that allow doing
real profiling.

-Alexey