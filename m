From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 11/18] coredump: make coredump_wait wait for mma_sem for
 write killable
Date: Fri, 11 Mar 2016 13:46:13 +0100
Message-ID: <20160311124613.GL27701@dhcp22.suse.cz>
References: <1456752417-9626-1-git-send-email-mhocko@kernel.org>
 <1456752417-9626-12-git-send-email-mhocko@kernel.org>
 <56E2ACE7.50008@suse.cz>
 <56E2B1E9.90201@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36067 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744AbcCKMqQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 11 Mar 2016 07:46:16 -0500
Content-Disposition: inline
In-Reply-To: <56E2B1E9.90201@suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Alex Deucher <alexander.deucher@amd.com>, Alex Thorlton <athorlton@sgi.com>, Andrea Arcangeli <aarcange@redhat.com>, Andy Lutomirski <luto@amacapital.net>, Benjamin LaHaise <bcrl@kvack.org>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Daniel Vetter <daniel.vetter@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Airlie <airlied@linux.ie>, Davidlohr Bueso <dave@stgolabs.net>, David Rientjes <rientjes@google.com>, "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Konstantin Khlebnikov <koct9i@gmail.com>, linux-arch@vger.kernel.org, Mel Gorman <mgorman@suse.de>, Oleg Nesterov <oleg@redhat.com>Pe

On Fri 11-03-16 12:54:17, Vlastimil Babka wrote:
> On 03/11/2016 12:32 PM, Vlastimil Babka wrote:
> >On 02/29/2016 02:26 PM, Michal Hocko wrote:
> >>From: Michal Hocko <mhocko@suse.com>
> >>
> >>coredump_wait waits for mmap_sem for write currently which can
> >>prevent oom_reaper to reclaim the oom victims address space
> >>asynchronously because that requires mmap_sem for read. This might
> >>happen if the oom victim is multi threaded and some thread(s) is
> >>holding mmap_sem for read (e.g. page fault) and it is stuck in
> >>the page allocator while other thread(s) reached coredump_wait
> >>already.
> >>
> >>This patch simply uses down_write_killable and bails out with EINTR
> >>if the lock got interrupted by the fatal signal. do_coredump will
> >>return right away and do_group_exit will take care to zap the whole
> >>thread group.
> >>
> >>Cc: Oleg Nesterov <oleg@redhat.com>
> >>Signed-off-by: Michal Hocko <mhocko@suse.com>
> >
> >Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Forgot to point out typo in Subject which makes it hard to grep for mmap_sem

Fixed and thanks!

-- 
Michal Hocko
SUSE Labs
