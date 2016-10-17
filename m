From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [GIT PULL] kbuild changes for v4.9-rc1
Date: Mon, 17 Oct 2016 14:32:54 +0300
Message-ID: <CACVxJT9PR2ReWtE6-ndbxHfR-tTwmZdDSbwugsTxs+ZwvRG4Pw@mail.gmail.com>
References: <20161017065131.GA27863@angband.pl> <20161017175951.31d8f4b7@roar.ozlabs.ibm.com>
 <20161017100130.GA16013@angband.pl> <CACVxJT88NHrm56XyvYgaYqW1zDjoxdPWQmMzHZ7g2MDRQSSkaQ@mail.gmail.com>
 <CAMuHMdXxZ+jVt-ev5zJ7VhhC7viyEfZzW+d3NyCgq02vpZg0ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdXxZ+jVt-ev5zJ7VhhC7viyEfZzW+d3NyCgq02vpZg0ew@mail.gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Adam Borowski <kilobyte@angband.pl>, Nicholas Piggin <npiggin@gmail.com>, Omar Sandoval <osandov@osandov.com>, Michal Marek <mmarek@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Al Viro <viro@zeniv.linux.org.uk>, linux-kbuild <linux-kbuild@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Oct 17, 2016 at 2:17 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Alexey,
>
> On Mon, Oct 17, 2016 at 1:12 PM, Alexey Dobriyan <adobriyan@gmail.com> wrote:
>> On Mon, Oct 17, 2016 at 1:01 PM, Adam Borowski <kilobyte@angband.pl> wrote:
>>> On Mon, Oct 17, 2016 at 05:59:51PM +1100, Nicholas Piggin wrote:
>>>> On Mon, 17 Oct 2016 08:51:31 +0200
>>>> Adam Borowski <kilobyte@angband.pl> wrote:
>>
>>> --- /dev/null
>>> +++ b/include/asm-generic/asm-prototypes.h
>>> @@ -0,0 +1,7 @@
>>> +#include <linux/bitops.h>
>>> +extern void *__memset(void *, int, __kernel_size_t);
>>> +extern void *__memcpy(void *, const void *, __kernel_size_t);
>>> +extern void *__memmove(void *, const void *, __kernel_size_t);
>>> +extern void *memset(void *, int, __kernel_size_t);
>>> +extern void *memcpy(void *, const void *, __kernel_size_t);
>>> +extern void *memmove(void *, const void *, __kernel_size_t);
>>
>> Before too late, those extern keywords aren't needed and
>> only slowdown compilation.
>
> Do you have any profiling data backing this?

It is easy to obtain. Here is top 10 with runtime bigger than 0.50%:

_int_malloc
ht_lookup_with_hash
_cpp_lex_direct
cpp_get_token_1
ggc_internal_alloc_statm
_int_free
malloc_consolidate
lex_identifier
enter_macro_context
c_lex_with_flags
bitmap_set_bit
malloc
grokdeclarator
htab_find_slot_with_hash
c_lex_one_token
_cpp_lex_token
pop_scopev
c_parser_declspecs

Imagine you're a compiler. Those extern's are tokens. They need to be parsed
(byte-by-byte), allocated, and, in case of "extern" with prototype, thrown away.
They make line longer forcing people to dance around with splitting
per 80 characters
and generally making everything somewhat slower. Might as well don't new ones.

bitops.h is wrong header as well.
Why do you need bitops for bunch of function prototypes?
