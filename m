From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] arch/tile: Add driver to enable access to the user dynamic network.
Date: Mon, 28 Jun 2010 21:34:55 +0200
Message-ID: <201006282134.55166.arnd@arndb.de>
References: <201006252110.o5PLArvw010770@farm-0002.internal.tilera.com> <201006281312.16391.arnd@arndb.de> <4C28BE64.4050505@tilera.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:52032 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348Ab0F1TfB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 28 Jun 2010 15:35:01 -0400
In-Reply-To: <4C28BE64.4050505@tilera.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Metcalf <cmetcalf@tilera.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Cc'ing linux-arch on the question of how to use a list_head in
processor.h.

On Monday 28 June 2010 17:23:16 Chris Metcalf wrote:
> > We could break the dependency by turning prefetch_range into a macro
> > or an extern function. There is only one user, and it's in a staging
> > driver, so the impact would be minimal.
> >   
> 
> I don't think so.  The problem is that users of <linux/list.h> expect to
> be able to #include that one header, then use things like
> list_for_each() (which uses prefetch, as defined in <asm/processor.h>),
> but without also being required to #include <asm/processor.h> themselves
> explicitly.

Right.
 
> I think the only "true" fix would be to have a new <linux/list_types.h>
> header that provides list_head (and presumably hlist_head and
> hlist_node), which <linux/list.h> would include, as would our
> <asm/processor.h>.  This is certainly in line with recent
> header-separation changes (e.g. mm_types.h).  Would there be interest in
> a change like this?  I implemented it in my tree, and if it sounds
> plausible to you, I'll send out a git diff, but it looks pretty much
> exactly like this description :-)

Yes, I think that would be a reasonable change.

Another alternative might be to move the prefetch stuff from asm/processor.h
to asm/prefetch.h on all architectures, which also breaks the dependency loop,
unless I'm mistaken again.

	Arnd
