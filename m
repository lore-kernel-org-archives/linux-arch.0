Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:17274 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752920AbYJQCTx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 16 Oct 2008 22:19:53 -0400
From: "Luck, Tony" <tony.luck@intel.com>
Date: Thu, 16 Oct 2008 19:19:48 -0700
Subject: RE: [RFC patch 15/15] LTTng timestamp x86
Message-ID: <57C9024A16AD2D4C97DC78E552063EA3532D455F@orsmsx505.amr.corp.intel.com>
References: <20081016232729.699004293@polymtl.ca>
 <20081016234657.837704867@polymtl.ca>
 <alpine.LFD.2.00.0810161701470.3288@nehalem.linux-foundation.org>
 <20081017012835.GA30195@Krystal>
In-Reply-To: <20081017012835.GA30195@Krystal>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Thomas Gleixner <tglx@linutronix.de>, David Miller <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <20081017021948.7lrv3bCgJhIMzLLwzXM4DcEy00Qw5fUevwtUSW7Enn8@z>

> This cache-line bouncing global clock is a best-effort to provide
> correct event order in the trace on architectures with unsync tsc. It's
> actually better than a global tracing buffer because it limits the
> number of cache line transfers required to one per event.

Even one line bouncing between cpus can be a performamce disaster.
You'll probably hit a serious wall somewhere between 8 and 16
cpus (ia64 has code that looks a lot like this in the gettimeofday()
path because it does not synchronize cpu cycle counters ... some
applications that are overly fond of timestamping internal
events using gettimeofday() end up spending significant time
doing so on large systems ... even with only a few thousands
of calls per second).

-Tony
