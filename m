Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268389AbUHLBVI@vger.kernel.org>
Received: from holomorphy.com ([207.189.100.168]:58247 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267968AbUHLBSM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Aug 2004 21:18:12 -0400
Date: Wed, 11 Aug 2004 18:18:02 -0700
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: clear_user_highpage()
Message-ID: <20040812011802.GA11200@holomorphy.com>
References: <20040811161537.5e24c2b6.davem@redhat.com> <1092267062.2166.19.camel@gaston> <20040811165547.4cbc98a4.davem@redhat.com> <1092269017.2136.32.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092269017.2136.32.camel@gaston>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "David S. Miller" <davem@redhat.com>, Linus Torvalds <torvalds@osdl.org>, Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

At some point in the past, someone wrote:
>> I think dynamic-resolution timers are the way to go here.
>> Rusty was talking about something along theses lines at
>> the networking summit.

On Thu, Aug 12, 2004 at 10:03:37AM +1000, Benjamin Herrenschmidt wrote:
> Yup, several people talked about it at KS/OLS and I think  s390 has
> some implementation already, though I hadn't time to look at it yet,
> hopefully that will happen sooner or later.

Zwane has a tickless idling patch for i386 already (not sure if it's
been posted yet). I'm looking at helping out with it at some point, at
least if Zwane stops churning out new functionality long enough for me
to get a line in edgewise. =)


-- wli
