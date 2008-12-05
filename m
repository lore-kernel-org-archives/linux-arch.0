From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 0/3] [Announcement] Performance Counters for Linux
Date: Fri, 5 Dec 2008 07:10:12 +0100
Message-ID: <20081205061012.GA12785@elte.hu>
References: <20081204225345.654705757@linutronix.de> <20081204.171233.201039452.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:45798 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751303AbYLEGKj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 5 Dec 2008 01:10:39 -0500
Content-Disposition: inline
In-Reply-To: <20081204.171233.201039452.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, eranian@googlemail.com, dada1@cosmosbay.com, robert.richter@amd.com, arjan@infradead.org, hpa@zytor.com, a.p.zijlstra@chello.nl, rostedt@goodmis.org, paulus@samba.org


* David Miller <davem@davemloft.net> wrote:

> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Thu, 04 Dec 2008 23:44:39 -0000
> 
> >  - No interaction with ptrace: any task (with sufficient permissions) can
> >    monitor other tasks, without having to stop that task.
> 
> This isn't going to work.
>
> If you look at the things the perfmon libraries do, you do need to stop 
> the task.
>
> Consider counter virtualization as the most direct example. [...]

Note that counter virtualization is not offered in the perfmon3 patchset 
that has been posted to lkml. (It is part of the much larger 'full' 
perfmon patchset which has not been submitted for integration)

Nevertheless we will offer counter virtualization in -v2 of our patchset 
and we mentioned it in the TODO list:

> >  - Round-robin scheduling of counters, when there's more task
> >    counters than hw counters available.

The 'target' task does not have to be stopped to offer counter 
virtualization (counter overcommit or counter scheduling) - or to offer 
any of the other performance counter features. Please let us know why it 
needs the task to be stopped - we asked about that on lkml in the perfmon 
thread and no technical answer was given, and couldnt find any such 
technical reason while implementing it ourselves.

Relying on ptrace machinery can be considered one of the bigger design 
mistakes of the permon3 patchset.

We pointed that out in review, and now we demonstrate it via this 
patchset that it can be done much cleaner and much simpler. (Please stay 
tuned for -v2 if you want to see the proof of the pudding.)

	Ingo
