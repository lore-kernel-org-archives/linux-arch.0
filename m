Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268414AbUHLAwY@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:1766 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268386AbUHLAIw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Aug 2004 20:08:52 -0400
Subject: Re: clear_user_highpage()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20040811165547.4cbc98a4.davem@redhat.com>
References: <20040811161537.5e24c2b6.davem@redhat.com>
	 <1092267062.2166.19.camel@gaston>
	 <20040811165547.4cbc98a4.davem@redhat.com>
Content-Type: text/plain
Message-Id: <1092269017.2136.32.camel@gaston>
Mime-Version: 1.0
Date: Thu, 12 Aug 2004 10:03:37 +1000
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>


> I think dynamic-resolution timers are the way to go here.
> Rusty was talking about something along theses lines at
> the networking summit.

Yup, several people talked about it at KS/OLS and I think  s390 has
some implementation already, though I hadn't time to look at it yet,
hopefully that will happen sooner or later.

> The reason Rusty had brought it up was due to a ipv6 problem,
> there are some timers that need to get so far into the future
> that with HZ=1000 it isn't representable in the 32-bit timer
> offsets.  We have jiffies64 and could move the timer struct
> over the a u64 for the offsets, but that seems like overkill.
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>
