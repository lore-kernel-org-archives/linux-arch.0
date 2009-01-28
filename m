From: Andrea Righi <righi.andrea@gmail.com>
Subject: Re: [PATCH -mmotm] mm: unify some pmd_*() functions
Date: Wed, 28 Jan 2009 18:59:37 +0100
Message-ID: <a2776ec50901280959l6f96d2e0g72ce5eed665894a7@mail.gmail.com>
References: <1232919337-21434-1-git-send-email-righi.andrea@gmail.com>
	 <20090127174158.519e5abd.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ew0-f21.google.com ([209.85.219.21]:46847 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049AbZA1R7k (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jan 2009 12:59:40 -0500
In-Reply-To: <20090127174158.519e5abd.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Roman Zippel <zippel@linux-m68k.org>, David Howells <dhowells@redhat.com>, Hirokazu Takata <takata@linux-m32r.org>

On Wed, Jan 28, 2009 at 2:41 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Sun, 25 Jan 2009 22:35:37 +0100
> Andrea Righi <righi.andrea@gmail.com> wrote:
>
>> diff --git a/include/asm-generic/pgtable-nopmd.h b/include/asm-generic/pgtable-nopmd.h
>> index a7cdc48..b132d69 100644
>> --- a/include/asm-generic/pgtable-nopmd.h
>> +++ b/include/asm-generic/pgtable-nopmd.h
>> @@ -4,6 +4,7 @@
>>  #ifndef __ASSEMBLY__
>>
>>  #include <asm-generic/pgtable-nopud.h>
>> +#include <asm/bug.h>
>>
>>  struct mm_struct;
>>
>
> Why not include the preferred <linux/bug.h>?

Using linux/bug.h leads to include hell (i.e. on x86 with
CONFIG_X86_PAE not set):
...
  CC      arch/x86/kernel/asm-offsets.s
In file included from include/linux/thread_info.h:55,
                 from include/linux/preempt.h:9,
                 from include/linux/spinlock.h:50,
                 from include/linux/seqlock.h:29,
                 from include/linux/time.h:8,
                 from include/linux/stat.h:60,
                 from include/linux/module.h:10,
                 from include/linux/bug.h:4,
                 from include/asm-generic/pgtable-nopmd.h:7,
                 from
/home/arighi/Software/linux/mmotm/arch/x86/include/asm/page.h:132,
                 from
/home/arighi/Software/linux/mmotm/arch/x86/include/asm/processor.h:18,
                 from
/home/arighi/Software/linux/mmotm/arch/x86/include/asm/atomic_32.h:6,
                 from
/home/arighi/Software/linux/mmotm/arch/x86/include/asm/atomic.h:2,
                 from include/linux/crypto.h:20,
                 from arch/x86/kernel/asm-offsets_32.c:7,
                 from arch/x86/kernel/asm-offsets.c:2:
/home/arighi/Software/linux/mmotm/arch/x86/include/asm/thread_info.h:34:
error: expected specifier-qualifier-list before 'mm_segment_t'
...

-Andrea
