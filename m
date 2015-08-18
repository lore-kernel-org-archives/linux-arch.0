From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH v2 3/8] ARCv2: perf: implement "event_set_period" for
 future use with interrupts
Date: Tue, 18 Aug 2015 18:03:07 +0000
Message-ID: <1439920986.28471.13.camel@synopsys.com>
References: <1438787614-14074-1-git-send-email-abrodkin@synopsys.com>
	 <1438787614-14074-4-git-send-email-abrodkin@synopsys.com>
	 <20150818175203.GM20948@worktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:41971 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458AbbHRSDM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 18 Aug 2015 14:03:12 -0400
In-Reply-To: <20150818175203.GM20948@worktop>
Content-Language: en-US
Content-ID: <092324AB9CF8F74EAF2EC78C6DE4AF2E@internal.synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "peterz@infradead.org" <peterz@infradead.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>, "arnd@arndb.de" <arnd@arndb.de>, "acme@kernel.org" <acme@kernel.org>

Hi Peter,

On Tue, 2015-08-18 at 19:52 +-0200, Peter Zijlstra wrote:
+AD4- On Wed, Aug 05, 2015 at 06:13:29PM +-0300, Alexey Brodkin wrote:
+AD4- +AD4- Even though this hardware implementation allows for more flexibility,
+AD4- +AD4- in Linux kernel we decided to mimic behavior of other architectures this
+AD4- +AD4- way:
+AD4- +AD4- 
+AD4- +AD4-  +AFs-1+AF0- Set limit value as half of counter's max value (to allow counter to
+AD4- +AD4-      run after reaching it limit, see below for more explanation):
+AD4- +AD4-  ----------+AD4-8-----------
+AD4- +AD4-  arc+AF8-pmu-+AD4-max+AF8-period +AD0- (1ULL +ADwAPA- counter+AF8-size) / 2 - 1ULL+ADs-
+AD4- +AD4-  ----------+AD4-8-----------
+AD4- 
+AD4- +AD4- +AEAAQA- -317,10 +-365,11 +AEAAQA- static int arc+AF8-pmu+AF8-device+AF8-probe(struct platform+AF8-device +ACo-pdev)
+AD4- +AD4-  		return -ENOMEM+ADs-
+AD4- +AD4-  
+AD4- +AD4-  	arc+AF8-pmu-+AD4-n+AF8-counters +AD0- pct+AF8-bcr.c+ADs-
+AD4- +AD4- -	arc+AF8-pmu-+AD4-counter+AF8-size +AD0- 32 +- (pct+AF8-bcr.s +ADwAPA- 4)+ADs-
+AD4- +AD4- +-	counter+AF8-size +AD0- 32 +- (pct+AF8-bcr.s +ADwAPA- 4)+ADs-
+AD4- +AD4- +-	arc+AF8-pmu-+AD4-max+AF8-period +AD0- (1ULL +ADwAPA- counter+AF8-size) - 1ULL+ADs-
+AD4- +AD4-  
+AD4- 
+AD4- I don't see that /2 there..

My comment was a bit too early.
That +ACI-/2+ACI- was actually introduced in the subsequent commit.

Do you think I need to do a re-spin of that patch with commit
message which matches real code (i.e. no +ACI-/2+ACI-)?

-Alexey