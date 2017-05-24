From: Ian Abbott <abbotti@mev.co.uk>
Subject: Re: [PATCH 1/1] bug: fix problem including <linux.bug.h> from
 linux/kernel.h
Date: Wed, 24 May 2017 16:55:15 +0100
Message-ID: <82f67357-541d-8e08-3380-e485ea3e8764@mev.co.uk>
References: <20170524132107.6919-1-abbotti@mev.co.uk>
 <20170524132107.6919-2-abbotti@mev.co.uk>
 <CAKwiHFgm2AmSmcWPO+-apH+7SW9Mjh_-jRUNepdx5FUiWukGRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp64.ord1c.emailsrvr.com ([108.166.43.64]:59508 "EHLO
        smtp64.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1761286AbdEXQBl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 May 2017 12:01:41 -0400
In-Reply-To: <CAKwiHFgm2AmSmcWPO+-apH+7SW9Mjh_-jRUNepdx5FUiWukGRQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Michal Nazarewicz <mina86@mina86.com>, Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>, Borislav Petkov <bp@suse.de>, Johannes Berg <johannes.berg@intel.com>, Peter Zijlstra <peterz@infradead.org>, Alexander Potapenko <glider@google.com>

On 24/05/17 14:37, Rasmus Villemoes wrote:
> On 24 May 2017 at 15:21, Ian Abbott <abbotti@mev.co.uk> wrote:
>> If "include/linux/kernel.h" includes <linux/bug.h>, a circular
>> dependency is introduced
>
> Then don't. Can't we just create linux/build_bug.h and have that
> contain the BUILD_BUG related macros - they're really completely
> unrelated to all the asm-cruft bug.h needs to know about. build_bug.h
> can then include compiler.h and not much else to figure out how it may
> implement its macros. Then kernel.h can include build_bug.h, and we
> don't force each and every translation unit to include bug.h and
> everything that then pulls in. We just got rid of a lot of header
> bloat, let's try to keep it that way.

Thanks, I'll take a look at that.  In the meantime, I noticed the title 
line of this patch contains a nasty typo, so I'll send a v2 patch to fix 
that.

-- 
-=( Ian Abbott @ MEV Ltd.    E-mail: <abbotti@mev.co.uk> )=-
-=(                          Web: http://www.mev.co.uk/  )=-
