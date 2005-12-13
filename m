Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 13 Dec 2005 14:51:09 -0800 (PST)
Message-Id: <20051213.145109.20744871.davem@davemloft.net>
Subject: Re: [PATCH 3/3] sanitize building of fs/compat_ioctl.c
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051213173434.GP9286@parisc-linux.org>
References: <20051213172325.GC16392@lst.de>
	<20051213173434.GP9286@parisc-linux.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: matthew@wil.cx
Cc: hch@lst.de, akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: Matthew Wilcox <matthew@wil.cx>
Date: Tue, 13 Dec 2005 10:34:34 -0700

> The 64-bit code doesn't compile because Andi keeps blocking the
> is_compat_task() stuff.

The one place where I ever thought that was necessary, the
USB async userspace I/O operation stuff, was solved much more
cleanly with ->compat_ioctl() file_operations handlers.

What do you really still need it for at this point?

I also would like to avoid it if possible.
