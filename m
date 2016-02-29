From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 07/18] mm, proc: make clear_refs killable
Date: Mon, 29 Feb 2016 18:58:17 +0100
Message-ID: <20160229175816.GE3615@redhat.com>
References: <1456752417-9626-1-git-send-email-mhocko@kernel.org>
 <1456752417-9626-8-git-send-email-mhocko@kernel.org>
 <20160229173845.GC3615@redhat.com>
 <20160229175338.GM16930@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39846 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750971AbcB2R6Y (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 29 Feb 2016 12:58:24 -0500
Content-Disposition: inline
In-Reply-To: <20160229175338.GM16930@dhcp22.suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Alex Deucher <alexander.deucher@amd.com>, Alex Thorlton <athorlton@sgi.com>, Andrea Arcangeli <aarcange@redhat.com>, Andy Lutomirski <luto@amacapital.net>, Benjamin LaHaise <bcrl@kvack.org>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Daniel Vetter <daniel.vetter@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Airlie <airlied@linux.ie>, Davidlohr Bueso <dave@stgolabs.net>, David Rientjes <rientjes@google.com>, "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Konstantin Khlebnikov <koct9i@gmail.com>, linux-arch@vger.kernel.org, Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>

On 02/29, Michal Hocko wrote:
>
> On Mon 29-02-16 18:38:45, Oleg Nesterov wrote:
> 
> > In this case you do not need put_task_struct().
> 
> Why not? Both are after get_proc_task which takes a reference to the
> task...

Yes, but we already have put_task_struct(task) in the "out_mm" path, so
"goto out_mm" should work just fine?

Oleg.
