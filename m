Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 22 Mar 2005 13:13:16 +0000
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] ?mb() -> smp_?mb() conversion
Message-ID: <20050322131316.GC21986@parcelfarce.linux.theplanet.co.uk>
References: <20050321150619.2ea75257.davem@davemloft.net> <20050321225904.GF23908@krispykreme> <20072.1111488229@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20072.1111488229@redhat.com>
Sender: <willy@www.linux.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Anton Blanchard <anton@samba.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Mar 22, 2005 at 10:43:49AM +0000, David Howells wrote:
> David S. Miller <davem@davemloft.net> wrote:
> 
> > If I remember correctly, the ?mb() routines _were_ the original
> > SMP memory barriers.
> 
> Would it be worth renaming the mb/rmb/wmb to io_mb/io_rmb/io_wmb? After all, I
> believe they should only be used to flush I/O memory accesses. This would, I
> think, make the distinction between memory barriers for I/O and memory
> barriers for SMP more obvious.

Are you joking or genuinely confused?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
