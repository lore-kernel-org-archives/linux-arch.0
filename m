From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH 06/18] x86, barrier: stop speculation for failed
 access_ok
Date: Sun, 07 Jan 2018 09:19:20 -0800
Message-ID: <1515345560.3075.7.camel@HansenPartnership.com>
References: <20180106181331.mmrqwwbu2jcjj2si@ast-mbp>
         <20180106183859.1ad9ae37@alans-desktop> <20180106204229.GD9075@1wt.eu>
         <20180106.203654.731754766847198456.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180106.203654.731754766847198456.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>, w@1wt.eu
Cc: gnomes@lxorguk.ukuu.org.uk, alexei.starovoitov@gmail.com, torvalds@linux-foundation.org, dan.j.williams@intel.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, ak@linux.intel.com, arnd@arndb.de, gregkh@linuxfoundation.org, peterz@infradead.org, netdev@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de
List-Id: linux-arch.vger.kernel.org

On Sat, 2018-01-06 at 20:36 -0500, David Miller wrote:
> From: Willy Tarreau <w@1wt.eu>
> Date: Sat, 6 Jan 2018 21:42:29 +0100
> 
> > On Sat, Jan 06, 2018 at 06:38:59PM +0000, Alan Cox wrote:
> >> Normally people who propose security fixes don't have to argue
> about the
> >> fact they added 30 clocks to avoid your box being 0wned.
> > 
> > In fact it depends, because if a fix makes the system unusable for
> its
> > initial purpose, this fix will simply not be deployed at all, which
> is
> > the worst that can happen.
> 
> +1
> 
> I completely agree with Willy and Alexei.
> 
> And the scale isn't even accurate, we're talking about at least
> hundreds upon hundreds of clocks, not 30, if we add an operation
> whose side effect is to wait for all pending loads to complete.  So
> yeah this is going to be heavily scrutinized.

Plus this is the standard kernel code review MO: we've never blindly
accepted code just because *security* (otherwise we'd have grsec in by
now).  We use the pushback to get better and more performant code.
 What often happens is it turns out that the "either security or
performance" position was a false dichotomy and there is a way of
fixing stuff that's acceptable (although not usually perfect) for
everyone.  I'm not saying this always happens, but it is reasonable to
let the iterative pushback see if we can get to better code in this
case rather than trying to cut it of with the "because *security*"
argument.

James
