Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay0187.hostedemail.com ([216.40.44.187]:55047 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752893AbcDZTme (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 26 Apr 2016 15:42:34 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
	by smtpgrave03.hostedemail.com (Postfix) with ESMTP id 4450028D748
	for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2016 19:32:59 +0000 (UTC)
Date: Tue, 26 Apr 2016 15:32:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] tracing: add support for tracing MMIO helpers
Message-ID: <20160426153255.0fcb5f82@gandalf.local.home>
In-Reply-To: <6253918.VUpbMrMy7R@wuerfel>
References: <1461697482-32406-1-git-send-email-rabin@rab.in>
	<6253918.VUpbMrMy7R@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Rabin Vincent <rabin@rab.in>, Ingo Molnar <mingo@redhat.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20160426193255.c7yTiEr-mYYiAAys_JXpgrYdhOgl_BXoCFIrApr6Lf4@z>

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
