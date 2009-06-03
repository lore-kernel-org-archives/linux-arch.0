From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [Ksummit-2009-discuss] Representing Embedded Architectures at
 the Kernel Summit
Date: Tue, 2 Jun 2009 21:42:06 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.0906022138330.14994@gandalf.stny.rr.com>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com> <20090602172941.GL3095@hansolo.jdub.homelinux.org> <1243964577.4229.49.camel@mulgrave.int.hansenpartnership.com> <20090602175244.GB10973@cuplxvomd02.corp.sa.net>
 <20090602185143.GA8655@zod.rchland.ibm.com> <4A257DF0.6040607@am.sony.com> <1243975064.6342.10.camel@mulgrave.site> <20090603000312.GA21055@cuplxvomd02.corp.sa.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-embedded-owner@vger.kernel.org>
In-Reply-To: <20090603000312.GA21055@cuplxvomd02.corp.sa.net>
Sender: linux-embedded-owner@vger.kernel.org
To: David VomLehn <dvomlehn@cisco.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, linux-arch@vger.kernel.org, Josh Boyer <jwboyer@linux.vnet.ibm.com>, Tim Bird <tim.bird@am.sony.com>, linux-embedded@vger.kernel.org, ksummit-2009-discuss@lists.linux-foundation.org
List-Id: linux-arch.vger.kernel.org


On Tue, 2 Jun 2009, David VomLehn wrote:
> On Tue, Jun 02, 2009 at 03:37:44PM -0500, James Bottomley wrote:
> Our failure report includes things you'd expect as well as various pieces
> of history, such as:
> o IRQs
> o softirq dispatches (including max times)
> o selected /proc info, e.g. /proc/meminfo
> 
> We also report info on the current thread, like backtracing and
> /proc/<pid>/maps, though I'm not sure it's as useful as it might be.
> 
> Though I'm working on pushing this stuff out, other things that might be
> helpful are:
> o If you get to panic() by way of die(), you've lost the registers passed to
>   die(). We save a pointer off, but it's really a kludge.
> o The implementation of die() varies from platform to platform and isn't even
>   called die() everywhere.
> o It is truly nasty trying to get /proc information when you are in a panic
>   situation--any semaphores being held are not going to be released, so you
>   have to duplicate a lot of the code, minus the semaphores. Pretty gross
>   and there is no way our implementation will be acceptable.
> o Increased reporting on what's happening in user/kernel space interaction.
>   For example, a signal sent in good faith might kill a buggy process. It
>   would be helpful to log signals that result in a process' death.
> o Then there is more speculative stuff. For example, your caches would
>   have a copy of the most recently accessed code and data.  If your
>   processor supports dumping cache, it might help determing what went wrong.

If your system is hooked up to a serial console, another helpful thing to 
do is to pass in "ftrace_dump_on_oops" in the command line and also keep 
the event tracer running, where you enable just the events you are 
interested in. Then if the system crashes, it will dump out the ftrace 
buffer to the console, which could be logged by a serial console and then 
you at least have a trace of the events that lead up to the crash.

The event tracer while active is not that much overhead and could be 
enabled in a production system.

-- Steve
