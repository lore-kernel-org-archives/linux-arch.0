Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Sun, 18 Dec 2005 11:54:32 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/12]: MUTEX: Implement mutexes
In-Reply-To: <1134934887.3517.15.camel@mulgrave>
Message-ID: <Pine.LNX.4.64.0512181153080.4827@g5.osdl.org>
References: <Pine.LNX.4.64.0512162334440.3698@g5.osdl.org>
 <dhowells1134774786@warthog.cambridge.redhat.com>
 <200512162313.jBGND7g4019623@warthog.cambridge.redhat.com>
 <1134791914.13138.167.camel@localhost.localdomain>
 <14917.1134847311@warthog.cambridge.redhat.com>  <Pine.LNX.4.64.0512171201200.3698@g5.osdl.org>
  <Pine.LNX.4.64.0512172018410.26663@localhost.localdomain>
 <Pine.LNX.4.64.0512171803580.3698@g5.osdl.org>
 <Pine.LNX.4.64.0512172150260.26663@localhost.localdomain>
 <Pine.LNX.4.64.0512172227280.3698@g5.osdl.org>  <20051218092616.GA17308@flint.arm.linux.org.uk>
  <Pine.LNX.4.64.0512181027220.4827@g5.osdl.org> <1134934887.3517.15.camel@mulgrave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Nicolas Pitre <nico@cam.org>, David Howells <dhowells@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, mingo@redhat.com, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>



On Sun, 18 Dec 2005, James Bottomley wrote:
> 
> Actually, I don't think you want might_sleep(): there are a few cases
> where we do an up() from under a spinlock, which will spuriously trigger
> this.  I'd suggest WARN_ON(in_interrupt()) instead.

Ahh, good point. Yes.

However, if even the arm people aren't all that interested in this, maybe 
it simply doesn't matter. A lot of other architectures either have 
"decrement in memory" or can already use ll/sc for it.

(of course, on some architectures, ll/sc is really really slow, so they 
might well prefer using a normal load and store instead).

		Linus
