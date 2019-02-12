Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46474 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727750AbfBLNDY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Feb 2019 08:03:24 -0500
MIME-Version: 1.0
References: <20190211172948.3322-1-will.deacon@arm.com>
In-Reply-To: <20190211172948.3322-1-will.deacon@arm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 12 Feb 2019 14:03:04 +0100
Message-ID: <CAK8P3a2Pr2oWYB7QHQMaHRq6H8h9xMwhhyJz5Pu67bVe4GaK9g@mail.gmail.com>
Subject: Re: [RFC PATCH] docs/memory-barriers.txt: Rewrite "KERNEL I/O BARRIER
 EFFECTS" section
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20190212130304.VaWdqLPf8RG0oapC43M1bqc2ze5J0kfbHAVLI2ex6eo@z>

On Mon, Feb 11, 2019 at 6:29 PM Will Deacon <will.deacon@arm.com> wrote:

> +     __iomem pointers obtained with non-default attributes (e.g. those returned
> +     by ioremap_wc()) are unlikely to provide many of these guarantees. If
> +     ordering is required for such mappings, then the mandatory barriers should
> +     be used in conjunction with the _relaxed() accessors defined below.

I wonder if we are even able to guarantee consistent behavior across
architectures
in the last case here (wc mapping with relaxed accessors and barriers).

Fortunately, there are only five implementations that actually differ from
ioremap_nocache(): arm32, arm64, ppc32, ppc64 and x86 (both 32/64), so
that is something we can probably figure out between the people on Cc.

The problem with recommending *_relaxed() + barrier() is that it ends
up being more expensive than the non-relaxed accessors whenever
_relaxed() implies the barrier already (true on most architectures other
than arm).

ioremap_wc() in turn is used almost exclusively to map RAM behind
a bus, (typically for frame buffers) and we may be better off not
assuming any particular MMIO barrier semantics for it at all, but possibly
audit the few uses that are not frame buffers.

> +     Since many CPU architectures ultimately access these peripherals via an
> +     internal virtual memory mapping, the portable ordering guarantees provided
> +     by inX() and outX() are the same as those provided by readX() and writeX()
> +     respectively when accessing a mapping with the default I/O attributes.

This is notably weaker than the PCI mandated non-posted write semantics.
As I said earlier, not all architectures or PCI host implementations can provide
non-posted writes though, but maybe we can document that fact here, e.g.

| Device drivers may expect outX() to be a non-posted write, i.e. waiting for
| a completion response from the I/O device, which may not be possible
| on a particular hardware.

>   (*) ioreadX(), iowriteX()
>
>       These will perform appropriately for the type of access they're actually
>       doing, be it inX()/outX() or readX()/writeX().

This probably needs clarification as well then: On architectures that
have a stronger barrier after outX() than writeX() but that use memory
mapped access for both, the statement is currently not true. We could
either strengthen the requirement by requiring CONFIG_GENERIC_IOMAP
on such architectures, or we could document the current behavior
as intentional and explicitly not allow iowriteX() on I/O ports to be posted.

> +All of these accessors assume that the underlying peripheral is little-endian,
> +and will therefore perform byte-swapping operations on big-endian architectures.

This sounds like a useful addition and the only sane way to do it IMHO, but
I think at least traditionally we've had architectures that do not work like
this but that make readX()/writeX() do native big-endian loads and stores, with
a hardware byteswap on the PCI bus.

      Arnd
