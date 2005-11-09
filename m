Return-Path: <linux-arch-owner@vger.kernel.org>
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20051109132449.GC4712@flint.arm.linux.org.uk> 
References: <20051109132449.GC4712@flint.arm.linux.org.uk>  <20051108191057.09f57114.akpm@osdl.org> <26691.1131542400@warthog.cambridge.redhat.com> 
Subject: Re: irq-type-flags.patch 
Date: Wed, 09 Nov 2005 15:13:47 +0000
Message-ID: <7224.1131549227@warthog.cambridge.redhat.com>
Sender: dhowells@redhat.com
To: Russell King <rmk@arm.linux.org.uk>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Russell King <rmk@arm.linux.org.uk> wrote:

> Neither the arch not the bus dictates what the
> device manufacturer decides to do with their interrupt output.

On the other hand, the device manufacturer does not decree what the arch and
supporting chipset will *accept*. There's no guarantee that all trigger types
will be supported. For instance on my ASB2305 board, I've got an on-chip PIC
that will accept any of the four trigger types, but the PCI bus interrupt line
attached to one of the external interrupt pins will *only* accept low-level
triggered. In such a case, the bus *must* override anything set by one of the
devices.

David
