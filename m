Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 13 Dec 2005 10:34:34 -0700
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH 3/3] sanitize building of fs/compat_ioctl.c
Message-ID: <20051213173434.GP9286@parisc-linux.org>
References: <20051213172325.GC16392@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213172325.GC16392@lst.de>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Dec 13, 2005 at 06:23:25PM +0100, Christoph Hellwig wrote:
> [1] parisc still had it's PPP handler left, which is not fully correct
>     for ppp and besides that ppp uses the generic SIOCPRIV ioctl so it'd
>     kick in for all netdevice users.  We can introduce a proper handler
>     in one of the next patch series by adding a compat_ioctl method to
>     struct net_device but for now let's just kill it - parisc doesn't
>     compile in mainline anyway and I don't want this to block this
>     patchset.

parisc probably does compile in mainline these days.  It's certainly
much closer than it ever was before.  The 64-bit code doesn't compile
because Andi keeps blocking the is_compat_task() stuff.  Why not do the
netdevice compat_ioctl patch before killing this?  I'd hate to have to
back out this patch in the PA tree.
