From: Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/11] x86: convert to generic helpers for IPI function calls
Date: Tue, 22 Apr 2008 13:15:40 +0200
Message-ID: <20080422111539.GY12774@kernel.dk>
References: <1208851058-8500-1-git-send-email-jens.axboe@oracle.com> <1208851058-8500-3-git-send-email-jens.axboe@oracle.com> <20080422083810.GA23540@uranus.ravnborg.org> <20080422084315.GT12774@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080422084315.GT12774-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, npiggin-l3A5Bk7waGM@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On Tue, Apr 22 2008, Jens Axboe wrote:
> On Tue, Apr 22 2008, Sam Ravnborg wrote:
> > On Tue, Apr 22, 2008 at 09:57:28AM +0200, Jens Axboe wrote:
> > > This converts x86 and x86-64 to use the new helpers for
> > > smp_call_function() and friends, and adds support for
> > > smp_call_function_single().
> > > 
> > > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > > index 87a693c..aab97e3 100644
> > > --- a/arch/x86/Kconfig
> > > +++ b/arch/x86/Kconfig
> > > @@ -156,6 +156,11 @@ config GENERIC_PENDING_IRQ
> > >  	depends on GENERIC_HARDIRQS && SMP
> > >  	default y
> > >  
> > > +config GENERIC_SMP_HELPERS
> > > +	bool
> > > +	depends on SMP
> > > +	default y
> > > +
> > 
> > Hi Jens.
> > 
> > [Not x86 specific - it was the first patch
> > touching a Kconfig file]
> > 
> > Could we define a single config variable
> > in for example kernel/Kconfig(*)
> > like this:
> > 
> > config HAVE_GENERIC_SMP_HELPERS
> > 	def_bool n
> > 
> > And then the archs that uses the generic SMP helpers just
> > do a simple:
> > 
> >  config X86
> > +	select HAVE_GENERIC_SMP_HELPERS
> > 
> > 
> > This is the recommended method today and is documented
> > in Documentation/kbuild/kconfig-language.txt if
> > you need a bit more intro.
> > 
> > (*) I know we do not have kernel/Kconfig today.
> >     But maybe this is a good time to add it and
> >     source it from arch/Kconfig
> 
> Ah yes, that looks like a better approach. I'll adapt the patches to
> this method instead of selecting smp.o, thanks.

I added

config USE_GENERIC_SMP_HELPERS
        def_bool n

in arch/Kconfig and added a 'select USE_GENERIC_SMP_HELPERS' in the arch
private Kconfig files instead. It also reduces the line count further,
thanks for the suggestion! It's cleaner this way.

-- 
Jens Axboe
