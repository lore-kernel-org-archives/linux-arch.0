Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:59882 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1753969AbWKGDdu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 6 Nov 2006 22:33:50 -0500
Date: Mon, 6 Nov 2006 20:33:49 -0700
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: Which architectures need 64-bit resources?
Message-ID: <20061107033349.GR27140@parisc-linux.org>
References: <20061106122337.GK27140@parisc-linux.org> <20061106160206.GA10447@linux-mips.org> <20061106163243.GN27140@parisc-linux.org> <Pine.LNX.4.62.0611070218590.28657@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0611070218590.28657@pademelon.sonytel.be>
Sender: linux-arch-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-arch@vger.kernel.org, Vivek Goyal <vgoyal@in.ibm.com>
List-ID: <linux-arch.vger.kernel.org>

On Tue, Nov 07, 2006 at 02:37:46AM +0100, Geert Uytterhoeven wrote:
> Ah, good that the `possibility' of 64-bit resources on m68k goes away, and I
> haven't `fixed' all those printf() format warnings yet...
> 
> Speaking about that: how many recently-added silencing casts should be removed
> on platforms without 64-bit resources?

Absolutely none, I'm afraid.

struct resource {
        resource_size_t start;
	resource_size_t end;
...

GCC complains about resource_size_t, no matter what you typedef it to be.
It'd be nice if we could tell GCC that %r meant it'd consume a
resource_size_t, but afaict, there's no ability to define additions to
the format attribute.

Viro's mused on disabling the printk checking entirely with gcc and just
using sparse to verify format strings (so we can add our own types, etc),
but I don't think that's realistic unless a lot more people start
installing sparse.

And widespread adoption of sparse seems unlikely, given that it's under
OSL 1.1 which means it can't go into Debian [1].

GCC's in Stage 1 ... anyone want to write a patch to c-format.c?

[1] http://wiki.debian.org/DFSGLicenses#head-2b7e4b3507dcc5657dabaf145df20d6c7d41f159

