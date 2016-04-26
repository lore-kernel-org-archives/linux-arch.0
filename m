From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] tracing: add support for tracing MMIO helpers
Date: Tue, 26 Apr 2016 15:32:55 -0400
Message-ID: <20160426153255.0fcb5f82@gandalf.local.home>
References: <1461697482-32406-1-git-send-email-rabin@rab.in>
	<6253918.VUpbMrMy7R@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6253918.VUpbMrMy7R@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Rabin Vincent <rabin@rab.in>, Ingo Molnar <mingo@redhat.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, 26 Apr 2016 21:14:47 +0200
Arnd Bergmann <arnd@arndb.de> wrote:


> > +/* This part must be outside protection */
> > +#include <trace/define_trace.h>
> > diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> > index e45db6b0d878..feca834436c5 100644
> > --- a/kernel/trace/Kconfig
> > +++ b/kernel/trace/Kconfig
> > @@ -372,6 +372,22 @@ config STACK_TRACER
> >  
> >  	  Say N if unsure.
> >  
> > +config TRACE_MMIO_HELPERS
> > +       bool "Support for tracing MMIO helpers"
> > +       select GENERIC_TRACER  
> 
> How about putting a whitelist of architectures here that are including
> the necessary definitions? Or better, a HAVE_TRACE_MMIO_HELPERS
> symbol that gets selected by architectures and that this depends on?
> 

Agreed.

-- Steve
