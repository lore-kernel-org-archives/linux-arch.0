From: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Subject: Re: [patch 1/2]: x86: implement pte_special
Date: Thu, 27 Mar 2008 21:16:32 -0700 (PDT)
Message-ID: <20080327.211632.02770342.davem@davemloft.net>
References: <20080328040442.GE8083@wotan.suse.de>
	<20080327.210910.101408473.davem@davemloft.net>
	<20080328041519.GF8083@wotan.suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080328041519.GF8083-B4tOwbsTzaBolqkO4TVVkw@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: npiggin-l3A5Bk7waGM@public.gmane.org
Cc: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, shaggy-V7BBcbaFuwjMbYB6QlFGEg@public.gmane.org, axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org

From: Nick Piggin <npiggin-l3A5Bk7waGM@public.gmane.org>
Date: Fri, 28 Mar 2008 05:15:20 +0100

> The other thing is that the "how do I know if I can refcount the page
> behind this (mm,vaddr,pte) tuple" can be quite arch specific as well.
> And it is also non-trivial to do because that information can be dynamic
> depending on what driver mapped in that given tuple.

Those are good points.
