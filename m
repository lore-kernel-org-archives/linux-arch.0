From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [RFC][PATCHSET] mremap/mmap mess
Date: Wed, 9 Dec 2009 13:46:20 +0000
Message-ID: <20091209134620.GR14381@ZenIV.linux.org.uk>
References: <20091208060701.GM14381@ZenIV.linux.org.uk> <Pine.LNX.4.64.0912081142280.31223@sister.anvils> <Pine.LNX.4.64.0912081254500.3365@sister.anvils> <20091208.130802.25121122.davem@davemloft.net> <20091208220638.GN14381@ZenIV.linux.org.uk> <Pine.LNX.4.64.0912091041250.23659@sister.anvils>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:58770 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755911AbZLINqe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 9 Dec 2009 08:46:34 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0912091041250.23659@sister.anvils>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hugh Dickins <hugh.dickins@tiscali.co.uk>
Cc: David Miller <davem@davemloft.net>, Ollie Wild <aaw@google.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Rik van Riel <riel@redhat.com>, viro@ftp.linux.org.uk, linux-arch@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org

On Wed, Dec 09, 2009 at 11:43:57AM +0000, Hugh Dickins wrote:
> ... my hair ;-)
> I have to say, Dr Frankenstein, that this idea fills me with dread.
> 
> I'm not saying it's impossible, but the resulting creature sounds like
> it's going to be special in several easily-buggy hard-to-maintain ways.
> 
> I think you already realize that shmem file pages (shared) live by
> different rules from anonymous pages (COWed): they're both swappable,
> but switching a group of pages from one to the other is going to be
> weird new territory.  (In fairness, my suggestion involves some
> weird new territory too, but considerably less scary to me.)

Umm...  Note that these guys are considerably simpler than shmem; _nothing_
will have them mapped anywhere until after that eviction and nothing will
modify their address_space in any way (no truncation, etc.).

And no, I'm not particulary happy about the picture - the sight of, ahem,
locking hierarcy rules in mm/filemap.c alone is a cause for dread.  It had
been a while since I'd done any serious RTFS on mm/*, so...

Anyway, it's obviously *not* -rc1 fodder at the moment.  So what I'm going
to do is to leave that one as it is in mainline, push the rest of mmap/mremap
stuff to Linus later today and get to VFS and audit queues.  After the -rc1,
OTOH...
