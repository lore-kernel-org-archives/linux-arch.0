From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [RFC patch 15/15] LTTng timestamp x86
Date: Fri, 17 Oct 2008 16:52:16 -0700
Message-ID: <57C9024A16AD2D4C97DC78E552063EA353345B9B@orsmsx505.amr.corp.intel.com>
References: <20081016232729.699004293@polymtl.ca>
 <20081016234657.837704867@polymtl.ca>
 <alpine.LFD.2.00.0810161701470.3288@nehalem.linux-foundation.org>
 <20081017012835.GA30195@Krystal>
 <57C9024A16AD2D4C97DC78E552063EA3532D455F@orsmsx505.amr.corp.intel.com>
 <20081017172515.GA9639@goodmis.org>
 <57C9024A16AD2D4C97DC78E552063EA3533458AC@orsmsx505.amr.corp.intel.com>
 <20081017184215.GB9874@Krystal>
 <57C9024A16AD2D4C97DC78E552063EA35334594F@orsmsx505.amr.corp.intel.com>
 <20081017202313.GA13597@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:19465 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752859AbYJQXwl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 17 Oct 2008 19:52:41 -0400
In-Reply-To: <20081017202313.GA13597@Krystal>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: Steven Rostedt <rostedt@goodmis.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Thomas Gleixner <tglx@linutronix.de>, David Miller <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "ltt-dev@lists.casi.polymtl.ca" <ltt-dev@lists.casi.polymtl.ca>

Complexity of dealing with all the random issues that have
plagued TSC in different cpus over the years definitely
seems to be a problem.

I have one more idea on how we might be able to use
TSC locally and still have confidence that we can
merge local cpu buffers into a consistent stream.

What if we read the HPET occasionally (once per
second?) and add a record to our per-cpu buffer
with the value of the HPET.  That would give us
a periodic cross-check of each cpus TSC against
real time so that a "smart" post-processor can
sanity check the log entries at regular intervals.

It doesn't deal with the truly insane TSC behaivours
(like stopping completely in certain C states, or
varying frequency) ... but it would at least be able
to reliably detect these forms of insanity.

We need periodic entries added to the buffer anyway
to make sure we can detect rollover since we don't
want waste space in log records with a full width
TSC value.

-Tony
