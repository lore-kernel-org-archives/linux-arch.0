From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH 0/3] atomic_or() related changes
Date: Thu, 9 Jul 2015 13:05:25 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075665AD06D@IN01WEMBXB.internal.synopsys.com>
References: <1436429599-10762-1-git-send-email-vgupta@synopsys.com>
 <20150709123128.GT19282@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:45704 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753727AbbGINF3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2015 09:05:29 -0400
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thursday 09 July 2015 06:01 PM, Peter Zijlstra wrote:
> I've just not managed to finish tile, but did do frv this time.

Not sure what you mean - are you also doing a similar series which extends
atomic_or to other arches too which will probably we simpler now given ur earlier
macro-fication of this code !

-vineet
