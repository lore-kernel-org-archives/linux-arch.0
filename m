From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 0/18] change mmap_sem taken for write killable
Date: Mon, 29 Feb 2016 15:16:22 +0100
Message-ID: <20160229141622.GC16930@dhcp22.suse.cz>
References: <1456752417-9626-1-git-send-email-mhocko@kernel.org>
 <20160229140416.GA12506@node.shutemov.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35539 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbcB2OQZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 29 Feb 2016 09:16:25 -0500
Content-Disposition: inline
In-Reply-To: <20160229140416.GA12506@node.shutemov.name>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Alex Deucher <alexander.deucher@amd.com>, Alex Thorlton <athorlton@sgi.com>, Andrea Arcangeli <aarcange@redhat.com>, Andy Lutomirski <luto@amacapital.net>, Benjamin LaHaise <bcrl@kvack.org>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Daniel Vetter <daniel.vetter@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Airlie <airlied@linux.ie>, Davidlohr Bueso <dave@stgolabs.net>, David Rientjes <rientjes@google.com>, "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Konstantin Khlebnikov <koct9i@gmail.com>, linux-arch@vger.kernel.org, Mel Gorman <mgorman@suse.de>, Oleg Nesterov <oleg@redhat.com>Pe

On Mon 29-02-16 17:04:16, Kirill A. Shutemov wrote:
[...]
> > Most of the patches are really trivial because the lock is help from a
> > shallow syscall paths where we can return EINTR trivially. Others seem
> > to be easy as well as the callers are already handling fatal errors and
> > bail and return to userspace which should be sufficient to handle the
> > failure gracefully. I am not familiar with all those code paths so a
> > deeper review is really appreciated.
> 
> What about effect on userspace? IIUC, we would have now EINTR returned
> from bunch of syscall, which haven't had this errno on the table before.
> Should we care?

Those function will return EINTR only when the current was _killed_ when
we do not return to the userspace. So there shouldn't be any visible
effect.
-- 
Michal Hocko
SUSE Labs
