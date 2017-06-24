Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34266 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754920AbdFXCB7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Jun 2017 22:01:59 -0400
Received: by mail-pf0-f196.google.com with SMTP id d5so9747204pfe.1
        for <linux-arch@vger.kernel.org>; Fri, 23 Jun 2017 19:01:59 -0700 (PDT)
Date: Fri, 23 Jun 2017 19:01:58 -0700 (PDT)
From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 06/17] pci: Add generic pcibios_{fixup_bus,align_resource}
In-Reply-To: <CAK8P3a3FVKto9Kg8nfxizoKa+6kjYpT1JQrSASwAd1o5bBJBUw@mail.gmail.com>
Message-ID: <mhng-c35f78ff-19cf-4876-93ca-262e2f285f79@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: geert@linux-m68k.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>, albert@sifive.com, patches@groups.riscv.org, bhelgaas@google.com, linux-pci@vger.kernel.org
Message-ID: <20170624020158.FcrMi0XUxY4vlbcEQFWLZwGLV7Y5slamVXndRtH1x0s@z>

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
