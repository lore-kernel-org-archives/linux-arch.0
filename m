From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [patches] Re: [PATCH 01/17] drivers: support PCIe in RISCV
Date: Fri, 23 Jun 2017 14:47:34 -0700 (PDT)
Message-ID: <mhng-3678d26e-78a2-40af-a54c-fd16d0593e37@palmer-si-x1c4>
References: <CAOesGMgrXcWvrv-8Xos7qeXsYhsx5XJEXnU8NqQ1X7YvoYkDaA@mail.gmail.com>
Mime-Version: 1.0 (MHng)
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33014 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754162AbdFWVrf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Jun 2017 17:47:35 -0400
Received: by mail-pf0-f193.google.com with SMTP id w12so9121174pfk.0
        for <linux-arch@vger.kernel.org>; Fri, 23 Jun 2017 14:47:35 -0700 (PDT)
In-Reply-To: <CAOesGMgrXcWvrv-8Xos7qeXsYhsx5XJEXnU8NqQ1X7YvoYkDaA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Olof Johansson <olof@lixom.net>
Cc: Wesley Terpstra <wesley@sifive.com>, hch@infradead.org, patches@groups.riscv.org, linux-arch@vger.kernel.org, albert@sifive.com, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org

On Wed, 07 Jun 2017 10:40:50 PDT (-0700), Olof Johansson wrote:
> On Wed, Jun 7, 2017 at 10:09 AM, Wesley Terpstra <wesley@sifive.com> wrote:
>>
>>
>> On Jun 7, 2017 7:26 AM, "Christoph Hellwig" <hch@infradead.org> wrote:
>>
>> On Tue, Jun 06, 2017 at 03:59:51PM -0700, Palmer Dabbelt wrote:
>>> From: "Wesley W. Terpstra" <wesley@sifive.com>
>>>
>>> There are RISC-V systems that have been mapped to Xilinx FPGAs that have
>>> their PCIe controllers on chip.  These build system changes allow RISC-V
>>> systems to enable the Xilinx PCIe controller, and to setup PCIe IRQs.
>>>
>>> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
>>> ---
>>>  drivers/pci/Makefile     | 1 +
>>>  drivers/pci/host/Kconfig | 2 +-
>>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
>>> index 462c1f5f5546..a29d9ec05d13 100644
>>> --- a/drivers/pci/Makefile
>>> +++ b/drivers/pci/Makefile
>>> @@ -41,6 +41,7 @@ obj-$(CONFIG_MIPS) += setup-irq.o
>>>  obj-$(CONFIG_TILE) += setup-irq.o
>>>  obj-$(CONFIG_SPARC_LEON) += setup-irq.o
>>>  obj-$(CONFIG_M68K) += setup-irq.o
>>> +obj-$(CONFIG_RISCV) += setup-irq.o
>>
>> Can we do a cleanup here and add a ARCH_USE_GENERIC_PCI_SETUP Kconfig
>> symbol that all these architectures can select?
>>
>>
>> That would probably be better. I did not want to touch other arch/ folders
>> in our changes.
>
> I understand that approach when you're doing things in your tree
> early, but in this case (and at this phase in submission/merging),
> don't be afraid to touch other architectures and refactor/clean up.
>
> Please do the refactor in a separate preceding patch and submit it
> separate/soon instead of keeping it just in the series and bundled
> with your addition. That way it can go in when ready even if the rest
> of the series is spinning.

Makes sense.  I've started submitting the various smaller patches so we can get
them all in to make our patch set smaller.
