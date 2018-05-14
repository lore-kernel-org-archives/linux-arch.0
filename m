From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PATCH v2 0/7] Introduce the for_each_set_port_word macro
Date: Mon, 14 May 2018 08:57:54 -0400
Message-ID: <20180514125743.GA20325@sophia>
References: <cover.1525785532.git.vilhelm.gray@gmail.com>
 <CAHp75Vf8TLhj07VKeDdvzqHvViHqgRkd6=n2hZR_yY7in52SHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75Vf8TLhj07VKeDdvzqHvViHqgRkd6=n2hZR_yY7in52SHA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Sun, May 13, 2018 at 06:11:45PM +0300, Andy Shevchenko wrote:
>On Tue, May 8, 2018 at 4:26 PM, William Breathitt Gray
><vilhelm.gray@gmail.com> wrote:
>
>> While adding GPIO get_multiple/set_multiple callback support for various
>> drivers, I noticed a pattern of looping manifesting that would be useful
>> standardized as a macro.
>>
>> This patchset introduces the for_each_set_port_word macro and utilizes
>> it in several GPIO drivers. The for_each_set_port_word macro facilitates
>> a for-loop syntax that iterates over entire groups of set bits at a
>> time.
>>
>> For example, suppose you would like to iterate over a 16-bit integer 4
>> bits at a time, skipping over 4-bit groups with no set bit, where XXXX
>> represents the current 4-bit group:
>>
>>     Example:        1011 1110 0000 1111
>>     First loop:     1011 1110 0000 XXXX
>
>>     Second loop:    1011 XXXX 0000 1111
>
>8-bit itteration. Is it correct?

This case is 4-bit iteration for the sake of example, but the idea is
to have the for_each_set_port_word macro to be capable of 8-bit
iteration, as well as any other number of bits, as specified by the
port_size parameter.

>
>>     Third loop:     XXXX 1110 0000 1111
>
>Looking at the example above I highly recommend to introduce some test
>cases for your helper function.
>
>Consider extending lib/test_bitmap.c for this purpose.

That's a good idea. I'll add in some test cases to lib/test_bitmap.c to
help check the implementation of these functions and macro.

William Breathitt Gray

>
>>
>> Each iteration of the loop returns the next 4-bit group that has at
>> least one set bit.
>>
>> The for_each_set_port_word macro has six parameters:
>>
>>     * port_word: set to current port word index for the iteration
>>     * word_index: set to current bitmap word index for the iteration
>>     * word_offset: bits offset of the found port word in the bitmap word
>>     * bits: bitmap to search within
>>     * size: bitmap size in number of port words
>>     * port_size: port word size in number of bits
>>
>> The port_size argument can be an arbitrary number of bits and is not
>> required to be a multiple of 2.
>>
>> I've called the group of bits a "port word" which may be a confusing
>> naming convention; I was afraid calling that them a "group" may be too
>> vague. Should a different name be chosen; what would you suggest?
>>
>> This patchset was rebased on top of the following three commits:
>>
>>     * commit aaf96e51de11 ("gpio: pci-idio-16: Fix port memory offset for get_multiple callback")
>>     * commit 304440aa96c6 ("gpio: pcie-idio-24: Fix port memory offset for get_multiple/set_multiple callbacks")
>>     * commit e026646c178d ("gpio: pcie-idio-24: Fix off-by-one error in get_multiple loop")
>>
>> William Breathitt Gray
>>
>> William Breathitt Gray (7):
>>   bitops: Introduce the for_each_set_port_word macro
>>   gpio: 104-dio-48e: Utilize for_each_set_port_word macro
>>   gpio: 104-idi-48: Utilize for_each_set_port_word macro
>>   gpio: gpio-mm: Utilize for_each_set_port_word macro
>>   gpio: ws16c48: Utilize for_each_set_port_word macro
>>   gpio: pci-idio-16: Utilize for_each_set_port_word macro
>>   gpio: pcie-idio-24: Utilize for_each_set_port_word macro
>>
>>  drivers/gpio/gpio-104-dio-48e.c   |  67 +++++---------------
>>  drivers/gpio/gpio-104-idi-48.c    |  32 ++--------
>>  drivers/gpio/gpio-gpio-mm.c       |  67 +++++---------------
>>  drivers/gpio/gpio-pci-idio-16.c   |  67 ++++++--------------
>>  drivers/gpio/gpio-pcie-idio-24.c  | 102 +++++++++++-------------------
>>  drivers/gpio/gpio-ws16c48.c       |  66 +++++--------------
>>  include/asm-generic/bitops/find.h |  26 ++++++++
>>  include/linux/bitops.h            |   9 +++
>>  lib/find_bit.c                    |  28 ++++++++
>>  9 files changed, 172 insertions(+), 292 deletions(-)
>>
>> --
>> 2.17.0
>>
>
>
>
>-- 
>With Best Regards,
>Andy Shevchenko
