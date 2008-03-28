From: Nick Piggin <npiggin-l3A5Bk7waGM@public.gmane.org>
Subject: [patch 0/2]: lockless get_user_pages patchset
Date: Fri, 28 Mar 2008 03:54:55 +0100
Message-ID: <20080328025455.GA8083@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: shaggy-V7BBcbaFuwjMbYB6QlFGEg@public.gmane.org, axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org

Hi,

This patchset It impoves our well known oltp performance thingy by 10% on DB2
on a modest 2 socket x86 system. For a sense of scale, remember numbers being
tossed around like direct-IO giving a 12% improvement; or hugepages giving a 9%
improvement... heh.

I have a powerpc patch as well, but it needs benh to find me a bit in their pte
to use.

These patches are on top of the previous 7 patches just sent.

Nick
