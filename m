From: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Subject: Re: [rfc] data race in page table setup/walking?
Date: Tue, 29 Apr 2008 03:56:07 -0700 (PDT)
Message-ID: <20080429.035607.224699531.davem@davemloft.net>
References: <20080429050054.GC21795@wotan.suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080429050054.GC21795-B4tOwbsTzaBolqkO4TVVkw@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: npiggin-l3A5Bk7waGM@public.gmane.org
Cc: torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, hugh-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org

From: Nick Piggin <npiggin-l3A5Bk7waGM@public.gmane.org>
Date: Tue, 29 Apr 2008 07:00:54 +0200

> So anyway... comments, please? Am I dreaming the whole thing up? I suspect
> that if I'm not, then powerpc at least might have been impacted by the race,
> but as far as I know of, they haven't seen stability problems around there...
> Might just be terribly rare, though. I'd like to try to make a test program
> to reproduce the problem if I can get access to a box...

This definitely does look like a real problem, albeit pretty hard to
trigger I would say. :-)

Thanks for looking into this.
