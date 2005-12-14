Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 13 Dec 2005 18:23:40 -0800 (PST)
Message-Id: <20051213.182340.102535288.davem@davemloft.net>
Subject: Re: [PATCH 3/3] sanitize building of fs/compat_ioctl.c
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <p73r78g8nft.fsf@verdi.suse.de>
References: <20051213173434.GP9286@parisc-linux.org>
	<20051213.145109.20744871.davem@davemloft.net>
	<p73r78g8nft.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: ak@suse.de
Cc: hch@lst.de, akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: Andi Kleen <ak@suse.de>
Date: 14 Dec 2005 02:41:42 +0100

> "David S. Miller" <davem@davemloft.net> writes:
> 
> > What do you really still need it for at this point?
> 
> input needs it :/ Take a look at drivers/input/evdev.c:evdev_write_compat
 ...
> I have given in for now. Assuming the test is done on a flag that is only set
> by the system call entry path. But I still think it will result in
> a lot of ugly code. For for read/write it's hard to avoid because
> there are so many variants and we have too many message passing
> protocols now.

I suppose.  We could also funnel down ->compat_{read,write}() and
so on down the call chain, but that would likely be even uglier.

I guess with is_compat_task() we can do the netlink and pfkeyv2 compat
stuff on ia64/x86_64.  I don't look forward to reviewing a patch
implementing that, however :-/
