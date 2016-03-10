From: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 01/18] mm: Make mmap_sem for write waits killable for mm
 syscalls
Date: Thu, 10 Mar 2016 16:47:16 +0100
Message-ID: <56E19704.6030708@suse.cz>
References: <1456752417-9626-1-git-send-email-mhocko@kernel.org>
 <1456752417-9626-2-git-send-email-mhocko@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54002 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750907AbcCJPrW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 10 Mar 2016 10:47:22 -0500
In-Reply-To: <1456752417-9626-2-git-send-email-mhocko@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Alex Deucher <alexander.deucher@amd.com>, Alex Thorlton <athorlton@sgi.com>, Andrea Arcangeli <aarcange@redhat.com>, Andy Lutomirski <luto@amacapital.net>, Benjamin LaHaise <bcrl@kvack.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Daniel Vetter <daniel.vetter@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Airlie <airlied@linux.ie>, Davidlohr Bueso <dave@stgolabs.net>, David Rientjes <rientjes@google.com>, "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Konstantin Khlebnikov <koct9i@gmail.com>, linux-arch@vger.kernel.org, Mel Gorman <mgorman@suse.de>, Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>Pe

On 02/29/2016 02:26 PM, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
>
> This is the first step in making mmap_sem write holders killable. It

s/holders/waiters/?

> focuses on the trivial ones which are taking the lock early after
> entering the syscall and they are not changing state before.
>
> Therefore it is very easy to change them to use down_write_killable
> and immediately return with -EINTR. This will allow the waiter to
> pass away without blocking the mmap_sem which might be required to
> make a forward progress. E.g. the oom reaper will need the lock for
> reading to dismantle the OOM victim address space.
>
> The only tricky function in this patch is vm_mmap_pgoff which has many
> call sites via vm_mmap. To reduce the risk keep vm_mmap with the
> original non-killable semantic for now.
>
> vm_munmap callers do not bother checking the return value so open code
> it into the munmap syscall path for now for simplicity.
>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Konstantin Khlebnikov <koct9i@gmail.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
