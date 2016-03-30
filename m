From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] asm-generic/io.h: provide default ioremap/iounmap for !HAS_IOMEM
Date: Wed, 30 Mar 2016 08:29:45 -0500
Message-ID: <CAL_Jsq+RHwzxfoEFsD_-uAZ7Y_CEdXvv8qamdXtcToeG-ENy7w@mail.gmail.com>
References: <1459275781-3863-1-git-send-email-robh@kernel.org>
 <6746826.YZLTqKTgkv@wuerfel> <56FB8AC1.4070209@nod.at> <6282729.XLLXSxbzQJ@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6282729.XLLXSxbzQJ@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Richard Weinberger <richard@nod.at>, Lee Jones <lee.jones@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net
List-Id: linux-arch.vger.kernel.org

On Wed, Mar 30, 2016 at 5:03 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 30 March 2016 10:13:53 Richard Weinberger wrote:
>>
>> I fully understand your point of view. COMPILE_TEST is a monster that
>> can do the heavy lifting for you, but monsters also have claws and fangs.
>>
>> Having COMPILE_TEST having depend on !UML works for me. But don't
>> we have other archs without io mem? At least a few years ago while
>> porting nandsim to UML I found s390 that lacks of io mem too.
>
> s390 gained IOMEM support when they started having PCI attachments.

I'm confused how s390 defines HAS_IOMEM and includes it from lib/Kconfig though.

> arch/score selects NO_IOMEM, though they do in fact use MMIO, and
> I'm sure their architecture has lots of other problems with build
> testing that nobody cares about.
>
> arch/tile can select NO_IOMEM when PCI is disabled, they might
> care about this, though I think they also have other build-time
> issues.
>
>> Maybe we depend COMPILE_TEST on HAS_IOMEM?
>
> That sounds fine with me as well.

That or !UML is fine, but I still think we should rid drivers from
depending on HAS_IOMEM. We probably still have cases where the only
dependency besides the driver's subsystem is HAS_IOMEM.

Rob
