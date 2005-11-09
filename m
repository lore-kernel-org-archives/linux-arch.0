Return-Path: <linux-arch-owner@vger.kernel.org>
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20051108191057.09f57114.akpm@osdl.org> 
References: <20051108191057.09f57114.akpm@osdl.org> 
Subject: Re: irq-type-flags.patch 
Date: Wed, 09 Nov 2005 13:20:00 +0000
Message-ID: <26691.1131542400@warthog.cambridge.redhat.com>
Sender: dhowells@redhat.com
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Andrew Morton <akpm@osdl.org> wrote:

> +			desc->chip->set_type(irq, type);

How's the error handled if the PIC can't handle the requested type?

It seems like it ought to be wrong that the driver is setting this. It ought
to be a property of the arch or the bus.

David
