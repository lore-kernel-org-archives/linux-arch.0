From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [RFC][CFT][PATCHSET v1] uaccess unification
Date: Tue, 4 Apr 2017 13:26:29 -0700
Message-ID: <20170404202629.GA31611@octofox.metropolis>
References: <20170329055706.GH29622@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170329055706.GH29622@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Richard Henderson <rth@twiddle.net>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Steven Miao <realmz6@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Mark Salter <msalter@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, James Hogan <james.hogan@imgtec.com>, Michal Simek <monstr@monstr.eu>, David Howells <dhowells@redhat.com>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@southpole.se>, Helge Deller <del>
List-Id: linux-arch.vger.kernel.org

On Wed, Mar 29, 2017 at 06:57:06AM +0100, Al Viro wrote:
> I hope that infrastructure part is stable enough to put it into never-rebased
> state.  Some of per-architecture branches might be even done right; however,
> most of them got no testing whatsoever, so any help with testing (as well
> as "Al, for fuck sake, dump that garbage of yours, here's the correct patch"
> from maintainers) would be very welcome.  So would the review, of course.

For the xtensa part:
Tested-by: Max Filippov <jcmvbkbc@gmail.com>

I believe that the xtensa part needs the following correction:

---8<---
From 4505d69c3514fb12405409a7943e45831d037960 Mon Sep 17 00:00:00 2001
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 4 Apr 2017 13:20:34 -0700
Subject: [PATCH] xtensa: fix prefetch in the raw_copy_to_user

'from' is the input buffer, it should be prefetched with prefetch, not
prefetchw.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/include/asm/uaccess.h b/arch/xtensa/include/asm/uaccess.h
index 8e93ed8..2e7bac0 100644
--- a/arch/xtensa/include/asm/uaccess.h
+++ b/arch/xtensa/include/asm/uaccess.h
@@ -245,7 +245,7 @@ raw_copy_from_user(void *to, const void __user *from, unsigned long n)
 static inline unsigned long
 raw_copy_to_user(void __user *to, const void *from, unsigned long n)
 {
-	prefetchw(from);
+	prefetch(from);
 	return __xtensa_copy_user((__force void *)to, from, n);
 }
 #define INLINE_COPY_FROM_USER
---8<---

-- 
Thanks.
-- Max
