Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268353AbUHKX54@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:58057 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268420AbUHKX4k (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Aug 2004 19:56:40 -0400
Date: Wed, 11 Aug 2004 16:55:47 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: clear_user_highpage()
Message-Id: <20040811165547.4cbc98a4.davem@redhat.com>
In-Reply-To: <1092267062.2166.19.camel@gaston>
References: <20040811161537.5e24c2b6.davem@redhat.com>
	<1092267062.2166.19.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: torvalds@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, 12 Aug 2004 09:31:03 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> It would be nice, indeed, tho we have to be careful not to waste
> too much time in there looking for pages to clear, especially when
> there is none. Time spent not putting the CPU into power managed
> idle, at least on PPC's, means the CPU getting hotter, consuming
> more battery, etc... which is definitely a bad thing on laptops.

I totally agree.  This is why I believe it should be a per-arch
decision at cpu_idle() time whether to do the clears or not.

> I already took a significant hit with HZ=1000 btw, I'm considering
> lowering it back to 100 on ppc32 at least... We really want tickless
> scheduling for these beasts so we can select how deep to PM the CPU
> based on how much time we expect to stay idle.

I think dynamic-resolution timers are the way to go here.
Rusty was talking about something along theses lines at
the networking summit.

The reason Rusty had brought it up was due to a ipv6 problem,
there are some timers that need to get so far into the future
that with HZ=1000 it isn't representable in the 32-bit timer
offsets.  We have jiffies64 and could move the timer struct
over the a u64 for the offsets, but that seems like overkill.
