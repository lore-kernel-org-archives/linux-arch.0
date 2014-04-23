From: Chung-Lin Tang <cltang@codesourcery.com>
Subject: Re: [PATCH 00/28] nios2 Linux kernel port
Date: Thu, 24 Apr 2014 01:59:42 +0800
Message-ID: <5357FF8E.9010809@codesourcery.com>
References: <1397824031-4892-1-git-send-email-lftan@altera.com>	<5354AD36.5090809@zytor.com>	<CAFiDJ5861HE4AXtio-8uNJppWE2oaPt9_OKyGV=Myb_3vPrOVA@mail.gmail.com>	<16597012.pEkDc99HDN@wuerfel> <CAFiDJ5_dUpVTSeC36AfNKVN7BOa9GQ5vwSEWricm=8Sam9mR2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAFiDJ5_dUpVTSeC36AfNKVN7BOa9GQ5vwSEWricm=8Sam9mR2A@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Ley Foon Tan <lftan@altera.com>, Arnd Bergmann <arnd@arndb.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Catalin.Marinas@arm.com, Andrew Pinski <apinski@cavium.com>
List-Id: linux-arch.vger.kernel.org

On 2014/4/22 07:20 PM, Ley Foon Tan wrote:
> On Tue, Apr 22, 2014 at 6:56 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Tuesday 22 April 2014 18:37:11 Ley Foon Tan wrote:
>>> >> Hi Arnd and Peter Anvin,
>>> >>
>>> >> Other than 64-bit time_t, clock_t and suseconds_t, can you confirm
>>> >> that we don't need to have 64 bit off_t? See detail in link below.
>>> >> I can submit the patches for 64-bit time changes
>>> >> (include/asm-generic/posix_types.h and other archs) if everyone is
>>> >> agreed on this.
>> >
>> > Yes.
> Okay, will doing that.

I believe that arm64 ILP32 will also be affected. What is the status of
this configuration? Has the glibc/kernel ABI been finalized?

Thanks,
Chung-Lin

