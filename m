From: Hugh Dickins <hugh.dickins@tiscali.co.uk>
Subject: Re: [RFC][PATCHSET] mremap/mmap mess
Date: Tue, 8 Dec 2009 13:03:30 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0912081254500.3365@sister.anvils>
References: <E1NGzzu-0008RH-T2@ZenIV.linux.org.uk> <20091207035857.GF14381@ZenIV.linux.org.uk>
 <Pine.LNX.4.64.0912071710540.14445@sister.anvils> <20091207193048.GI14381@ZenIV.linux.org.uk>
 <Pine.LNX.4.64.0912071953490.24794@sister.anvils> <20091208060701.GM14381@ZenIV.linux.org.uk>
 <Pine.LNX.4.64.0912081142280.31223@sister.anvils>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mk-filter-2-a-1.mail.uk.tiscali.com ([212.74.100.53]:51861 "EHLO
	mk-filter-2-a-1.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754644AbZLHNDd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 Dec 2009 08:03:33 -0500
In-Reply-To: <Pine.LNX.4.64.0912081142280.31223@sister.anvils>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-arch@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org

On Tue, 8 Dec 2009, Hugh Dickins wrote:
> On Tue, 8 Dec 2009, Al Viro wrote:
> > 
> > Why do we want user_get_pages(), anyway?  It's not that we lacked an
> > easy way to do large arrays, especially since the use is purely sequential.
> > Even a linked list of vmalloc'ed pages would do just fine (i.e. start with
> > static array in bprm, keep the pointer to last filled entry + number of
> > entries left before the next allocation; use the last pointer in array
> > for finding the next page-sized chunk).
> > 
> > What do we lose if we go that way?  Inserting all these pages into mm
> > at once shouldn't be slower.  Memory overhead is not really an issue
> > (one page per 511 or 1023 pages of argv).  Am I missing something?
> 
> I think what you lose that way is swappability.
...
> I have a different reason for wanting to change how it's done:
> it's the major user of non-atomic kmap() and its global kmap_lock,
> and rather swamps other uses of kmap() (which have better use for
> the cached virtual address).  So I'd be happy with a better way
> of doing it, but not at the cost of losing swappability.

Would it make sense to build up argv and env of execee on the execer's
user stack (below user's sp ("below" assuming topdown stack))?

That would impose some (unacceptable?) limits, and require some funny
code to migrate the pages over to the new mm later (instead of
relocating within the new mm as we do now).

But it would avoid get_user_pages and kmap altogether:
just straight copies in current's mm.

Hugh
