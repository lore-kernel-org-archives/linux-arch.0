Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S262226AbUJZC3O@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:15513 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262066AbUJZC13 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 25 Oct 2004 22:27:29 -0400
Date: Mon, 25 Oct 2004 19:27:25 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] Add NO_IRQ to all architectures
In-Reply-To: <1098756491.17886.18.camel@gaston>
Message-ID: <Pine.LNX.4.58.0410251926340.427@ppc970.osdl.org>
References: <1098756491.17886.18.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>



On Tue, 26 Oct 2004, Benjamin Herrenschmidt wrote:
> 
> Here'd a patch adding a definition of NO_IRQ to all archs include/asm-*/irq.h.

..and is there any reason to make it arch-specific?

iow, I really can't imagine it not being ok to just have a global

	#define NO_IRQ (-1)

in one place, rather than in every arch.

		Linus
