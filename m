Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:42039 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908Ab3IQI0I (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 17 Sep 2013 04:26:08 -0400
Date: Tue, 17 Sep 2013 10:25:56 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH REBASED 1/3] sh: Move fpu_counter into ARCH specific
 thread_struct
Message-ID: <20130917082556.GD12926@twins.programming.kicks-ass.net>
References: <1379398639-27403-1-git-send-email-vgupta@synopsys.com>
 <1379398639-27403-2-git-send-email-vgupta@synopsys.com>
 <20130917080017.GC12926@twins.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA2307514C36B@IN01WEMBXA.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA2307514C36B@IN01WEMBXA.internal.synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org
Message-ID: <20130917082556.8tCrf8U53E4D0LxEk2W621J3Ai2BeD5GcGp_7nBXgGU@z>

On Tue, Sep 17, 2013 at 08:14:34AM +0000, Vineet Gupta wrote:
> For some reason the email to Paul bounced last time as well
> 
> --------------->8-----------------------
> lethal@linux-sh.org<mailto:lethal@linux-sh.org>>: host mail.linux-sh.org[111.68.239.195] said: 550 5.7.1
>     <lethal@linux-sh.org><mailto:lethal@linux-sh.org>... Relaying denied. Proper authentication required.
>     (in reply to RCPT TO command)
> --------------->8-----------------------
> 
> Did you get that too after sending this CCed email to him.

Yep.. :/ 
