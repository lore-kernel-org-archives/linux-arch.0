Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <43A0AD54.6050109@rtr.ca>
Date: Wed, 14 Dec 2005 18:40:04 -0500
From: Mark Lord <lkml@rtr.ca>
MIME-Version: 1.0
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
References: <1134559121.25663.14.camel@localhost.localdomain>	 <13820.1134558138@warthog.cambridge.redhat.com>	 <20051213143147.d2a57fb3.pj@sgi.com> <20051213094053.33284360.pj@sgi.com>	 <dhowells1134431145@warthog.cambridge.redhat.com>	 <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu>	 <20051213090219.GA27857@infradead.org> <20051213093949.GC26097@elte.hu>	 <20051213100015.GA32194@elte.hu>	 <6281.1134498864@warthog.cambridge.redhat.com>	 <14242.1134558772@warthog.cambridge.redhat.com>	 <16315.1134563707@warthog.cambridge.redhat.com> <1134568731.4275.4.camel@tglx.tec.linutronix.de>
In-Reply-To: <1134568731.4275.4.camel@tglx.tec.linutronix.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: tglx@linutronix.de
Cc: David Howells <dhowells@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Paul Jackson <pj@sgi.com>, mingo@elte.hu, hch@infradead.org, akpm@osdl.org, torvalds@osdl.org, arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Thomas Gleixner wrote:
>
> You can do a full scripted rename of up/down to the mutex API and then
> fix up the 100 places used by semaphores manually.

Again, folks, this only works for current in-tree kernel code.

There are huge amounts of kernel code out-of-tree that still use
up/down as (or potentially as) counting semaphores.

Yes, some of that code is closed-source, but most of it is open-source
stuff in people's "queues", such as the network patch-o-matic queue
and other stuff.  Lots of open-source out-of-tree drivers, too.

Re-using the existing up()/down() names for a new purpose is
a very very Bad Idea.  Removing up()/down() entirely is not quite so bad,
because at least then people will eventually notice the change.

Leaving up()/down() as-is is really the most sensible option.

Cheers
