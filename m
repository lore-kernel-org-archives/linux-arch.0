Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:36351 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752706AbcB2PmA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 29 Feb 2016 10:42:00 -0500
Received: by mail-ob0-f181.google.com with SMTP id s6so87238297obg.3
        for <linux-arch@vger.kernel.org>; Mon, 29 Feb 2016 07:42:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1456752417-9626-11-git-send-email-mhocko@kernel.org>
References: <1456752417-9626-1-git-send-email-mhocko@kernel.org> <1456752417-9626-11-git-send-email-mhocko@kernel.org>
From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 29 Feb 2016 07:41:39 -0800
Message-ID: <CALCETrU-oe6F4iV0Pu1KhEcTtwB-JveqLAcV88R2CP6DVUiRHw@mail.gmail.com>
Subject: Re: [PATCH 10/18] vdso: make arch_setup_additional_pages wait for
 mmap_sem for write killable
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Alex Deucher <alexander.deucher@amd.com>, Alex Thorlton <athorlton@sgi.com>, Andrea Arcangeli <aarcange@redhat.com>, Benjamin LaHaise <bcrl@kvack.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Daniel Vetter <daniel.vetter@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Airlie <airlied@linux.ie>, Davidlohr Bueso <dave@stgolabs.net>, David Rientjes <rientjes@google.com>, "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Konstantin Khlebnikov <koct9i@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, Mel Gorman <mgorman@suse.de>, Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Petr Cermak <petrcermak@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Michal Hocko <mhocko@suse.com>
Message-ID: <20160229154139.RY5kbL2ldvVGltAqfGgAhkBynGHDqnDAQudvcbArVag@z>

On Mon, Feb 29, 2016 at 5:26 AM, Michal Hocko <mhocko@kernel.org> wrote:
> From: Michal Hocko <mhocko@suse.com>
>
> most architectures are relying on mmap_sem for write in their
> arch_setup_additional_pages. If the waiting task gets killed by the oom
> killer it would block oom_reaper from asynchronous address space reclaim
> and reduce the chances of timely OOM resolving. Wait for the lock in
> the killable mode and return with EINTR if the task got killed while
> waiting.

Acked-by: Andy Lutomirski <luto@kernel.org> # for the x86 vdso
