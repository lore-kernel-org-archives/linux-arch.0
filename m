Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42884 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750951AbdLHUcw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 8 Dec 2017 15:32:52 -0500
Date: Fri, 8 Dec 2017 21:31:31 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Subject: Re: [PATCH 0/2] mm: introduce MAP_FIXED_SAFE
Message-ID: <20171208203131.GA16196@rei>
References: <20171130065835.dbw4ajh5q5whikhf@dhcp22.suse.cz>
 <20171201152640.GA3765@rei>
 <87wp20e9wf.fsf@concordia.ellerman.id.au>
 <20171206045433.GQ26021@bombadil.infradead.org>
 <20171206070355.GA32044@bombadil.infradead.org>
 <87bmjbks4c.fsf@concordia.ellerman.id.au>
 <CAGXu5jLWRQn6EaXEEvdvXr+4gbiJawwp1EaLMfYisHVfMiqgSA@mail.gmail.com>
 <20171207195727.GA26792@bombadil.infradead.org>
 <87shclh3zc.fsf@concordia.ellerman.id.au>
 <20171208142714.GB7793@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171208142714.GB7793@amd>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Matthew Wilcox <willy@infradead.org>, Kees Cook <keescook@chromium.org>, Michal Hocko <mhocko@kernel.org>, Linux API <linux-api@vger.kernel.org>, Khalid Aziz <khalid.aziz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, Andrea Arcangeli <aarcange@redhat.com>, Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Florian Weimer <fweimer@redhat.com>, John Hubbard <jhubbard@nvidia.com>, Abdul Haleem <abdhalee@linux.vnet.ibm.com>, Joel Stanley <joel@jms.id.au>
Message-ID: <20171208203131.rz3Y0yI5FwCol5cjX11Jsr5qxDOU9ZhCXYY7D_S383w@z>

Hi!
> > If we had a time machine, the right set of flags would be:
> > 
> >   - MAP_FIXED:   don't treat addr as a hint, fail if addr is not free
> >   - MAP_REPLACE: replace an existing mapping (or force or clobber)
> 
> Actually, if we had a time machine... would we even provide
> MAP_REPLACE functionality?

I did a bit of archeology just beacause we can and since there is a git
repository of the unix history [1].

The first version of mmap() seems to appear in BSD-4_2-Snapshot there was no
MAP_FIXED flag and the addr is expected to be used for the mapping. At least
that is what manual seems to say, the kernel code is not written at this point.
This seems to correspond to a time when Berkley students were busy rewriting
UNIX kernel to take advantage of the VAX's virtual memory.

The MAP_FIXED arrived to the manual shortly after, probably someone figured out
that passing an address to the call does not make much sense in most of the
cases.

The first actual implementation that supports MAP_FIXED appeared in the
BSD-4_3_Reno-Snapshot and already includes the replace behavior. The original
purpose seems to be replacing mappings in the implementation of the execve()
call.

So the answer would probably be yes but it would probably made sense to keep it
as kernel internal flag.

And BTW it looks like HPUX got it right before it was changed to follow POSIX.
There seems to be HPUX compatibility code in the early BSD codebase that
contains both HPUXMAP_FIXED and HPUXMAP_REPLACE.

[1] https://github.com/dspinellis/unix-history-repo

-- 
Cyril Hrubis
chrubis@suse.cz
