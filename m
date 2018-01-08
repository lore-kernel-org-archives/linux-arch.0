From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 06/18] x86, barrier: stop speculation for failed
 access_ok
Date: Sun, 07 Jan 2018 21:23:47 -0500 (EST)
Message-ID: <20180107.212347.315015145942081238.davem@davemloft.net>
References: <20180107201211.GA9996@1wt.eu>
        <CA+55aFwYEr-x3teixCh5QtyMzXZKdNUkoF4xiw+1zg08PSsvpw@mail.gmail.com>
        <alpine.DEB.2.20.1801072143370.2094@nanos>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.20.1801072143370.2094@nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de
Cc: torvalds@linux-foundation.org, w@1wt.eu, alexei.starovoitov@gmail.com, gnomes@lxorguk.ukuu.org.uk, dan.j.williams@intel.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, ak@linux.intel.com, arnd@arndb.de, gregkh@linuxfoundation.org, peterz@infradead.org, netdev@vger.kernel.org, mingo@redhat.com, hpa@zytor.com
List-Id: linux-arch.vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>
Date: Sun, 7 Jan 2018 21:56:39 +0100 (CET)

> I surely agree, but we have gone the way of PTI without the ability of
> exempting individual processes exactly for one reason:
> 
>   Lack of time
> 
> It can be done on top of the PTI implementation and it won't take ages.
> 
> For spectre_v1/2 we face the same problem simply because we got informed so
> much ahead of time and we were all twiddling thumbs, enjoying our christmas
> vacation and having a good time.

I just want to point out that this should be noted in history as a
case where all of this controlled disclosure stuff seems to have made
things worse rather than better.

Why is there so much haste and paranoia if supposedly some group of
people had all this extra time to think about and deal with this bug?

From what I've seen, every single time, the worse a problem is, the
more important it is to expose it to as many smart folks as possible.
And to do so as fast as possible.

And to me that means full disclosure immediately for the super high
level stuff like what we are dealing with here.

Think I'm nuts?  Ok, then how did we fare any better by keeping this
junk under wraps for weeks if not months?  (seriously, did responsible
people really know about this as far back as... June 2017?)

Controlled disclosure for high propfile bugs seems to only achieve two
things:

1) Vendors can cover their butts and come up with deflection
   strategies.

2) The "theatre" aspect of security can be maximized as much as
   possible.  We even have a pretty web site and cute avatars this
   time!

None of this has anything to do with having time to come up with the
best possible implementation of a fix.  You know, the technical part?

So after what appears to be as much as 6 months of deliberating the
very wise men in the special room said: "KPTI and lfence"

Do I get this right?
