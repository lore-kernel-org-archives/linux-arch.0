From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v4 06/16] mm: Track NR_KERNEL_STACK in KiB instead of
 number of stacks
Date: Fri, 24 Jun 2016 10:21:53 -0500
Message-ID: <20160624152153.k53i4m3iepoh4yax@treble>
References: <cover.1466741835.git.luto@kernel.org>
 <c2bc2ab30908b444e517b39ea1e22c9c057d5039.1466741835.git.luto@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43813 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750988AbcFXPV5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 24 Jun 2016 11:21:57 -0400
Content-Disposition: inline
In-Reply-To: <c2bc2ab30908b444e517b39ea1e22c9c057d5039.1466741835.git.luto@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vladimir Davydov <vdavydov@virtuozzo.com>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org

On Thu, Jun 23, 2016 at 09:23:01PM -0700, Andy Lutomirski wrote:
> Currently, NR_KERNEL_STACK tracks the number of kernel stacks in a
> zone.  This only makes sense if each kernel stack exists entirely in
> one zone, and allowing vmapped stacks could break this assumption.
> 
> Since frv has THREAD_SIZE < PAGE_SIZE, we need to track kernel stack
> allocations in a unit that divides both THREAD_SIZE and PAGE_SIZE on
> all architectures.  Keep it simple and use KiB.
> 
> Cc: Vladimir Davydov <vdavydov@virtuozzo.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: linux-mm@kvack.org
> Reviewed-by: Vladimir Davydov <vdavydov@virtuozzo.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>

Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh
