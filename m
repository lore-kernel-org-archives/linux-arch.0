Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 14 Dec 2005 15:54:32 -0800
From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-Id: <20051214155432.320f2950.akpm@osdl.org>
In-Reply-To: <43A0AD54.6050109@rtr.ca>
References: <1134559121.25663.14.camel@localhost.localdomain>
	<13820.1134558138@warthog.cambridge.redhat.com>
	<20051213143147.d2a57fb3.pj@sgi.com>
	<20051213094053.33284360.pj@sgi.com>
	<dhowells1134431145@warthog.cambridge.redhat.com>
	<20051212161944.3185a3f9.akpm@osdl.org>
	<20051213075441.GB6765@elte.hu>
	<20051213090219.GA27857@infradead.org>
	<20051213093949.GC26097@elte.hu>
	<20051213100015.GA32194@elte.hu>
	<6281.1134498864@warthog.cambridge.redhat.com>
	<14242.1134558772@warthog.cambridge.redhat.com>
	<16315.1134563707@warthog.cambridge.redhat.com>
	<1134568731.4275.4.camel@tglx.tec.linutronix.de>
	<43A0AD54.6050109@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Mark Lord <lkml@rtr.ca>
Cc: tglx@linutronix.de, dhowells@redhat.com, alan@lxorguk.ukuu.org.uk, pj@sgi.com, mingo@elte.hu, hch@infradead.org, torvalds@osdl.org, arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Mark Lord <lkml@rtr.ca> wrote:
>
> Leaving up()/down() as-is is really the most sensible option.
>

Absolutely.

I must say that my interest in this stuff is down in
needs-an-electron-microscope-to-locate territory.  down() and up() work
just fine and they're small, efficient, well-debugged and well-understood. 
We need a damn good reason for taking on tree-wide churn or incompatible
renames or addition of risk.  What's the damn good reason here?

Please.  Go fix some bugs.  We're not short of them.
