Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268805AbUIHA3B@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:29078 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268802AbUIHA26 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 7 Sep 2004 20:28:58 -0400
Date: Wed, 8 Sep 2004 10:26:03 +1000
From: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] Fix argument checking in sched_setaffinity
Message-ID: <20040908002603.GB25278@krispykreme>
References: <Pine.LNX.4.58.0409041827280.2331@ppc970.osdl.org> <20040904204850.48b7cfbd.pj@sgi.com> <Pine.LNX.4.58.0409042055460.2331@ppc970.osdl.org> <20040904211749.3f713a8a.pj@sgi.com> <20040904215205.0a067ab8.pj@sgi.com> <20040906182330.GA79122@muc.de> <Pine.LNX.4.58.0409061147220.28608@ppc970.osdl.org> <20040906141142.663941fb.pj@sgi.com> <Pine.LNX.4.58.0409070736100.2299@ppc970.osdl.org> <20040907144936.GD20981@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040907144936.GD20981@wotan.suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Paul Jackson <pj@sgi.com>, ak@muc.de, Andrew Morton <akpm@osdl.org>, Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>


Hi,

> For mbind() breaking existing ppc64 users is unlikely I agree.

Yes.

> For setaffinity I am not so sure. The system call is around
> for a long time and has been used in standard utilities
> in distributions also for quite some time.

We have deployed applications using setaffinity, we need a very good
reason to change this.

> So in short I think changing mbind to u32 would be fine,
> but I wouldn't do it for sched_setaffinity() 

Agreed.

Anton
