From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH v3 3/6] ARCv2: perf: Support sampling events using
 overflow interrupts
Date: Wed, 26 Aug 2015 14:35:52 +0000
Message-ID: <1440599752.15478.49.camel@synopsys.com>
References: <1440426023-2792-1-git-send-email-abrodkin@synopsys.com>
	 <1440426023-2792-4-git-send-email-abrodkin@synopsys.com>
	 <20150826131225.GD19282@twins.programming.kicks-ass.net>
	 <1440595268.15478.47.camel@synopsys.com>
	 <20150826143242.GU16853@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:40037 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753564AbbHZOgG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 26 Aug 2015 10:36:06 -0400
In-Reply-To: <20150826143242.GU16853@twins.programming.kicks-ass.net>
Content-Language: en-US
Content-ID: <0A8B325900D84748991AC86FDBC11D89@internal.synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "peterz@infradead.org" <peterz@infradead.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>, "arnd@arndb.de" <arnd@arndb.de>, "acme@kernel.org" <acme@kernel.org>

Hi Peter,

On Wed, 2015-08-26 at 16:32 +-0200, Peter Zijlstra wrote:
+AD4- On Wed, Aug 26, 2015 at 01:21:08PM +-0000, Alexey Brodkin wrote:
+AD4- +AD4- Hi Peter,
+AD4- +AD4- 
+AD4- +AD4- On Wed, 2015-08-26 at 15:12 +-0200, Peter Zijlstra wrote:
+AD4- +AD4- +AD4- On Mon, Aug 24, 2015 at 05:20:20PM +-0300, Alexey Brodkin wrote:
+AD4- +AD4- +AD4- +AD4- +AEAAQA- -295,6 +-317,16 +AEAAQA- static int arc+AF8-pmu+AF8-add(struct perf+AF8-event +ACo-event, int flags)
+AD4- +AD4- +AD4- +AD4-  	+AH0-
+AD4- +AD4- +AD4- +AD4-  
+AD4- +AD4- +AD4- +AD4-  	write+AF8-aux+AF8-reg(ARC+AF8-REG+AF8-PCT+AF8-INDEX, idx)+ADs-
+AD4- +AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +AD4- +-	arc+AF8-pmu-+AD4-act+AF8-counter+AFs-idx+AF0- +AD0- event+ADs-
+AD4- +AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +AD4- +-	if (is+AF8-sampling+AF8-event(event)) +AHs-
+AD4- +AD4- +AD4- +AD4- +-		/+ACo- Mimic full counter overflow as other arches do +ACo-/
+AD4- +AD4- +AD4- +AD4- +-		write+AF8-aux+AF8-reg(ARC+AF8-REG+AF8-PCT+AF8-INT+AF8-CNTL, (u32)arc+AF8-pmu-+AD4-max+AF8-period)+ADs-
+AD4- +AD4- +AD4- +AD4- +-		write+AF8-aux+AF8-reg(ARC+AF8-REG+AF8-PCT+AF8-INT+AF8-CNTH,
+AD4- +AD4- +AD4- +AD4- +-			      (arc+AF8-pmu-+AD4-max+AF8-period +AD4APg- 32))+ADs-
+AD4- +AD4- +AD4- +AD4- +-	+AH0-
+AD4- +AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- pmu::add should call pmu::start when PERF+AF8-EF+AF8-START, without that it
+AD4- +AD4- +AD4- should not start the counter, only schedule it.
+AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- (although currently all pmu::add() calls will have EF+AF8-START set)
+AD4- +AD4- 
+AD4- +AD4- And that's what we do, don't we?
+AD4- +AD4- -----------------------+AD4-8-----------------------
+AD4- +AD4- 	if (flags +ACY- PERF+AF8-EF+AF8-START)
+AD4- +AD4- 		arc+AF8-pmu+AF8-start(event, PERF+AF8-EF+AF8-RELOAD)+ADs-
+AD4- +AD4- -----------------------+AD4-8-----------------------
+AD4- +AD4- 
+AD4- 
+AD4- D'uh indeed+ACE- I read that above as enabling it, while what it really does
+AD4- it simply program the interrupt thresholds.

That's ok.
So do I need to do anything now or both your initial comments today are no longer valid?

-Alexey