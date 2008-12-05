From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 0/3] [Announcement] Performance Counters for Linux
Date: Fri, 5 Dec 2008 13:13:08 +0100
Message-ID: <20081205121308.GB28662@elte.hu>
References: <20081205082431.GD2030@elte.hu> <20081205.002701.172921476.davem@davemloft.net> <20081205084233.GE2030@elte.hu> <20081205.004922.244597525.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755843AbYLEMNg@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20081205.004922.244597525.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: a.p.zijlstra@chello.nl, paulus@samba.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, eranian@googlemail.com, dada1@cosmosbay.com, robert.richter@amd.com, arjan@infradead.org, hpa@zytor.com, rostedt@goodmis.org
List-Id: linux-arch.vger.kernel.org


* David Miller <davem@davemloft.net> wrote:

> From: Ingo Molnar <mingo@elte.hu>
> Date: Fri, 5 Dec 2008 09:42:33 +0100
> 
> > Please let me repeat: it's a _fundamental_ thesis of performance 
> > instrumentation to not disturb the monitored context. Your insistence 
> > on _stopping_ the monitored task breaks that fundamental axiom!
> 
> This is only a problem if you make your measurement quantums too small.

But if you make the measurement long enough - say we make it 100,000 
usecs, then 0.2 usecs of delay between two read()s is insignificant 
statistically, right? It's a 1:500,000 ratio.

Scheduling out a task and back is far more drastic of an effect than any 
new events in 0.2 usecs.

	Ingo
