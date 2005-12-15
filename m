Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <20051215121817.2abb0166.akpm@osdl.org>
References: <20051214155432.320f2950.akpm@osdl.org>
	 <1134559121.25663.14.camel@localhost.localdomain>
	 <13820.1134558138@warthog.cambridge.redhat.com>
	 <20051213143147.d2a57fb3.pj@sgi.com> <20051213094053.33284360.pj@sgi.com>
	 <dhowells1134431145@warthog.cambridge.redhat.com>
	 <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu>
	 <20051213090219.GA27857@infradead.org> <20051213093949.GC26097@elte.hu>
	 <20051213100015.GA32194@elte.hu>
	 <6281.1134498864@warthog.cambridge.redhat.com>
	 <14242.1134558772@warthog.cambridge.redhat.com>
	 <16315.1134563707@warthog.cambridge.redhat.com>
	 <1134568731.4275.4.camel@tglx.tec.linutronix.de> <43A0AD54.6050109@rtr.ca>
	 <4336.1134661053@warthog.cambridge.redhat.com>
	 <20051215112855.31669dc1.akpm@osdl.org>
	 <20051215121817.2abb0166.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 15 Dec 2005 16:28:15 -0500
Message-Id: <1134682095.13138.99.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, matthew@wil.cx, arjan@infradead.org, torvalds@osdl.org, hch@infradead.org, mingo@elte.hu, pj@sgi.com, alan@lxorguk.ukuu.org.uk, tglx@linutronix.de, lkml@rtr.ca, dhowells@redhat.com
List-ID: <linux-arch.vger.kernel.org>

On Thu, 2005-12-15 at 12:18 -0800, Andrew Morton wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> >
> > David Howells <dhowells@redhat.com> wrote:
> > >
> > > So... Would you then object to an implementation of a mutex appearing in the
> > >  tree which semaphores that are being used as strict mutexes can be migrated
> > >  over to as the opportunity arises?
> > 
> > That would be sane.
> >
> 
> But not very.
> 
> Look at it from the POV of major architectures: there's no way the new
> mutex code will be faster than down() and up(), so we're adding a bunch of
> new tricky locking code which bloats the kernel and has to be understood
> and debugged for no gain.

I see it as a stepping stone for RT ;)

> 
> And I don't buy the debuggability argument really.  It'd be pretty simple
> to add debug code to the existing semaphore code to trap non-mutex usages. 
> Then go through the few valid non-mutex users and do:
> 
> #if debug
> 	sem->this_is_not_a_mutex = 1;
> #endif

That just looks plain ugly.  Still, if you want to keep the major archs
unchanged (at least until RT is in!) then just add the following:

#define mutex_lock(x) down(x)
#define mutex_unlock(x) up(x)
#define mutex_trylock(x) (!down_trylock(x))  /* see previous email! */

Then you can add your ugly patch ;) where on debug we define those
declared with DEFINE_SEM(x) add the this_is_not_a_mutex = 1

-- Steve


> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
