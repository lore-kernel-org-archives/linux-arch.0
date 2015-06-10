From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH 22/28] ARCv2: STAR 9000837815 workaround hardware
 exclusive transactions livelock
Date: Wed, 10 Jun 2015 10:01:01 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075665A5041@IN01WEMBXB.internal.synopsys.com>
References: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
 <1433850508-26317-23-git-send-email-vgupta@synopsys.com>
 <20150609123548.GZ3644@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:48608 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754199AbbFJKCI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 10 Jun 2015 06:02:08 -0400
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>

On Tuesday 09 June 2015 06:05 PM, Peter Zijlstra wrote:

On Tue, Jun 09, 2015 at 05:18:22PM +0530, Vineet Gupta wrote:

This really really wants a Changelog describing the actual hardware fail
and why this workaround is sufficient.



OK - I need some more time to rehash the exact details with our hardware folks. But AFAIKR, this was hardware livelock in llock/scond when 2 cores were doing r-m-w to two different words in the same cache line - adding prefetchw (prefetch with a write intent) would get the line in exclusive state and break the livelock.

The test itself was one from EEMBC Multibench but I'll have to look it up.

Wasn't there something similar in ARM world too - they have some sort of snoop-delayed exclusive handling in hardware to mitigate something similar although as Will later remarked it involved llock/scond with vanilla ld/st to same line/word ?
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/254142.html

Thx,
-Vineet
