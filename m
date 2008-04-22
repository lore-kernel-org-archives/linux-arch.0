From: Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 11/11] s390: convert to generic helpers for IPI  function calls
Date: Tue, 22 Apr 2008 10:07:31 +0200
Message-ID: <20080422080730.GR12774@kernel.dk>
References: <1208851058-8500-1-git-send-email-jens.axboe@oracle.com> <1208851058-8500-12-git-send-email-jens.axboe@oracle.com> <1208851490.10852.0.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1208851490.10852.0.camel@localhost>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Martin Schwidefsky <schwidefsky-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, npiggin-l3A5Bk7waGM@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Heiko Carstens <heiko.carstens-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>

On Tue, Apr 22 2008, Martin Schwidefsky wrote:
> On Tue, 2008-04-22 at 09:57 +0200, Jens Axboe wrote:
> > diff --git a/arch/sparc64/kernel/sparc64_ksyms.c b/arch/sparc64/kernel/sparc64_ksyms.c
> > index 3873646..17b16b1 100644
> > --- a/arch/sparc64/kernel/sparc64_ksyms.c
> > +++ b/arch/sparc64/kernel/sparc64_ksyms.c
> > @@ -112,6 +112,7 @@ EXPORT_SYMBOL(__write_unlock);
> >  EXPORT_SYMBOL(__write_trylock);
> > 
> >  EXPORT_SYMBOL(smp_call_function);
> > +EXPORT_SYMBOL(smp_call_function_single);
> >  #endif /* CONFIG_SMP */
> > 
> >  #if defined(CONFIG_MCOUNT)
> 
> This does not belong into the s390 patch ;-)

Woops, I wonder how that got in there! Thanks, will kill it.

-- 
Jens Axboe
