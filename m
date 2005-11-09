Return-Path: <linux-arch-owner@vger.kernel.org>
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20051109152727.GG4712@flint.arm.linux.org.uk> 
References: <20051109152727.GG4712@flint.arm.linux.org.uk>  <20051109132449.GC4712@flint.arm.linux.org.uk> <20051108191057.09f57114.akpm@osdl.org> <26691.1131542400@warthog.cambridge.redhat.com> <7224.1131549227@warthog.cambridge.redhat.com> 
Subject: Re: irq-type-flags.patch 
Date: Wed, 09 Nov 2005 16:07:13 +0000
Message-ID: <9150.1131552433@warthog.cambridge.redhat.com>
Sender: dhowells@redhat.com
To: Russell King <rmk@arm.linux.org.uk>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Russell King <rmk@arm.linux.org.uk> wrote:

> I think the root of this issue is that you're thinking that the driver
> uses this to dictate to the interrupt controller what it wants the
> controller to program itself for.  It's more a case that the driver is
> saying "my device produces this kind of interrupt, please configure
> the input appropriately."

Okay.

Still, I'd like to see some handling for a mismatch - the case in which the
driver says "my device can produce X" but X isn't available with that PIC/bus
combination. Or maybe provide a way (if there isn't one already) for the
driver to query the available trigger types. Some devices I've come across
have configurable interrupt generators.

David
