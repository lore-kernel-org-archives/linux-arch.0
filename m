From: Rob Landley <rob@landley.net>
Subject: Re: Generic syscall ABI support
Date: Thu, 28 Mar 2013 23:41:37 -0500
Message-ID: <1364532097.18069.7@driftwood>
References: <201303281142.47631.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201303281142.47631.arnd@arndb.de> (from arnd@arndb.de on Thu
	Mar 28 06:42:47 2013)
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ley Foon Tan <lftan@altera.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 03/28/2013 06:42:47 AM, Arnd Bergmann wrote:
> On Thursday 28 March 2013, Ley Foon Tan wrote:
> > On Thu, 2013-03-28 at 10:40 +0000, Arnd Bergmann wrote:
> > > On Thursday 28 March 2013, Ley Foon Tan wrote:
> > > > We will working on generic ABI for kernel and Glibc. This might  
> take
> > > > some times.
> > >
> > > Ok. Don't let that hold you up from submitting the kernel patches
> > > for review though.
> >
> > Do you mean we can submit the patches for review before we got the
> > generic ABI support?
> 
> I mean you can send the other patches for review already. Changing
> your implementtion to use the generic ABI will basically just mean
> not sending the patches tht implement your own ABI, so that's not
> hard. Of course until you also have a new glibc port, you won't be
> able to test that it actually works, but that is not essential for
> the reviewing stage.

You don't need a new glibc port, you need a new klibc or musl port.

   http://www.openwall.com/lists/musl/2012/07/08/1

Way less work than getting glibc working for your basic smoketest...

Rob