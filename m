From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [rfc] data race in page table setup/walking?
Date: Wed, 30 Apr 2008 10:09:45 +1000
Message-ID: <1209514185.18023.202.camel@pasglop>
References: <20080429050054.GC21795@wotan.suse.de>
	 <Pine.LNX.4.64.0804291333540.22025@blonde.site>
	 <1209505059.18023.193.camel@pasglop>
	 <Pine.LNX.4.64.0804292328110.23470@blonde.site>
Reply-To: benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0804292328110.23470-popGQ1T0qN76K7/ahGyk6A@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Hugh Dickins <hugh-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>
Cc: Nick Piggin <npiggin-l3A5Bk7waGM@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Memory Management List <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>


On Tue, 2008-04-29 at 23:47 +0100, Hugh Dickins wrote:

> I am surprised it's enough to patch up the issue.

Well, we get lucky here because there's a data dependency between all
the loads... the last one needs the result from the previous one etc...

Only alpha is crazy enough to require barriers in that case as far as I
know :-)

Cheers,
Ben.
