Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:51236 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752702AbXEPQxc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 16 May 2007 12:53:32 -0400
Date: Wed, 16 May 2007 09:50:27 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC] Explicitly mark global functions with vmlinux with
 __global
Message-Id: <20070516095027.f5d463ff.akpm@linux-foundation.org>
In-Reply-To: <1179333273.2859.282.camel@shinybook.infradead.org>
References: <1179333273.2859.282.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: torvalds@linux-foundation.org, sam@ravnborg.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, 17 May 2007 00:34:33 +0800 David Woodhouse <dwmw2@infradead.org> wrote:

> A while ago, I played with using '-fwhole-program --combine' for
> building kernel objects -- http://lwn.net/Articles/197097/
> 
> A found a few compiler bugs which I think should mostly be fixed now, so
> I'm revisiting the kernel bits. The original patches I had looked
> something like this:
> 
> http://david.woodhou.se/combine/combine-diff-1-fixes.patch
> http://david.woodhou.se/combine/combine-diff-2-core.patch
> http://david.woodhou.se/combine/combine-diff-3-global.patch
> http://david.woodhou.se/combine/combine-diff-4-hacks.patch
> 
> Essentially, it added a CONFIG_COMBINED_COMPILE option which would build
> every multi-part object (including built-in.o) with the -fwhole-program
> and --combine flags. We saw savings of up to 14% in size in a few
> places, and a more realistic 5-6% in many more.

So..  is 5% a reasonable estimate of the overall gain which we're likely to
see here?

And do we know specifically where that gain is coming from?  How the
compiler/linker is achieving this?  If it's because we're all slackers,
perhaps similar gains could come from manual fixes.

> Since -fwhole-program makes the compiler assume everything is 'static' I
> needed to explicitly mark some stuff as _not_ static, if it was used by
> other things outside the same directory. EXPORT_SYMBOL could obviously
> be used for that, but then there were some things which were global
> _within_ vmlinux but not exported to modules -- and marking those with
> __global was the majority of the patchset above; the third patch.
> 
> Before I steam ahead and do it all again, I'd like to revisit that. My
> old patches had
> 	 #define __global __attribute__((externally_visible,used))
> and went on to look a bit like the patch below. For the OLPC test build
> I was playing with, I had:
>  75 files changed, 238 insertions(+), 239 deletions(-)
> 
> Another way of doing it would be to add an 'EXPORT_SYMBOL_INTERNAL' or
> some such, instead of __global. To be perfectly honest, I don't recall
> my reasons for choosing __global over that.

Would it be true to say that most such symbols are already marked with
EXPORT_SYMBOL()?  If so, then I'd have thought that EXPORT_SYMBOL_INTERNAL
would be a better approach, as less additional markups would be needed.

> Anyway, the point of the RFC... should I go ahead with creating patches
> which add this __global marking where it's needed (it can be a no-op for
> now anyway)? Or does anyone have any better plans? It wouldn't be as
> _much_ of a pain for Andrew as the irc_reqs thing was, but it's possibly
> still worth co-ordinating it -- if I go ahead and do it, when would be
> the best time to merge it?

I'd be concerned about ongoing maintainability.  If someone makes a change
which breaks CONFIG_COMBINED_COMPILE then how would we be notified about
it?

And I assume that notification would only be visible to
CONFIG_COMBINED_COMPILE users, so...  will this feature be available on
x86_64 and i386, and what toolchain version is required?
