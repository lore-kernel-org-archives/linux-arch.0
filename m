Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
In-Reply-To: <43A0B172.7020800@rtr.ca>
References: <1134559121.25663.14.camel@localhost.localdomain>
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
	 <1134604667.2542.86.camel@tglx.tec.linutronix.de> <43A0B172.7020800@rtr.ca>
Content-Type: text/plain
Date: Thu, 15 Dec 2005 01:10:05 +0100
Message-Id: <1134605406.2542.91.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: Mark Lord <lkml@rtr.ca>
Cc: David Howells <dhowells@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Paul Jackson <pj@sgi.com>, mingo@elte.hu, hch@infradead.org, akpm@osdl.org, torvalds@osdl.org, arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 2005-12-14 at 18:57 -0500, Mark Lord wrote:
> >>Leaving up()/down() as-is is really the most sensible option.
> > 
> ...
> >Doing a s/down/lock_mutex/ s/up/unlock_mutex/ - or whatever naming
> > convention we want to use - all over the place for mutexes while keeping
> > the up/down for counting semaphores is an one time issue.
> > 
> > After the conversion every code breaks at compile time which tries to do
> > up/down(mutex_type).
> > 
> > So the out of tree drivers have a clear indication what to fix. This is
> > also a one time issue.
> > 
> > So where is the problem - except for fixing "huge" amounts of out of
> > kernel code once ?
> 
> Pointless API breakage.  The same functions continue to exist,
> the old names CANNOT be reused for some (longish) time,
> so there's no point in renaming them.  It just breaks an API
> for no good reason whatsoever.

Well, depends on the POV. A counting sempahore is a different beast than
a mutex. At least as far as my limited knowledge of concurrency controls
goes.

The API breakage was introduced by using up/down for mutexes and not by
correcting this to a sane API.

	tglx
