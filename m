Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from brick.kernel.dk ([87.55.233.238]:13497 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756834AbYDVInT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 22 Apr 2008 04:43:19 -0400
Date: Tue, 22 Apr 2008 10:43:15 +0200
From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [PATCH 2/11] x86: convert to generic helpers for IPI function calls
Message-ID: <20080422084315.GT12774@kernel.dk>
References: <1208851058-8500-1-git-send-email-jens.axboe@oracle.com> <1208851058-8500-3-git-send-email-jens.axboe@oracle.com> <20080422083810.GA23540@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080422083810.GA23540@uranus.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, npiggin@suse.de, torvalds@linux-foundation.org, Ingo Molnar <mingo@redhat.com>
Message-ID: <20080422084315.h_MxWBEkcV6IVhuhoKCg5TUINmCsJ-Jk5mESUWEnQlA@z>

On Tue, Apr 22 2008, Sam Ravnborg wrote:
> On Tue, Apr 22, 2008 at 09:57:28AM +0200, Jens Axboe wrote:
> > This converts x86 and x86-64 to use the new helpers for
> > smp_call_function() and friends, and adds support for
> > smp_call_function_single().
> > 
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 87a693c..aab97e3 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -156,6 +156,11 @@ config GENERIC_PENDING_IRQ
> >  	depends on GENERIC_HARDIRQS && SMP
> >  	default y
> >  
> > +config GENERIC_SMP_HELPERS
> > +	bool
> > +	depends on SMP
> > +	default y
> > +
> 
> Hi Jens.
> 
> [Not x86 specific - it was the first patch
> touching a Kconfig file]
> 
> Could we define a single config variable
> in for example kernel/Kconfig(*)
> like this:
> 
> config HAVE_GENERIC_SMP_HELPERS
> 	def_bool n
> 
> And then the archs that uses the generic SMP helpers just
> do a simple:
> 
>  config X86
> +	select HAVE_GENERIC_SMP_HELPERS
> 
> 
> This is the recommended method today and is documented
> in Documentation/kbuild/kconfig-language.txt if
> you need a bit more intro.
> 
> (*) I know we do not have kernel/Kconfig today.
>     But maybe this is a good time to add it and
>     source it from arch/Kconfig

Ah yes, that looks like a better approach. I'll adapt the patches to
this method instead of selecting smp.o, thanks.

-- 
Jens Axboe

