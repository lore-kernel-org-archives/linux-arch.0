From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PATCH v4 0/8] Introduce the for_each_set_clump macro
Date: Sat, 16 Jun 2018 15:16:24 -0400
Message-ID: <20180616191624.GA20211@sophia>
References: <cover.1526400945.git.vilhelm.gray@gmail.com>
 <CACRpkdbRH-Bz3BoczD+YmaSGqtoeCwtvGj4dGm8PKRKYFXTdKA@mail.gmail.com>
 <CAHp75VcGuJ0+qzUZZW=1VSeXmf_rht0tJvCH+yBsXPZz0z8qHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VcGuJ0+qzUZZW=1VSeXmf_rht0tJvCH+yBsXPZz0z8qHA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, May 16, 2018 at 11:08:28PM +0300, Andy Shevchenko wrote:
>On Wed, May 16, 2018 at 5:03 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Tue, May 15, 2018 at 6:22 PM, William Breathitt Gray
>> <vilhelm.gray@gmail.com> wrote:
>>
>>> For example, suppose you would like to iterate over a 16-bit integer 4
>>> bits at a time, skipping over 4-bit groups with no set bit, where XXXX
>>> represents the current 4-bit group:
>>>
>>>     Example:        1011 1110 0000 1111
>>>     First loop:     1011 1110 0000 XXXX
>>>     Second loop:    1011 XXXX 0000 1111
>>>     Third loop:     XXXX 1110 0000 1111
>>>
>>> Each iteration of the loop returns the next 4-bit group that has at
>>> least one set bit.
>>>
>>> The for_each_set_clump macro has six parameters:
>>>
>>>     * clump: set to current clump index for the iteration
>>>     * index: set to current bitmap word index for the iteration
>>>     * offset: bits offset of the found clump in the bitmap word
>>>     * bits: bitmap to search within
>>>     * size: bitmap size in number of clumps
>>>     * clump_size: clump size in number of bits
>>>
>>> The clump_size argument can be an arbitrary number of bits and is not
>>> required to be a multiple of 2.
>>
>> I must say I'm impressed. Very nice arithmetics going on there.
>>
>> If I can get some ACK for the bitops patch I'd be happy to merge
>> it all through the GPIO tree. The users are pretty clear cut.
>
>Give me also some time to go through proposed API, I think it might
>have needed more alignment with existing find_* and for_* helpers.

Hi Andy,

Are there any additional changes you would like me to make before this
patchset is merged through the GPIO tree?

William Breathitt Gray

>
>> BTW: if I could, I would pull out Donald Knuth's "The Art of Computer
>> Programming vol 4A" chapter 7.1.3 "Bitwise Tricks and Techniques"
>> to see what he has to say about the subject, but I don't have
>> that book as it turns out.
>
>I can also add the Standford collection of bit algos here:
>
>https://graphics.stanford.edu/~seander/bithacks.html
>
>-- 
>With Best Regards,
>Andy Shevchenko
