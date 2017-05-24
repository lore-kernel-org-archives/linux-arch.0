From: Ian Abbott <abbotti@mev.co.uk>
Subject: Re: [PATCH v2] bug: fix problem including <linux/bug.h> from
 linux/kernel.h
Date: Thu, 25 May 2017 00:11:32 +0100
Message-ID: <ca0b5278-86f3-4ad4-f096-3c9e919e7e7d@mev.co.uk>
References: <20170524132107.6919-2-abbotti@mev.co.uk>
 <20170524160627.14322-1-abbotti@mev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp88.iad3a.emailsrvr.com ([173.203.187.88]:54825 "EHLO
        smtp88.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1164500AbdEXXLg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 May 2017 19:11:36 -0400
In-Reply-To: <20170524160627.14322-1-abbotti@mev.co.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Michal Nazarewicz <mina86@mina86.com>, Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>, Borislav Petkov <bp@suse.de>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Johannes Berg <johannes.berg@intel.com>, Peter Zijlstra <peterz@infradead.org>, Alexander Potapenko <glider@google.com>

On 2017-05-24 17:06, Ian Abbott wrote:
> If "include/linux/kernel.h" includes <linux/bug.h>, a circular
> dependency is introduced when "include/asm-generic/bug.h" includes
> <linux/kernel.h>.  This results in build breakage when something
> includes <asm/bug.h> before <linux/kernel.h> for architectures that
> select `CONFIG_GENERIC_BUG` because `struct bug_entry` is not fully
> declared (not declared at all in fact) before its members are accessed
> by `is_warning_bug()`.
>
> To avoid this problem, remove the inclusion of <linux/kernel.h> from
> "include/asm-generic/bug.h", but include <linux/types.h> from
> "include/linux/bug.h" because it needs the `bool` type.
>
> A consequence of this change is that since most bug-related,
> function-link macros (`BUG()`, `WARN()` etc.) make use of facilities
> provided by <linux/kernel.h>, something else needs to include that
> before those macros are called.
>
> Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Nazarewicz <mina86@mina86.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
> v2: Fix typo in patch subject line.
> ---
>  include/asm-generic/bug.h | 1 -
>  include/linux/bug.h       | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)

This patch and its previous version can be dropped now, since the patch 
that caused the breakage that this patch fixes up 
(<https://lkml.org/lkml/2017/5/23/641>) has been dropped (for now). 
I'll avoid the breakage in the way suggested by Rasmus in 
<https://lkml.org/lkml/2017/5/24/553>.

-- 
-=( Ian Abbott @ MEV Ltd.    E-mail: <abbotti@mev.co.uk> )=-
-=(                          Web: http://www.mev.co.uk/  )=-
