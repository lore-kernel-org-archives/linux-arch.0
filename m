From: Ley Foon Tan <lftan@altera.com>
Subject: Re: [PATCH 14/28] nios2: DMA mapping API
Date: Fri, 25 Apr 2014 18:36:10 +0800
Message-ID: <CAFiDJ58tCgczGMrQ4LCMoEfsjpjn6ZM428Uz31EKQpcHHo6GLw@mail.gmail.com>
References: <1397824031-4892-1-git-send-email-lftan@altera.com>
	<201404221552.00501.arnd@arndb.de>
	<CAFiDJ58__vjDk93crSxGe1us0K7a3kSUwScgk=VaJYy+VqXsWQ@mail.gmail.com>
	<5211486.kMbLRJnNBP@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5211486.kMbLRJnNBP@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, cltang@codesourcery.com
List-Id: linux-arch.vger.kernel.org

On Fri, Apr 25, 2014 at 6:33 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 25 April 2014 18:13:31 Ley Foon Tan wrote:
>> Actually, nios2 doesn't have DMA master with 0x00ffffff mask. I will
>> change it to return 1, same as some other architectures
>> implementation.
>> And the ZONE_DMA stuff will remove as well, it shouldn't have ZONE_DMA
>> limitation.
>
> Ok, excellent!
>
Thanks. BTW, do you have any chance to review other patches? :)

Regards
Ley Foon
