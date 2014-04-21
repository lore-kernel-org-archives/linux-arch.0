From: Ley Foon Tan <lftan@altera.com>
Subject: Re: [PATCH 00/28] nios2 Linux kernel port
Date: Mon, 21 Apr 2014 13:23:19 +0800
Message-ID: <CAFiDJ5-PiUWetRMp65VTo4pvZM65r3WBjCZVWmxW0XnqAyO-GA@mail.gmail.com>
References: <1397824031-4892-1-git-send-email-lftan@altera.com>
	<53518FAC.8020504@zytor.com>
	<201404191730.54400.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <201404191730.54400.arnd@arndb.de>
Sender: linux-doc-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, cltang@codesourcery.com
List-Id: linux-arch.vger.kernel.org

On Sat, Apr 19, 2014 at 11:30 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 18 April 2014, H. Peter Anvin wrote:
>> Did the generic headers ever get updated to match Linus' guidance that
>> any new architecture ports should use a 64-bit time_t?
>
> No, unfortunately not. With my rule that every architecture that gets
> added needs to clean up asm-generic some more, to make it easier to add
> the next one, we should probably do for nios2.
>
>         Arnd

Can you give me the documentation on this new guidance and point me
any architecture have implemented this?
Thanks.

Ley Foon
