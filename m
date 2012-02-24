From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 11/12] unicore32/PCI: use pci_flags PCI_PROBE_ONLY
 instead of arm-specific flag
Date: Fri, 24 Feb 2012 15:20:14 -0700
Message-ID: <CAErSpo6wf5y1E0XPPTPSbkqW4Jjsg3sdkDNbEG6S+=c2NBgL5g@mail.gmail.com>
References: <20120223194209.20708.54480.stgit@bhelgaas.mtv.corp.google.com>
 <20120223194358.20708.90268.stgit@bhelgaas.mtv.corp.google.com> <1330064364.12600.3.camel@epip-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:42731 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754817Ab2BXWUf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 24 Feb 2012 17:20:35 -0500
Received: by wibhm11 with SMTP id hm11so259986wib.19
        for <linux-arch@vger.kernel.org>; Fri, 24 Feb 2012 14:20:34 -0800 (PST)
In-Reply-To: <1330064364.12600.3.camel@epip-laptop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: gxt@mprc.pku.edu.cn
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org

On Thu, Feb 23, 2012 at 10:19 PM, Guan Xuetao <gxt@mprc.pku.edu.cn> wro=
te:
> On Thu, 2012-02-23 at 12:43 -0700, Bjorn Helgaas wrote:
>> CC: Guan Xuetao <gxt@mprc.pku.edu.cn>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> ---
>> =A0arch/unicore32/kernel/pci.c | =A0 =A06 +++---
>> =A01 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/unicore32/kernel/pci.c b/arch/unicore32/kernel/pci=
=2Ec
>> index a8f07fe..6c1248f 100644
>> --- a/arch/unicore32/kernel/pci.c
>> +++ b/arch/unicore32/kernel/pci.c
>> @@ -19,9 +19,9 @@
>> =A0#include <linux/slab.h>
>> =A0#include <linux/init.h>
>> =A0#include <linux/io.h>
>> +#include <asm-generic/pci-bridge.h>
> I recommend that asm-generic/pci-bridge.h should be inserted into
> asm/pci.h file.

Yes, you're right.  I goofed on that.  If/when I update the series,
I'll include that change.

I don't think anything will break the way it is, because the only user
of pci-bridge.h stuff is pci.c, but all the other arches include it in
asm/pci.h, so it makes sense to do it that way in unicore32 as well.

Bjorn

>>
>> =A0static int debug_pci;
>> -static int use_firmware;
>>
>> =A0#define CONFIG_CMD(bus, devfn, where) =A0 =A0 =A0 =A0\
>> =A0 =A0 =A0 (0x80000000 | (bus->number << 16) | (devfn << 8) | (wher=
e & ~3))
>> @@ -276,7 +276,7 @@ static int __init pci_common_init(void)
>>
>> =A0 =A0 =A0 pci_fixup_irqs(pci_common_swizzle, pci_puv3_map_irq);
>>
>> - =A0 =A0 if (!use_firmware) {
>> + =A0 =A0 if (!pci_has_flag(PCI_PROBE_ONLY)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Size the bridge windows.
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> @@ -303,7 +303,7 @@ char * __devinit pcibios_setup(char *str)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 debug_pci =3D 1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> =A0 =A0 =A0 } else if (!strcmp(str, "firmware")) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 use_firmware =3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 pci_add_flags(PCI_PROBE_ONLY);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> =A0 =A0 =A0 }
>> =A0 =A0 =A0 return str;
>
>
