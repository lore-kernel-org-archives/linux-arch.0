Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268394AbUHKXiO@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:50149 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268385AbUHKXgE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Aug 2004 19:36:04 -0400
Subject: Re: clear_user_highpage()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20040811161537.5e24c2b6.davem@redhat.com>
References: <20040811161537.5e24c2b6.davem@redhat.com>
Content-Type: text/plain
Message-Id: <1092267062.2166.19.camel@gaston>
Mime-Version: 1.0
Date: Thu, 12 Aug 2004 09:31:03 +1000
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>


> There is a lot of code path in there for alloc_pages_vma().
> I don't think adding arch overridable stuff is the way
> to go here.  Something generic in the per-cpu hot/cold
> page list handling that the cpu_idle() loop of each architecture
> could call.

It would be nice, indeed, tho we have to be careful not to waste
too much time in there looking for pages to clear, especially when
there is none. Time spent not putting the CPU into power managed
idle, at least on PPC's, means the CPU getting hotter, consuming
more battery, etc... which is definitely a bad thing on laptops.

I already took a significant hit with HZ=1000 btw, I'm considering
lowering it back to 100 on ppc32 at least... We really want tickless
scheduling for these beasts so we can select how deep to PM the CPU
based on how much time we expect to stay idle.

Ben.
