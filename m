Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:31990 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932332AbWEJSEZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 10 May 2006 14:04:25 -0400
Date: Wed, 10 May 2006 14:04:18 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC/PATCH] Make powerpc64 use __thread for per-cpu variables
In-Reply-To: <20060510154702.GA28938@twiddle.net>
Message-ID: <Pine.LNX.4.58.0605101400530.20305@gandalf.stny.rr.com>
References: <17505.26159.807484.477212@cargo.ozlabs.ibm.com>
 <20060510154702.GA28938@twiddle.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Richard Henderson <rth@twiddle.net>
Cc: Paul Mackerras <paulus@samba.org>, t@twiddle.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org
List-ID: <linux-arch.vger.kernel.org>


On Wed, 10 May 2006, Richard Henderson wrote:

> On Wed, May 10, 2006 at 02:03:59PM +1000, Paul Mackerras wrote:
> > With this patch, 64-bit powerpc uses __thread for per-cpu variables.
>
> How do you plan to address the compiler optimizing
>
> 	__thread int foo;
> 	{
> 	  use(foo);
> 	  schedule();
> 	  use(foo);
> 	}
>
> into
>
> 	{
> 	  int *tmp = &foo;	// tls arithmetic here
> 	  use(*tmp);
> 	  schedule();
> 	  use(*tmp);
> 	}
>
> Across the schedule, we may have changed cpus, making the cached
> address invalid.
>

If you mean use(foo) is the same as per_cpu(foo), I can't see the compile
optimizing this:

+#define per_cpu(var, cpu)                                      \
+       (*(__typeof__(&per_cpu__##var))({                       \
+               void *__ptr;                                    \
+               asm("addi %0,%1,per_cpu__"#var"@tprel"          \
+                   : "=b" (__ptr)                              \
+                   : "b" (paca[(cpu)].thread_ptr));            \
+               __ptr;                                          \
+       }))


Anyway, per_cpu variables are usually used with preemption turned off and
no need to schedule.

-- Steve

