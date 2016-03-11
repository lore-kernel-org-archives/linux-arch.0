From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 03/18] mm: make vm_munmap killable
Date: Fri, 11 Mar 2016 13:32:09 +0100
Message-ID: <20160311123209.GJ27701@dhcp22.suse.cz>
References: <1456752417-9626-1-git-send-email-mhocko@kernel.org>
 <1456752417-9626-4-git-send-email-mhocko@kernel.org>
 <56E298B1.6010802@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33326 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752308AbcCKMcM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 11 Mar 2016 07:32:12 -0500
Content-Disposition: inline
In-Reply-To: <56E298B1.6010802@suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Alex Deucher <alexander.deucher@amd.com>, Alex Thorlton <athorlton@sgi.com>, Andrea Arcangeli <aarcange@redhat.com>, Andy Lutomirski <luto@amacapital.net>, Benjamin LaHaise <bcrl@kvack.org>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Daniel Vetter <daniel.vetter@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Airlie <airlied@linux.ie>, Davidlohr Bueso <dave@stgolabs.net>, David Rientjes <rientjes@google.com>, "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Konstantin Khlebnikov <koct9i@gmail.com>, linux-arch@vger.kernel.org, Mel Gorman <mgorman@suse.de>, Oleg Nesterov <oleg@redhat.com>Pe

On Fri 11-03-16 11:06:41, Vlastimil Babka wrote:
> On 02/29/2016 02:26 PM, Michal Hocko wrote:
> >From: Michal Hocko <mhocko@suse.com>
> >
> >Almost all current users of vm_munmap are ignoring the return value
> >and so they do not handle potential error. This means that some VMAs
> 
>    1   7834  arch/x86/kvm/x86.c <<__x86_set_memory_region>>
> 
>              r = vm_munmap(old.userspace_addr, old.npages * PAGE_SIZE);
>              WARN_ON(r < 0);
> 
> This warning will potentially add noise to OOM output?

Would it be harmfull though? I mean the warning is just goofy. I can
make it not warn on (r < 0 && r != -EINTR) but is it worth bothering?

Thanks!
-- 
Michal Hocko
SUSE Labs
