Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:32989 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752644AbcGFNVH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 6 Jul 2016 09:21:07 -0400
Received: by mail-vk0-f44.google.com with SMTP id b192so4564267vke.0
        for <linux-arch@vger.kernel.org>; Wed, 06 Jul 2016 06:21:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160630193723.GE3932@pd.tnic>
References: <cover.1466974736.git.luto@kernel.org> <fbaa1409c74ddc7b29b52c87303d2af1db91e2ba.1466974736.git.luto@kernel.org>
 <20160630193723.GE3932@pd.tnic>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 6 Jul 2016 06:20:46 -0700
Message-ID: <CALCETrVGhXiZqGMNkdeebjLTR6MdnvVqzcDikzGHp9JehuzHKQ@mail.gmail.com>
Subject: Re: [PATCH v4 08/29] dma-api: Teach the "DMA-from-stack" check about
 vmapped stacks
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20160706132046.cryuqp8vuRs07npuNWLJcgVtGDR7g85vWVojSXFLNlY@z>

On Thu, Jun 30, 2016 at 12:37 PM, Borislav Petkov <bp@alien8.de> wrote:
> On Sun, Jun 26, 2016 at 02:55:30PM -0700, Andy Lutomirski wrote:
>> If we're using CONFIG_VMAP_STACK and we manage to point an sg entry
>> at the stack, then either the sg page will be in highmem or sg_virt
>> will return the direct-map alias.  In neither case will the existing
>> check_for_stack() implementation realize that it's a stack page.
>>
>> Fix it by explicitly checking for stack pages.
>>
>> This has no effect by itself.  It's broken out for ease of review.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Andy Lutomirski <luto@kernel.org>
>> ---
>>  lib/dma-debug.c | 39 +++++++++++++++++++++++++++++++++------
>>  1 file changed, 33 insertions(+), 6 deletions(-)
>>
>> diff --git a/lib/dma-debug.c b/lib/dma-debug.c
>> index 51a76af25c66..5b2e63cba90e 100644
>> --- a/lib/dma-debug.c
>> +++ b/lib/dma-debug.c
>> @@ -22,6 +22,7 @@
>>  #include <linux/stacktrace.h>
>>  #include <linux/dma-debug.h>
>>  #include <linux/spinlock.h>
>> +#include <linux/vmalloc.h>
>>  #include <linux/debugfs.h>
>>  #include <linux/uaccess.h>
>>  #include <linux/export.h>
>> @@ -1162,11 +1163,35 @@ static void check_unmap(struct dma_debug_entry *ref)
>>       put_hash_bucket(bucket, &flags);
>>  }
>>
>> -static void check_for_stack(struct device *dev, void *addr)
>> +static void check_for_stack(struct device *dev,
>> +                         struct page *page, size_t offset)
>>  {
>> -     if (object_is_on_stack(addr))
>> -             err_printk(dev, NULL, "DMA-API: device driver maps memory from "
>> -                             "stack [addr=%p]\n", addr);
>> +     void *addr;
>> +     struct vm_struct *stack_vm_area = task_stack_vm_area(current);
>
> lib/dma-debug.c: In function ‘check_for_stack’:
> lib/dma-debug.c:1170:36: error: implicit declaration of function ‘task_stack_vm_area’ [-Werror=implicit-function-declaration]
>   struct vm_struct *stack_vm_area = task_stack_vm_area(current);
>                                     ^
> lib/dma-debug.c:1170:36: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
> cc1: some warnings being treated as errors
> make[1]: *** [lib/dma-debug.o] Error 1
> make: *** [lib] Error 2
> make: *** Waiting for unfinished jobs....
>
> Probably reorder pieces from patch 9 to earlier ones...

I'll address this by reordering it later in the series.  The temporary
loss of functionality will be unobservable.

--Andy
