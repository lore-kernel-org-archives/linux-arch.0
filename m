Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <43A19EC4.5040505@nortel.com>
References: <1134559121.25663.14.camel@localhost.localdomain>
	 <13820.1134558138@warthog.cambridge.redhat.com>
	 <20051213143147.d2a57fb3.pj@sgi.com>	<20051213094053.33284360.pj@sgi.com>
	 <dhowells1134431145@warthog.cambridge.redhat.com>
	 <20051212161944.3185a3f9.akpm@osdl.org>	<20051213075441.GB6765@elte.hu>
	 <20051213090219.GA27857@infradead.org>	<20051213093949.GC26097@elte.hu>
	 <20051213100015.GA32194@elte.hu>
	 <6281.1134498864@warthog.cambridge.redhat.com>
	 <14242.1134558772@warthog.cambridge.redhat.com>
	 <16315.1134563707@warthog.cambridge.redhat.com>
	 <1134568731.4275.4.camel@tglx.tec.linutronix.de>	<43A0AD54.6050109@rtr.ca>
	 <20051214155432.320f2950.akpm@osdl.org>
	 <17313.29296.170999.539035@gargle.gargle.HOWL>
	 <1134658579.12421.59.camel@localhost.localdomain>
	 <17313.37200.728099.873988@gargle.gargle.HOWL>
	 <43A19EC4.5040505@nortel.com>
Content-Type: text/plain
Date: Thu, 15 Dec 2005 15:53:30 -0500
Message-Id: <1134680010.13138.70.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: Christopher Friesen <cfriesen@nortel.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, matthew@wil.cx, arjan@infradead.org, torvalds@osdl.org, hch@infradead.org, mingo@elte.hu, pj@sgi.com, dhowells@redhat.com, tglx@linutronix.de, Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Nikita Danilov <nikita@clusterfs.com>
List-ID: <linux-arch.vger.kernel.org>

On Thu, 2005-12-15 at 10:50 -0600, Christopher Friesen wrote:
> Nikita Danilov wrote:
> 
> > And to convert almost all calls to down/up to mutex_{down,up}. At which
> > point, it no longer makes sense to share the same data-type for
> > semaphore and mutex.
> 
> If we're going to call it a mutex, it would make sense to use familiar 
> terminology and call it lock/unlock rather than down/up.

ACK!

-- Steve
