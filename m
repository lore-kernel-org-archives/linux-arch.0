From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH v2 00/10] Rework READ_ONCE() to improve codegen
Date: Thu, 23 Jan 2020 17:32:06 +0000
Message-ID: <2bfe2be6da484f15b0d229dd02d16ae6@AcuMS.aculab.com>
References: <20200123153341.19947-1-will@kernel.org>
 <26ad7a8a975c4e06b44a3184d7c86e5f@AcuMS.aculab.com>
 <20200123171641.GC20126@willie-the-truck>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200123171641.GC20126@willie-the-truck>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: 'Will Deacon' <will@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "kernel-team@android.com" <kernel-team@android.com>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Peter Oberparleiter <oberpar@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>
List-Id: linux-arch.vger.kernel.org

From: Will Deacon
> Sent: 23 January 2020 17:17
> 
> On Thu, Jan 23, 2020 at 05:07:40PM +0000, David Laight wrote:
> > From: Will Deacon
> > > Sent: 23 January 2020 15:34
> > ...
> > >   * Only warn once at build-time if GCC prior to 4.8 is detected...
> > >
> > >   * ... and then raise the minimum GCC version to 4.8, with an error for
> > >     older versions of the compiler
> >
> > If the kernel compiled with gcc 4.7 is likely to be buggy, don't these
> > need to be in the other order?
> >
> > Otherwise you need to keep the old versions for use with the old
> > compilers.
> 
> I think it depends how much we care about those older compilers. My series
> first moves it to "Good luck mate, you're on your own" and then follows up
> with a "Let me take that off you it's sharp".

Depends on how 'sharp' it is.

If the kernel suffers from the code example in the gcc bug itself
(where 'volatile' is lost and some code is moved out of a loop)
then things will really break somewhere odd.

OTOH if it might generate code that reads something twice
you'd have to be unlucky as well.

Oh - and I need to find a newer compiler :-(

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
