From: Christoph Lameter <cl@linux-foundation.org>
Subject: Re: [RFC patch 15/15] LTTng timestamp x86
Date: Fri, 17 Oct 2008 14:36:56 -0500
Message-ID: <48F8E958.5080907@linux-foundation.org>
References: <20081016232729.699004293@polymtl.ca> <20081016234657.837704867@polymtl.ca> <alpine.LFD.2.00.0810161701470.3288@nehalem.linux-foundation.org> <20081017012835.GA30195@Krystal> <57C9024A16AD2D4C97DC78E552063EA3532D455F@orsmsx505.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59728 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755196AbYJQTjE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 17 Oct 2008 15:39:04 -0400
In-Reply-To: <57C9024A16AD2D4C97DC78E552063EA3532D455F@orsmsx505.amr.corp.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Thomas Gleixner <tglx@linutronix.de>, David Miller <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>

Luck, Tony wrote:
> Even one line bouncing between cpus can be a performamce disaster.
> You'll probably hit a serious wall somewhere between 8 and 16
> cpus (ia64 has code that looks a lot like this in the gettimeofday()
> path because it does not synchronize cpu cycle counters ... some


The code exist by necessity because some systems do not have synchronized ITCs
and one would not have time go backward. The cmpxchg there is usually switched
off. Its horrible in terms of scaling to large numbers of processor and also
horrible in terms of clock accuracy.
