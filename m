From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 06/18] x86, barrier: stop speculation for failed access_ok
Date: Mon, 8 Jan 2018 08:38:33 +0100
Message-ID: <20180108073833.GA19819@kroah.com>
References: <20180107201211.GA9996@1wt.eu>
 <CA+55aFwYEr-x3teixCh5QtyMzXZKdNUkoF4xiw+1zg08PSsvpw@mail.gmail.com>
 <alpine.DEB.2.20.1801072143370.2094@nanos>
 <20180107.212347.315015145942081238.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180107.212347.315015145942081238.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: tglx@linutronix.de, torvalds@linux-foundation.org, w@1wt.eu, alexei.starovoitov@gmail.com, gnomes@lxorguk.ukuu.org.uk, dan.j.williams@intel.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, ak@linux.intel.com, arnd@arndb.de, peterz@infradead.org, netdev@vger.kernel.org, mingo@redhat.com, hpa@zytor.com
List-Id: linux-arch.vger.kernel.org

On Sun, Jan 07, 2018 at 09:23:47PM -0500, David Miller wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Sun, 7 Jan 2018 21:56:39 +0100 (CET)
> 
> > I surely agree, but we have gone the way of PTI without the ability of
> > exempting individual processes exactly for one reason:
> > 
> >   Lack of time
> > 
> > It can be done on top of the PTI implementation and it won't take ages.
> > 
> > For spectre_v1/2 we face the same problem simply because we got informed so
> > much ahead of time and we were all twiddling thumbs, enjoying our christmas
> > vacation and having a good time.
> 
> I just want to point out that this should be noted in history as a
> case where all of this controlled disclosure stuff seems to have made
> things worse rather than better.

I will note that the "controlled disclosure" for this thing was a total
and complete mess, and unlike any that I have ever seen in the past.
The people involved in running it had no idea how to do it at all, and
because of that, it failed miserably, despite being warned about it
numerous times by numerous people.

> Why is there so much haste and paranoia if supposedly some group of
> people had all this extra time to think about and deal with this bug?

Because that group was so small and isolated that they did not actually
talk to anyone who could actually provide input to help deal with the
bug.

So we are stuck now with dealing with this "properly", which is fine,
but please don't think that this is an excuse to blame "controlled
disclosure".  We know how to do that correctly, it did not happen in
this case at all because of the people driving the problem refused to do
it.

> Think I'm nuts?  Ok, then how did we fare any better by keeping this
> junk under wraps for weeks if not months?  (seriously, did responsible
> people really know about this as far back as... June 2017?)

Some "people" did, just not some "responsible people" :)

Oh well, time for the kernel to fix hardware bugs again, that's what we
are here for, you would think we would be used to it by now...

greg k-h
