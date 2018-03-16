From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH 1/2] ftrace: Allow arches to opt-out of static
 ftrace
Date: Fri, 16 Mar 2018 10:40:30 -0400
Message-ID: <20180316104030.0df39af7@gandalf.local.home>
References: <20180316134633.10584-1-mpe@ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180316134633.10584-1-mpe@ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com
List-Id: linux-arch.vger.kernel.org

On Sat, 17 Mar 2018 00:46:32 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> There is a small but non-zero amount of code required by arches to
> suppory non-dynamic (static) ftrace, and more importantly there is the
> added work of testing both configurations.
> 
> There are also almost no down sides to dynamic ftrace once it's well
> tested, other than a small increase in code/data size.
> 
> So give arches the option to opt-out of supporting static ftrace.
> 
> This is implemented as a DYNAMIC_FTRACE_CHOICE option, which controls
> whether DYNAMIC_FTRACE is presented as a user-selectable option or if
> it is just enabled based on its dependencies being enabled (because
> it's already default y).
> 
> Then the CHOICE option depends on an arch *not* selecting
> HAVE_DYNAMIC_FTRACE_ONLY. This would be more natural in reverse, as a
> HAVE_STATIC_FTRACE option, but that would require updating every arch.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Why not just add in arch/powerpc/Kconfig:

config PPC
	[..]
	select DYNAMIC_FTRACE			if FUNCTION_TRACER

?

It seems to work for me.

-- Steve
