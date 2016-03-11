From: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 10/18] vdso: make arch_setup_additional_pages wait for
 mmap_sem for write killable
Date: Fri, 11 Mar 2016 12:28:14 +0100
Message-ID: <56E2ABCE.5070205@suse.cz>
References: <1456752417-9626-1-git-send-email-mhocko@kernel.org>
 <1456752417-9626-11-git-send-email-mhocko@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58143 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751534AbcCKL2T (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 11 Mar 2016 06:28:19 -0500
In-Reply-To: <1456752417-9626-11-git-send-email-mhocko@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Alex Deucher <alexander.deucher@amd.com>, Alex Thorlton <athorlton@sgi.com>, Andrea Arcangeli <aarcange@redhat.com>, Andy Lutomirski <luto@amacapital.net>, Benjamin LaHaise <bcrl@kvack.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Daniel Vetter <daniel.vetter@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Airlie <airlied@linux.ie>, Davidlohr Bueso <dave@stgolabs.net>, David Rientjes <rientjes@google.com>, "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Konstantin Khlebnikov <koct9i@gmail.com>, linux-arch@vger.kernel.org, Mel Gorman <mgorman@suse.de>, Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>Pe

On 02/29/2016 02:26 PM, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
>
> most architectures are relying on mmap_sem for write in their
> arch_setup_additional_pages. If the waiting task gets killed by the oom
> killer it would block oom_reaper from asynchronous address space reclaim
> and reduce the chances of timely OOM resolving. Wait for the lock in
> the killable mode and return with EINTR if the task got killed while
> waiting.
>
> Cc: linux-arch@vger.kernel.org
> Cc: Andy Lutomirski <luto@amacapital.net>
> Signed-off-by: Michal Hocko <mhocko@suse.com>


I don't have much arch-specific insight, but looks OK.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
