Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 13 Dec 2005 10:30:57 -0700
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH 1/3] move rtc compat ioctl handling to fs/compat_ioctl.c
Message-ID: <20051213173057.GO9286@parisc-linux.org>
References: <20051213172312.GA16392@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213172312.GA16392@lst.de>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Dec 13, 2005 at 06:23:12PM +0100, Christoph Hellwig wrote:
> parisc used COMPAT_IOCTL or generic w_long handlers for these whichce
> is wrong and can't work because the ioctls encode sizeof(unsigned long)
> in their ioctl number.  parisc also duplicated COMPAT_IOCTL entries for
> other rtc ioctls which I remove in this patch, too.

ACK.
