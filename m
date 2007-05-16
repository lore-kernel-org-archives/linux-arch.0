Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:38895 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756223AbXEPSK7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 16 May 2007 14:10:59 -0400
Subject: Re: [RFC] Explicitly mark global functions with vmlinux with
	__global
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <20070516095027.f5d463ff.akpm@linux-foundation.org>
References: <1179333273.2859.282.camel@shinybook.infradead.org>
	 <20070516095027.f5d463ff.akpm@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 May 2007 02:10:53 +0800
Message-Id: <1179339053.2859.328.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: torvalds@linux-foundation.org, sam@ravnborg.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 2007-05-16 at 09:50 -0700, Andrew Morton wrote:
> On Thu, 17 May 2007 00:34:33 +0800 David Woodhouse <dwmw2@infradead.org> wrote:
> 
> > A while ago, I played with using '-fwhole-program --combine' for
> > building kernel objects -- http://lwn.net/Articles/197097/
> > 
> > A found a few compiler bugs which I think should mostly be fixed now, so
> > I'm revisiting the kernel bits. The original patches I had looked
> > something like this:
> > 
> > http://david.woodhou.se/combine/combine-diff-1-fixes.patch
> > http://david.woodhou.se/combine/combine-diff-2-core.patch
> > http://david.woodhou.se/combine/combine-diff-3-global.patch
> > http://david.woodhou.se/combine/combine-diff-4-hacks.patch
> > 
> > Essentially, it added a CONFIG_COMBINED_COMPILE option which would build
> > every multi-part object (including built-in.o) with the -fwhole-program
> > and --combine flags. We saw savings of up to 14% in size in a few
> > places, and a more realistic 5-6% in many more.
> 
> So..  is 5% a reasonable estimate of the overall gain which we're likely to
> see here?

That kind of ball-park, I imagine; maybe a little less. I'll have to try
it again and see precisely what the numbers were overall. My old numbers
are at http://david.woodhou.se/combine/sizes-sorted.csv -- tuples of
(old,new,Δ,%,object).

The reason I say 'maybe a little less' is because I concentrated on
modules at the time because the Kbuild stuff was relatively easy for
those -- and I have a vague recollection that the built-in stuff didn't
show as big a difference. Searching for 'built-in.o' in the above-linked
CSV file seems to confirm that recollection.

When I do turn my attention to the kernel proper, once thing I want to
try is combining more than one directory at a time. I wouldn't do many,
but I suspect it would make sense to combine mm/ and arch/$ARCH/mm -- to
build all files in both of those at the same time. Likewise for kernel/
and arch/$ARCH/kernel/ -- or maybe even all four together. Or maybe
copmbine fs/ and mm/. I'll do some investigation as to precisely where
the best benefits are to be found.

There's a trade-off, obviously. We can't just build _every_ C file all
at the same time because the amount of memory used for that would be
insane. So we pick the bits which actually make _sense_ to show to the
optimiser at the same time, while keeping it broken down into manageable
chunks.

> And do we know specifically where that gain is coming from?  How the
> compiler/linker is achieving this?  If it's because we're all slackers,
> perhaps similar gains could come from manual fixes.

It's not always as simple as that. Sometimes it's cleaner to split stuff
up according to some _other_ criterion than what functions get exposed
to the optimiser together.

File systems are an obvious example of this -- perhaps they'd be
_optimal_ if we stuck them all into a single file, but I don't think
anyone would seriously advocate that.

The split between mm and arch/$ARCH/mm is another example.

> Would it be true to say that most such symbols are already marked with
> EXPORT_SYMBOL()?  If so, then I'd have thought that EXPORT_SYMBOL_INTERNAL
> would be a better approach, as less additional markups would be needed.

Er, it's exactly the same number of additional markups either way.

Yes, although I didn't actually count, I do think that 'most' are
already marked with EXPORT_SYMBOL, which is why I've already hacked
EXPORT_SYMBOL() to also mark the symbol in question with the appropriate
attributes -- so we don't need to add __global to anything which is
marked with EXPORT_SYMBOL().

It's only those symbols which are global within vmlinux but _not_
exported to modules which would need an additional marking. That marking
could be either EXPORT_SYMBOL_INTERNAL() or __global -- I'm mostly
ambivalent. I think I chose __global last time just because it was
easier to do in a semi-automatic fashion.

> I'd be concerned about ongoing maintainability.  If someone makes a change
> which breaks CONFIG_COMBINED_COMPILE then how would we be notified about
> it?

The most likely failure mode -- other than the WeirdShit™ which
accompanies a compiler bug -- is an unresolved symbol in the final link.
That isn't particularly hard to deal with, and in fact is precisely how
most of my 'combine-diff-3-global.patch' came about. You find the symbol
it's bitching about, and you mark it __global. I'm sure we have an
_army_ of people capable of doing test builds and catching missing tags
like that.

> And I assume that notification would only be visible to
> CONFIG_COMBINED_COMPILE users, so...  will this feature be available on
> x86_64 and i386, and what toolchain version is required?

Er, there may be tricks we can play to make notification available to
others. Maybe not, but I'll take a look.

Regarding the toolchain version -- last time I looked, at this, about a
year ago, I filed a stream of GCC bugs (again, listed under the lwn link
above¹). I will test gcc 4.2 and I expect it should be OK. I believe
Fedora's toolchain should also cope -- I'll make sure it does, because
we want this for OLPC.

Obviously I posted these patches just as an FYI last time, since I was
the only person in the world with a compiler that could cope. The reason
I'm revisiting it now is because it should actually be of use to someone
else too, this time :)

I'd normally do ppc32, ppc64 and i386 for myself -- I can't test booting
x86_64 but I can at least make sure it compiles. Would you believe
x86_64 is one of the few Linux architectures which I _don't_ have a
sample of?

-- 
dwmw2

¹ although the list there has a typo -- s/27889/27899/

