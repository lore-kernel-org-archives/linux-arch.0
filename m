Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
In-Reply-To: <16315.1134563707@warthog.cambridge.redhat.com>
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
Content-Type: text/plain
Date: Wed, 14 Dec 2005 14:58:50 +0100
Message-Id: <1134568731.4275.4.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: David Howells <dhowells@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Paul Jackson <pj@sgi.com>, mingo@elte.hu, hch@infradead.org, akpm@osdl.org, torvalds@osdl.org, arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 2005-12-14 at 12:35 +0000, David Howells wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
> > Why bother. As has already been discussed up and down are the natural
> > and normal names for counting semaphores. You don't need to obsolete the
> > old API thats just silly, you need to add a new one and wait for people
> > to use it.
> 
> The vast majority of ups and downs are actually mutex related not semaphore
> related, so by majority share, up/down perhaps ought to be repurposed to
> mutexes: they _are_ the preeminent uses.
> 
> From my modified tree, I see:
> 
> 	semaphore	up	down	down_in	down_try
> 	Counting	41	59	1	0
> 	Mutex		4405	2824	362	107
> 
> > The old API is still very useful for some applications that want
> > counting semaphores.
> 
> Whilst that is true, they're in a small minority, and it'd be easier to change
> them.

You can do a full scripted rename of up/down to the mutex API and then
fix up the 100 places used by semaphores manually.

	tglx
