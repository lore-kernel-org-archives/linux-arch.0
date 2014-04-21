From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 00/28] nios2 Linux kernel port
Date: Sun, 20 Apr 2014 22:31:34 -0700
Message-ID: <5354AD36.5090809@zytor.com>
References: <1397824031-4892-1-git-send-email-lftan@altera.com>	<53518FAC.8020504@zytor.com>	<201404191730.54400.arnd@arndb.de> <CAFiDJ5-PiUWetRMp65VTo4pvZM65r3WBjCZVWmxW0XnqAyO-GA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAFiDJ5-PiUWetRMp65VTo4pvZM65r3WBjCZVWmxW0XnqAyO-GA@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Ley Foon Tan <lftan@altera.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, cltang@codesourcery.com
List-Id: linux-arch.vger.kernel.org

On 04/20/2014 10:23 PM, Ley Foon Tan wrote:
> On Sat, Apr 19, 2014 at 11:30 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Friday 18 April 2014, H. Peter Anvin wrote:
>>> Did the generic headers ever get updated to match Linus' guidance that
>>> any new architecture ports should use a 64-bit time_t?
>>
>> No, unfortunately not. With my rule that every architecture that gets
>> added needs to clean up asm-generic some more, to make it easier to add
>> the next one, we should probably do for nios2.
>>
>>         Arnd
> 
> Can you give me the documentation on this new guidance and point me
> any architecture have implemented this?
> Thanks.
> 

We implemented it in the x32 ABI for x86.  In generic code this is keyed
by COMPAT_USE_64BIT_TIME, but in your case it isn't actually a matter of
compat, so it should be easier.

See this thread including the discussion about time_t:

https://lkml.org/lkml/2011/8/26/415

	-hpa

