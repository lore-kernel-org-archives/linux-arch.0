Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:30115 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750816AbWISPI4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 19 Sep 2006 11:08:56 -0400
Date: Tue, 19 Sep 2006 16:08:31 +0100
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 5/7] Alter get_order() so that it can make use of ilog2() on a constant [try #3]
Message-ID: <20060919150831.GA28570@infradead.org>
References: <20060919003031.166d08a4.akpm@osdl.org> <20060913183522.22109.10565.stgit@warthog.cambridge.redhat.com> <20060913183531.22109.85723.stgit@warthog.cambridge.redhat.com> <23843.1158656897@warthog.cambridge.redhat.com> <20060919080324.601e50f9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060919080324.601e50f9.akpm@osdl.org>
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Sep 19, 2006 at 08:03:24AM -0700, Andrew Morton wrote:
> On Tue, 19 Sep 2006 10:08:17 +0100
> David Howells <dhowells@redhat.com> wrote:
> 
> > > I didn't pursue it further, because sprinkling ARCH_HAS_FOO things into
> > > bitops.h(!) is all rather hacky.  Better to use CONFIG_* so they're always
> > > visible and one knows where to go to find things.
> > 
> > But (1) they're not config options,
> 
> Well they are, really.  "This architecture has its own get_order()".  It's
> not *user* configurable, but neither is, say CONFIG_GENERIC_HARDIRQS.
> 
> The problem we have with the ARCH_HAS_FOO things is that there's never been
> an include/asm/arch_has_foo.h in which to define them, so stuff gets
> sprinkled all over the place.
> 
> > and (2) there's plenty of precedent for
> > this sort of thing (ARCH_HAS_PREFETCH for example).
> 
> There's precedent both ways.  The advantages of doing it in config are
> 
> a) You know where to go to find it: arch/foo/Kconfig
> 
> b) It's always available, due to forced inclusion of config.h.
> 
> (I think I actually would prefer include/asm/arch_has_foo.h if we had it,
> because it's lighter-weight.  But we don't)

That approach has the problem of not beeing available in the Kconfig
language and thus the Makefiles, so we can't compile files conditionally
on it.   Otherwise I'd say just add asm/config.h, include it automatically
and go ahead.
