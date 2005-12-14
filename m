Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <20051214033536.05183668.akpm@osdl.org>
References: <439EDC3D.5040808@nortel.com>
	 <1134479118.11732.14.camel@localhost.localdomain>
	 <dhowells1134431145@warthog.cambridge.redhat.com>
	 <3874.1134480759@warthog.cambridge.redhat.com>
	 <15167.1134488373@warthog.cambridge.redhat.com>
	 <1134490205.11732.97.camel@localhost.localdomain>
	 <1134556187.2894.7.camel@laptopd505.fenrus.org>
	 <1134558188.25663.5.camel@localhost.localdomain>
	 <1134558507.2894.22.camel@laptopd505.fenrus.org>
	 <1134559470.25663.22.camel@localhost.localdomain>
	 <20051214033536.05183668.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 14 Dec 2005 12:44:31 +0100
Message-Id: <1134560671.2894.30.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, dhowells@redhat.com, cfriesen@nortel.com, torvalds@osdl.org, hch@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 2005-12-14 at 03:35 -0800, Andrew Morton wrote:
> Could someone please remind me why we're even discussing this,

* cleaner API
* more declarative in terms of intent

which in turn allow
* higher performance
* enhanced options like the -rt patch is doing, such as boosting
processes when a semaphore they're holding hits contention
* mutex use is a candidate for a "spinaphore" treatment (unlike counting
semaphores)

>  given that
> mutex_down() is slightly more costly than current down(), and mutex_up() is
> appreciably more costly than current up()?

that's an implementation flaw in the current implementation that is not
needed by any means and that Ingo has fixed in his version of this
