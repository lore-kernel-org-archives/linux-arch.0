From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v5 1/2] kernel/signal: Signal-based pre-coredump
 notification
Date: Thu, 6 Dec 2018 18:29:32 +0100
Message-ID: <20181206172931.GA12967@redhat.com>
References: <7741efa7-a3f8-62a1-ba52-613883164643@cisco.com>
 <84460a77-a111-404e-4bad-88104a6e246e@cisco.com>
 <20181026082812.GA10581@redhat.com>
 <21f678a8-4001-df36-c26e-e96cf203b1b1@cisco.com>
 <20181029111804.GA24820@redhat.com>
 <0c197608-3b7e-ffd1-8943-801a60beb917@cisco.com>
 <80e96710-f424-9b39-72ee-9cc7cbe7a5f7@cisco.com>
 <20181128151911.GN3505@e103592.cambridge.arm.com>
 <ad461da7-f0a6-7912-3201-e440dc372f89@cisco.com>
 <20181204143759.fe24ee036a33000193339561@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181204143759.fe24ee036a33000193339561@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Enke Chen <enkechen@cisco.com>, Dave Martin <Dave.Martin@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Khalid Aziz <khalid.aziz@oracle.com>, Kate Stewart <kstewart@linuxfoundation.org>, Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <christian@brauner.io>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Michal Hocko <mhocko@kernel.org>, Rik van Riel <riel@surriel.com>
List-Id: linux-arch.vger.kernel.org

On 12/04, Andrew Morton wrote:
>
> I'm not sure what to make of this patchset, really.  Oleg sounds
> unhappy and that's always a bad sign.  And signals are rather ugly
> things.  Oleg, can you please expand on your concerns?

I don't really know what can I say...

Yes the signals are ugly things, this is one reason. Worse, you need to
use real-time predump_signal if parent has 2 or more children.

And when it comes to child-parent notifications we already have do_wait().
So probably it would be better to implement WCOREDUMP so that the parent
could rely on SIGCHLD + waitpid(WCOREDUMP). Not that I think this is a
good idea and this is much more complex especially if we want to report
this event to ptracer too, while this patch is very simple.

In fact I think that we need something more generic, but I can't suggest
any good idea :/

May be we could simply add a tracepoint or perf_event_coredump, I dunno.
Sure, the usage of perf events is not that simple...

Oleg.
