From: Paul Mackerras <paulus@samba.org>
Subject: Re: [patch 0/3] [Announcement] Performance Counters for Linux
Date: Fri, 5 Dec 2008 20:34:09 +1100
Message-ID: <18744.62865.420502.642345@cargo.ozlabs.ibm.com>
References: <20081204225345.654705757@linutronix.de>
	<20081204.171233.201039452.davem@davemloft.net>
	<20081205061012.GA12785@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:35042 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751476AbYLEJeW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 5 Dec 2008 04:34:22 -0500
In-Reply-To: <20081205061012.GA12785@elte.hu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: David Miller <davem@davemloft.net>, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, eranian@googlemail.com, dada1@cosmosbay.com, robert.richter@amd.com, arjan@infradead.org, hpa@zytor.com, a.p.zijlstra@chello.nl, rostedt@goodmis.org

Ingo Molnar writes:

> The 'target' task does not have to be stopped to offer counter 
> virtualization (counter overcommit or counter scheduling) - or to offer 
> any of the other performance counter features. Please let us know why it 
> needs the task to be stopped - we asked about that on lkml in the perfmon 
> thread and no technical answer was given, and couldnt find any such 
> technical reason while implementing it ourselves.

I like this feature of your patchset, in fact, and the code looks
pretty clean (as I would expect :).  What I don't like (as I have
already said) is having to use an API that splits up the PMU into
pieces, plus the requirement that flows from that to have the kernel
know about the event selection logic on every CPU model we support.

One thing I haven't figured out yet is what happens if you have a
counter on a task and the task dies.  Can I still use the counter fd
after the task has died, and read out the total count?

Paul.
