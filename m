From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v4 07/16] mm: Fix memcg stack accounting for sub-page
 stacks
Date: Fri, 24 Jun 2016 10:22:12 -0500
Message-ID: <20160624152212.5uutwkvfmj6sr24c@treble>
References: <cover.1466741835.git.luto@kernel.org>
 <b8a5aad2ee4ac1302227348b7a59a8b69e322fbb.1466741835.git.luto@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44282 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750988AbcFXPWP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 24 Jun 2016 11:22:15 -0400
Content-Disposition: inline
In-Reply-To: <b8a5aad2ee4ac1302227348b7a59a8b69e322fbb.1466741835.git.luto@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vladimir Davydov <vdavydov@virtuozzo.com>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org

On Thu, Jun 23, 2016 at 09:23:02PM -0700, Andy Lutomirski wrote:
> We should account for stacks regardless of stack size, and we need
> to account in sub-page units if THREAD_SIZE < PAGE_SIZE.  Change the
> units to kilobytes and Move it into account_kernel_stack().
> 
> Fixes: 12580e4b54ba8 ("mm: memcontrol: report kernel stack usage in cgroup2 memory.stat")
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
