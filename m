Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:38140 "EHLO the-village.bc.nu"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750762AbXHaWHp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 31 Aug 2007 18:07:45 -0400
Date: Fri, 31 Aug 2007 23:16:13 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Heads Up: Next Batch Of Serial/TTY Changes
Message-ID: <20070831231613.6b0fcdfd@the-village.bc.nu>
In-Reply-To: <20070831.144115.48807246.davem@davemloft.net>
References: <20070831221105.2fce9023@the-village.bc.nu>
	<20070831.144115.48807246.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-serial@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, 31 Aug 2007 14:41:15 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Date: Fri, 31 Aug 2007 22:11:05 +0100
> 
> > Firstly some architecture maintainers still haven't updated their
> > platform for arbitary tty speeds. The kernel is going to start whining
> > and issuing warnings on your platform if you don't keep up with the
> > programme (its been 6 months).
> 
> I took a look at this for sparc and I'm currently balking the same way
> you did :-) The current bit usage on sparc just don't work properly
> for what you're trying to do.

I don't see a real problem. You aren't using

	c_cflags & CBAUD = 0x00001000

so that could become BOTHER.

the input bits also appear to be reserved and free ?

