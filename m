From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RFC PATCH 1/2] ftrace: Allow arches to opt-out of static ftrace
Date: Mon, 19 Mar 2018 12:02:54 +1100
Message-ID: <87h8pcho75.fsf@concordia.ellerman.id.au>
References: <20180316134633.10584-1-mpe@ellerman.id.au> <20180316104030.0df39af7@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180316104030.0df39af7@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com
List-Id: linux-arch.vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> writes:

> On Sat, 17 Mar 2018 00:46:32 +1100
> Michael Ellerman <mpe@ellerman.id.au> wrote:
>
>> There is a small but non-zero amount of code required by arches to
>> suppory non-dynamic (static) ftrace, and more importantly there is the
>> added work of testing both configurations.
>> 
>> There are also almost no down sides to dynamic ftrace once it's well
>> tested, other than a small increase in code/data size.
>> 
>> So give arches the option to opt-out of supporting static ftrace.
>> 
>> This is implemented as a DYNAMIC_FTRACE_CHOICE option, which controls
>> whether DYNAMIC_FTRACE is presented as a user-selectable option or if
>> it is just enabled based on its dependencies being enabled (because
>> it's already default y).
>> 
>> Then the CHOICE option depends on an arch *not* selecting
>> HAVE_DYNAMIC_FTRACE_ONLY. This would be more natural in reverse, as a
>> HAVE_STATIC_FTRACE option, but that would require updating every arch.
>> 
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>
> Why not just add in arch/powerpc/Kconfig:
>
> config PPC
> 	[..]
> 	select DYNAMIC_FTRACE			if FUNCTION_TRACER
>
> ?
>
> It seems to work for me.

It does work, but it's a bit fragile. It requires duplicating the
dependencies of DYNAMIC_FTRACE in the 'if' condition.

Currently that's:

config DYNAMIC_FTRACE
	depends on FUNCTION_TRACER
	depends on HAVE_DYNAMIC_FTRACE

So technically we should use:

 	select DYNAMIC_FTRACE			if FUNCTION_TRACER and HAVE_DYNAMIC_FTRACE

Though we happen to know we just selected HAVE_DYNAMIC_FTRACE so we can
leave that out.

As long as the dependencies of DYNAMIC_FTRACE don't change, or the 'if'
clause is updated when they do, then it's OK and it is certainly simpler.

cheers
