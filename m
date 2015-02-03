Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:36216 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202AbbBCJeK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 3 Feb 2015 04:34:10 -0500
Received: by mail-la0-f51.google.com with SMTP id ge10so49754714lab.10
        for <linux-arch@vger.kernel.org>; Tue, 03 Feb 2015 01:34:08 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [RFC] change non-atomic bitops method
References: <35FD53F367049845BC99AC72306C23D1044A02027E0A@CNBJMBX05.corpusers.net>
	<20150202152909.13bfd11f192fb0268b2ab4bf@linux-foundation.org>
	<20150203011730.GA15653@node.dhcp.inet.fi>
	<35FD53F367049845BC99AC72306C23D1044A02027E0B@CNBJMBX05.corpusers.net>
	<35FD53F367049845BC99AC72306C23D1044A02027E0C@CNBJMBX05.corpusers.net>
	<20150202223851.f30768d0.akpm@linux-foundation.org>
Date: Tue, 03 Feb 2015 10:34:05 +0100
In-Reply-To: <20150202223851.f30768d0.akpm@linux-foundation.org> (Andrew
	Morton's message of "Mon, 2 Feb 2015 22:38:51 -0800")
Message-ID: <8761bjjq42.fsf@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Wang, Yalin" <Yalin.Wang@sonymobile.com>, "'Kirill A. Shutemov'" <kirill@shutemov.name>, "'arnd@arndb.de'" <arnd@arndb.de>, "'linux-arch@vger.kernel.org'" <linux-arch@vger.kernel.org>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'linux@arm.linux.org.uk'" <linux@arm.linux.org.uk>, "'linux-arm-kernel@lists.infradead.org'" <linux-arm-kernel@lists.infradead.org>
Message-ID: <20150203093405.cjYTwBNnXczYsAS5R_fH_ze-_uY0uvi76z8LeSv-rCI@z>

On Tue, Feb 03 2015, Andrew Morton <akpm@linux-foundation.org> wrote:

>
> You aren't measuring the right thing.  You should compare
>
> 	if (p[i] != x)
> 		p[i] = x;
>
> versus
>
> 	p[i] = x;
>
> and you should do this for two cases:
>
> a) p[i] == x
>
> b) p[i] != x
>
>
> The first code sequence will be slower when (p[i] != x) and faster when
> (p[i] == x).
>
>
> Next, we should instrument the kernel to work out the frequency of
> set_bit on an already-set bit.
>
> It is only with both these ratios that we can work out whether the
> patch is a net gain.  My suspicion is that set_bit on an already-set
> bit is so rare that the patch will be a loss.

There's also the code-bloat issue to consider (instruction cache and all
that); the conditional versions will usually require three extra
instructions and an extra register. Also, the cache line might already
be dirty because of something in the surrounding code. Instruction cache
misses and larger stack footprint (from larger register pressure) won't
show up in a microbenchmark, so I think this needs a real-world example
to justify.

But even if one finds some hot spot that would benefit from the
conditional, that should simply be added explicitly there, instead of
pessimizing every other user. (A good example of that is 358eec18243a
("vfs: decrapify dput(), fix cache behavior under normal load")).

Rasmus
