Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:65190 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1751416AbWCGTGI
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 7 Mar 2006 14:06:08 -0500
Date: Tue, 7 Mar 2006 12:06:02 -0700
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] Document Linux's memory barriers
Message-ID: <20060307190602.GE7301@parisc-linux.org>
References: <31492.1141753245@warthog.cambridge.redhat.com> <1141756825.31814.75.camel@localhost.localdomain> <Pine.LNX.4.61.0603071346540.9814@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0603071346540.9814@chaos.analogic.com>
Sender: linux-arch-owner@vger.kernel.org
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org, Linux kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Tue, Mar 07, 2006 at 01:54:33PM -0500, linux-os (Dick Johnson) wrote:
> This might be a good place to document:
>     dummy = readl(&foodev->ctrl);
> 
> Will flush all pending writes to the PCI bus and that:
>     (void) readl(&foodev->ctrl);
> ... won't because `gcc` may optimize it away. In fact, variable
> "dummy" should be global or `gcc` may make it go away as well.

static inline unsigned int readl(const volatile void __iomem *addr)
{
	return *(volatile unsigned int __force *) addr;
}

The cast is volatile, so gcc knows not to optimise it away.
