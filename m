From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 02/18] mm: make vm_mmap killable
Date: Fri, 11 Mar 2016 13:55:33 +0100
Message-ID: <20160311125533.GN27701@dhcp22.suse.cz>
References: <1456752417-9626-1-git-send-email-mhocko@kernel.org>
 <1456752417-9626-3-git-send-email-mhocko@kernel.org>
 <56E29702.5030100@suse.cz>
 <20160311121235.GI27701@dhcp22.suse.cz>
 <56E2BD7D.10701@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33535 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752557AbcCKMzg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 11 Mar 2016 07:55:36 -0500
Content-Disposition: inline
In-Reply-To: <56E2BD7D.10701@suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Alex Deucher <alexander.deucher@amd.com>, Alex Thorlton <athorlton@sgi.com>, Andrea Arcangeli <aarcange@redhat.com>, Andy Lutomirski <luto@amacapital.net>, Benjamin LaHaise <bcrl@kvack.org>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Daniel Vetter <daniel.vetter@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Airlie <airlied@linux.ie>, Davidlohr Bueso <dave@stgolabs.net>, David Rientjes <rientjes@google.com>, "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Konstantin Khlebnikov <koct9i@gmail.com>, linux-arch@vger.kernel.org, Mel Gorman <mgorman@suse.de>, Oleg Nesterov <oleg@redhat.com>Pe

On Fri 11-03-16 13:43:41, Vlastimil Babka wrote:
> On 03/11/2016 01:12 PM, Michal Hocko wrote:
> >On Fri 11-03-16 10:59:30, Vlastimil Babka wrote:
> >>On 02/29/2016 02:26 PM, Michal Hocko wrote:
> >>>From: Michal Hocko <mhocko@suse.com>
> >>>
> >>>All the callers of vm_mmap seem to check for the failure already
> >>>and bail out in one way or another on the error which means that
> >>
> >>Hmm I'm not that sure about this one:
> >>  17   1071  fs/binfmt_elf.c <<load_elf_binary>>
> >>
> >>Assigns result of vm_mmap() to "error" variable which is never checked.
> >
> >Yes it is not checked but not used either. If the current got killed
> >then it wouldn't return to the userspace so my understanding is that not
> >checking this value is not a problem. At least that is my understanding.
> 
> Hmm, that's true. So,

I have updated the changelog and added the following note:
"
Please note that load_elf_binary is ignoring vm_mmap error for 
current->personality & MMAP_PAGE_ZERO case but that shouldn't be a
problem because the address is not used anywhere and we never return to
the userspace if we got killed.
"
 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!

-- 
Michal Hocko
SUSE Labs
