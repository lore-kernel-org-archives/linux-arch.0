Return-Path: <linux-arch-owner@vger.kernel.org>
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050322091331.7b2967a1.davem@davemloft.net> 
References: <20050322091331.7b2967a1.davem@davemloft.net>  <20050322163428.GD21986@parcelfarce.linux.theplanet.co.uk> <20050321150619.2ea75257.davem@davemloft.net> <20050321225904.GF23908@krispykreme> <20072.1111488229@redhat.com> <20050322131316.GC21986@parcelfarce.linux.theplanet.co.uk> <20050322160324.GA4980@krispykreme> <11333.1111510094@redhat.com> 
Subject: Re: [PATCH] ?mb() -> smp_?mb() conversion 
Date: Tue, 22 Mar 2005 18:00:15 +0000
Message-ID: <12463.1111514415@redhat.com>
Sender: dhowells@redhat.com
To: "David S. Miller" <davem@davemloft.net>
Cc: matthew@wil.cx, anton@samba.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

David S. Miller <davem@davemloft.net> wrote:

> > I don't think these actually exist at the moment. My suggestion was that we
> > rename {r,w,}mb() to io_{r,w,}mb().
> 
> This is the first time I've seen that ?mb() should order I/O
> accesses.  My sparc64 versions certainly don't handle that
> correctly.  :-)  That being said, I think we're all being
> educated to so me extent in this thread.

The FRV CPUs have a MEMBAR instruction; it takes no parameters and acts as a
mb().

You need this when accessing memory-mapped I/O (which is all I/O). Otherwise
reads and writes to peripherals may cross under some circumstances.

We've implemented the logic of when to insert MEMBAR into the FRV compiler,
using __builtin_read8/16/32() and __builtin_write8/16/32().

David
