Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60280 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750705AbcCKKGq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 11 Mar 2016 05:06:46 -0500
Subject: Re: [PATCH 03/18] mm: make vm_munmap killable
References: <1456752417-9626-1-git-send-email-mhocko@kernel.org>
 <1456752417-9626-4-git-send-email-mhocko@kernel.org>
From: Vlastimil Babka <vbabka@suse.cz>
Message-ID: <56E298B1.6010802@suse.cz>
Date: Fri, 11 Mar 2016 11:06:41 +0100
MIME-Version: 1.0
In-Reply-To: <1456752417-9626-4-git-send-email-mhocko@kernel.org>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Alex Deucher <alexander.deucher@amd.com>, Alex Thorlton <athorlton@sgi.com>, Andrea Arcangeli <aarcange@redhat.com>, Andy Lutomirski <luto@amacapital.net>, Benjamin LaHaise <bcrl@kvack.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Daniel Vetter <daniel.vetter@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Airlie <airlied@linux.ie>, Davidlohr Bueso <dave@stgolabs.net>, David Rientjes <rientjes@google.com>, "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Konstantin Khlebnikov <koct9i@gmail.com>, linux-arch@vger.kernel.org, Mel Gorman <mgorman@suse.de>, Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Petr Cermak <petrcermak@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Michal Hocko <mhocko@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>
Message-ID: <20160311100641.cx2HjOrq1hCMALYXMlyJtR81yWwfSrMUuKSunlzBG50@z>

On 02/29/2016 02:26 PM, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
>
> Almost all current users of vm_munmap are ignoring the return value
> and so they do not handle potential error. This means that some VMAs

    1   7834  arch/x86/kvm/x86.c <<__x86_set_memory_region>>

              r = vm_munmap(old.userspace_addr, old.npages * PAGE_SIZE);
              WARN_ON(r < 0);

This warning will potentially add noise to OOM output?

