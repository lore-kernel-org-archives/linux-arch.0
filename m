From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 06/17] pci: Add generic pcibios_{fixup_bus,align_resource}
Date: Fri, 23 Jun 2017 19:01:58 -0700 (PDT)
Message-ID: <mhng-c35f78ff-19cf-4876-93ca-262e2f285f79@palmer-si-x1c4>
References: <CAK8P3a3FVKto9Kg8nfxizoKa+6kjYpT1JQrSASwAd1o5bBJBUw@mail.gmail.com>
Mime-Version: 1.0 (MHng)
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a3FVKto9Kg8nfxizoKa+6kjYpT1JQrSASwAd1o5bBJBUw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: geert@linux-m68k.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>, albert@sifive.com, patches@groups.riscv.org, bhelgaas@google.com, linux-pci@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, 07 Jun 2017 01:01:57 PDT (-0700), Arnd Bergmann wrote:
> On Wed, Jun 7, 2017 at 9:19 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> CC pci folks
>>
>> On Wed, Jun 7, 2017 at 12:59 AM, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>> While upstreaming the RISC-V port, it was pointed out that multiple
>>> architectures (arc, arm64, cris, microblaze, sh, tile) have copied the
>>> mostly empty versions of at least one of these functions.  This defines
>>> weakly bound versions of the common functions so other architetures can
>>> use them.
>>>
>>> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
>
> Thanks a lot for taking care of this!

No problem.

>
>>> diff --git a/drivers/pci/bios.c b/drivers/pci/bios.c
>>> new file mode 100644
>>> index 000000000000..ffe34c024aa8
>>> --- /dev/null
>>> +++ b/drivers/pci/bios.c
>>> @@ -0,0 +1,42 @@
>>> +
>>> +/* This file contains weakly bound functions that implement pcibios functions
>>> + * that some architectures have copied verbatim.
>>> + */
>
> Instead of adding a new file, I would suggest adding the two functions next
> to their callers, in probe.c and setup-res.c, respectively.

I've split this out into another patch set.
