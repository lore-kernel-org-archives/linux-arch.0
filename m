Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 13 Dec 2005 14:31:47 -0800
From: Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-Id: <20051213143147.d2a57fb3.pj@sgi.com>
In-Reply-To: <6281.1134498864@warthog.cambridge.redhat.com>
References: <20051213094053.33284360.pj@sgi.com>
	<dhowells1134431145@warthog.cambridge.redhat.com>
	<20051212161944.3185a3f9.akpm@osdl.org>
	<20051213075441.GB6765@elte.hu>
	<20051213090219.GA27857@infradead.org>
	<20051213093949.GC26097@elte.hu>
	<20051213100015.GA32194@elte.hu>
	<6281.1134498864@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: David Howells <dhowells@redhat.com>
Cc: mingo@elte.hu, hch@infradead.org, akpm@osdl.org, torvalds@osdl.org, arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

> I'd be especially impressed if you can get it to also analyse the context in
> which the semaphore is used and determine whether or not it should be a
> counting semaphore, a mutex or a completion

That would impress me too, if I could do that.

I think that is well beyond my humble capabilities.

The sed/perl script to make the textual change should be practical.
Indeed, I would claim that the initial big patch -should- be done
that way.  Keep refining a sed script until manual inspection and
trial builds of all arch's, allconfig, show that it seems to be right.
Each time you find an error doing this, don't manually edit the
kernel source; rather refine the script and try applying it again.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
