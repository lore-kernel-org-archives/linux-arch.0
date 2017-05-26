From: Ian Abbott <abbotti@mev.co.uk>
Subject: Re: [PATCH v5 6/6] kernel.h: handle pointers to arrays better in
 container_of()
Date: Fri, 26 May 2017 14:57:31 +0100
Message-ID: <914b2a30-f466-ac5e-fd89-dad4fb1cee80@mev.co.uk>
References: <20170525120316.24473-1-abbotti@mev.co.uk>
 <20170525120316.24473-7-abbotti@mev.co.uk>
 <CAGXu5jJvNBEi07=VDtvhC4+p6NAv21y09DCUuxry7o-9=JzcrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp72.iad3a.emailsrvr.com ([173.203.187.72]:37791 "EHLO
        smtp72.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S940577AbdEZN5e (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 26 May 2017 09:57:34 -0400
In-Reply-To: <CAGXu5jJvNBEi07=VDtvhC4+p6NAv21y09DCUuxry7o-9=JzcrQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Alexander Potapenko <glider@google.com>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@suse.de>, Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>, Jakub Kicinski <jakub.kicinski@netronome.com>, Johannes Berg <johannes.berg@intel.com>, Michal Nazarewicz <mina86@mina86.com>, Peter Zijlstra <peterz@infradead.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Steven Rostedt <rostedt@goodmis.org>

On 25/05/17 19:35, Kees Cook wrote:
> On Thu, May 25, 2017 at 5:03 AM, Ian Abbott <abbotti@mev.co.uk> wrote:
>> If the first parameter of container_of() is a pointer to a
>> non-const-qualified array type (and the third parameter names a
>> non-const-qualified array member), the local variable __mptr will be
>> defined with a const-qualified array type.  In ISO C, these types are
>> incompatible.  They work as expected in GNU C, but some versions will
>> issue warnings.  For example, GCC 4.9 produces the warning
>> "initialization from incompatible pointer type".
>>
>> Here is an example of where the problem occurs:
>>
>> -------------------------------------------------------
>>  #include <linux/kernel.h>
>>  #include <linux/module.h>
>>
>> MODULE_LICENSE("GPL");
>>
>> struct st {
>>         int a;
>>         char b[16];
>> };
>>
>> static int __init example_init(void) {
>>         struct st t = { .a = 101, .b = "hello" };
>>         char (*p)[16] = &t.b;
>>         struct st *x = container_of(p, struct st, b);
>>         printk(KERN_DEBUG "%p %p\n", (void *)&t, (void *)x);
>>         return 0;
>> }
>>
>> static void __exit example_exit(void) {
>> }
>>
>> module_init(example_init);
>> module_exit(example_exit);
>> -------------------------------------------------------
>>
>> Building the module with gcc-4.9 results in these warnings (where '{m}'
>> is the module source and '{k}' is the kernel source):
>>
>> -------------------------------------------------------
>> In file included from {m}/example.c:1:0:
>> {m}/example.c: In function ‘example_init’:
>> {k}/include/linux/kernel.h:854:48: warning: initialization from
>> incompatible pointer type
>>   const typeof( ((type *)0)->member ) *__mptr = (ptr); \
>>                                                 ^
>> {m}/example.c:14:17: note: in expansion of macro ‘container_of’
>>   struct st *x = container_of(p, struct st, b);
>>                  ^
>> {k}/include/linux/kernel.h:854:48: warning: (near initialization for
>> ‘x’)
>>   const typeof( ((type *)0)->member ) *__mptr = (ptr); \
>>                                                 ^
>> {m}/example.c:14:17: note: in expansion of macro ‘container_of’
>>   struct st *x = container_of(p, struct st, b);
>>                  ^
>> -------------------------------------------------------
>>
>> Replace the type checking performed by the macro to avoid these
>> warnings.  Make sure `*(ptr)` either has type compatible with the
>> member, or has type compatible with `void`, ignoring qualifiers.  Raise
>> compiler errors if this is not true.  This is stronger than the previous
>> behaviour, which only resulted in compiler warnings for a type mismatch.
>>
>> Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Michal Nazarewicz <mina86@mina86.com>
>> Cc: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
>> Cc: Borislav Petkov <bp@suse.de>
>> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> Cc: Johannes Berg <johannes.berg@intel.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Alexander Potapenko <glider@google.com>
>> Acked-by: Michal Nazarewicz <mina86@mina86.com>
>
> Seems reasonable to me. I think this actually improves the errors
> reported when something is mismatched in container_of(). Silly
> question: does this pass an allyesconfig?

Yes for ARCH=i386 at least.

>
> Acked-by: Kees Cook <keescook@chromium.org>

Thanks!

-- 
-=( Ian Abbott @ MEV Ltd.    E-mail: <abbotti@mev.co.uk> )=-
-=(                          Web: http://www.mev.co.uk/  )=-
