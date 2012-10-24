From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH] tile: support GENERIC_KERNEL_THREAD and
 GENERIC_KERNEL_EXECVE
Date: Wed, 24 Oct 2012 02:56:13 +0100
Message-ID: <20121024015613.GB2616@ZenIV.linux.org.uk>
References: <20121019213548.GR2616@ZenIV.linux.org.uk>
 <5082A1F1.3080303@tilera.com>
 <20121020153401.GT2616@ZenIV.linux.org.uk>
 <20121020171643.GU2616@ZenIV.linux.org.uk>
 <5086D432.4070008@tilera.com>
 <20121023184122.GZ2616@ZenIV.linux.org.uk>
 <alpine.LFD.2.02.1210232232070.2756@ionos>
 <20121023205119.GA27729@sigill.intra.peff.net>
 <alpine.LFD.2.02.1210232307480.2756@ionos>
 <CA+55aFyYD2jvD3+TSe=GhBgg5UQt2RNFdYf6HGiKRX-xWzFmdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:33728 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755785Ab2JXB4X (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 23 Oct 2012 21:56:23 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFyYD2jvD3+TSe=GhBgg5UQt2RNFdYf6HGiKRX-xWzFmdw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jeff King <peff@peff.net>, Chris Metcalf <cmetcalf@tilera.com>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>

On Wed, Oct 24, 2012 at 04:02:49AM +0300, Linus Torvalds wrote:
> On Wed, Oct 24, 2012 at 12:25 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> >>
> >> It is spelled:
> >>
> >>   git notes add -m <comment> SHA1
> >
> > Cool!
> 
> Don't use them for anything global.
> 
> Use them for local codeflow, but don't expect them to be distributed.
> It's a separate "flow", and while it *can* be distributed, it's not
> going to be for the kernel, for example. So no, don't start using this
> to ack things, because the acks *will* get lost.

How about git commit --allow-empty, with
"belated ACK for <commit>

Acked-by: <...>
" as commit message?  I mean, that ought to work and propagate sanely,
but I'm really not sure if that's something in a good taste and should
be allowed as a common practice...
