Return-Path: <linux-arch-owner@vger.kernel.org>
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050321150619.2ea75257.davem@davemloft.net> 
References: <20050321150619.2ea75257.davem@davemloft.net>  <20050321225904.GF23908@krispykreme> 
Subject: Re: [PATCH] ?mb() -> smp_?mb() conversion 
Date: Tue, 22 Mar 2005 10:43:49 +0000
Message-ID: <20072.1111488229@redhat.com>
Sender: dhowells@redhat.com
To: "David S. Miller" <davem@davemloft.net>
Cc: Anton Blanchard <anton@samba.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

David S. Miller <davem@davemloft.net> wrote:

> If I remember correctly, the ?mb() routines _were_ the original
> SMP memory barriers.

Would it be worth renaming the mb/rmb/wmb to io_mb/io_rmb/io_wmb? After all, I
believe they should only be used to flush I/O memory accesses. This would, I
think, make the distinction between memory barriers for I/O and memory
barriers for SMP more obvious.

David
