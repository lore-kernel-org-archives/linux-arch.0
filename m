From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: Re: [PATCH 1/23] make section names compatible with -ffunction-sections -fdata-sections
Date: Wed, 2 Jul 2008 09:09:40 +0200
Message-ID: <200807020909.40557.vda.linux@googlemail.com>
References: <200807020233.48646.vda.linux@googlemail.com> <20080701213006.5502987a.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-embedded-owner@vger.kernel.org>
In-Reply-To: <20080701213006.5502987a.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-embedded-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, David Howells <dhowells@redhat.com>, Ralf Baechle <ralf@linux-mips.org>, Lennert Buytenhek <kernel@wantstofly.org>, Josh Boyer <jwboyer@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, David Woodhouse <dwmw2@infradead.org>, Andi Kleen <andi@firstfloor.org>, torvalds@linux-foundation.org, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-embedded@vger.kernel.org, linux-kernel@vger.kernel.org, Tim Bird <tim.bird@am.sony.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Dave Miller <davem@davemloft.net>
List-Id: linux-arch.vger.kernel.org

On Wednesday 02 July 2008 06:30, Andrew Morton wrote:
> On Wed, 2 Jul 2008 02:33:48 +0200 Denys Vlasenko <vda.linux@googlemail.com> wrote:
> > I am unsure how to synchronize propagation of these patches
> > across all architectures.
> > 
> > Andrew, how this can be done without causing lots of pain
> > for arch maintainers? Please advise.
> 
> You didn't describe the problem which you're trying to solve, so how
> can I say?

The problem is that with -ffunction-sections -fdata-sections gcc
will create sections like .text.head and .data.nosave
whenever someone will have innocuous code like this:

static void head(...) {...}

or this:

int f(...)
{ 
	static int nosave;
...
}

somewhere in the kernel.

Then kernel linker script will be confused and put these sections
in wrong places.

IOW: names like .text.XXXX and .data.XXX must not be used for "magic"
sections.


> Possibilities are:
> 
> a) the generic bit depends on the arch bits
> 
>    -> No probs.  I can merge the generic bit once all architectures are in.
> 
> b) the arch bits depend on the generic bits
> 
>    -> No probs.  I can merge the generic bit then send all the arch bits.
> 
> c) they each depend on each other
> 
>    -> No probs.  We go round gaththering acks, slam it all into
>       a single patch then in it goes.  2.6.28, presumably.

It's definitely (c). Changes in, say, include/linux/init.h:

-#define __nosavedata __section(.data.nosave)
+#define __nosavedata __section(.nosave.data)

must be syncronized with, say, arch/arm/kernel/vmlinux.lds.S:

                . = ALIGN(4096);
                __nosave_begin = .;
-               *(.data.nosave)
+               *(.nosave.data)

> > The following patches fix section names, one per architecture.
> > 
> > The patch in _this_ mail fixes generic part.
> 
> (tries to work out what it does)
> 
> oh, it does the above section renaming.  So I guess we're looking at
> scenario c), above?
> 
> "otherwise section placement done by kernel's custom linker scripts
> produces broken vmlinux and vdso images" is an inadequate description. 
> Please describe the problem more completely.  This is important,
> because once we actually find out what the patch is fixing, perhaps
> others will be aware of less intrusive ways of fixing the problem, and
> we end up with a better patch.

See above. Is that explanation ok?

> Please be aware that last time someone tried function-sections, maybe
> five years ago, problems were encountered with linker efficiency
> (possible an O(nsections) or worse algorithm in ld).  Link times went
> up a lot.

Last time is was probably me :) about a year ago I think.
Last link stage takes niticeably more time, but
nothing really awful.

> So it would be good to hunt down some old ld versions and run some
> timings.  A mention of the results in the changelog is appropriate.
> 
> Is there actually a patch anywhere which enables function-sections for
> some architectures?  It would be good to see that (and its associated
> size-reduction results) so we can work out whether all these changes
> are worth pursuing.

Yes, I was posting it twice during last year.
(digging up old emails from "sent" folder...) here is some:

On Friday 07 September 2007 19:30, Denys Vlasenko wrote:
> On Friday 07 September 2007 17:31, Daniel Walker wrote:
> > On Thu, 2007-09-06 at 18:07 +0100, Denys Vlasenko wrote:
> > > A bit extended version:
> > > 
> > > In the process in making it work I saw ~10% vmlinux size reductions
> > > (which basically matches what Marcelo says) when I wasn't retaining
> > > sections needed for EXPORT_SYMBOLs, but module loading didn't work.
> > > 
> > > Thus I fixed that by adding KEEP() directives so that EXPORT_SYMBOLs
> > > are never discarded. This was just one of many fixes until kernel
> > > started to actually boot and work.
> > > 
> > > I did that before I posted patches to lkml.
> > > IOW: posted patches are not broken versus module loading.
> > 
> > Ok, this is more like the explanation I was looking for..
> > 
> > During this thread you seemed to indicate the patches you release
> > reduced the kernel ~10% , but now your saying that was pre-release ,
> > right?
> 
> CONFIG_MODULE=n will save ~10%
> CONFIG_MODULE=y - ~1%
> 
> Exact figure depends on .config (whether you happen to include
> especially "fat" code or not).

--
vda
