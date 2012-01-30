From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 10/13] PCI: Strict checking of valid range for bridge
Date: Mon, 30 Jan 2012 10:52:52 -0800
Message-ID: <CAE9FiQU64Ev66D+044m+ZLn+tWSVtnZWXnyaNjkaM+aQD_1CQw@mail.gmail.com>
References: <1327718971-9598-1-git-send-email-yinghai@kernel.org>
	<1327718971-9598-11-git-send-email-yinghai@kernel.org>
	<CAErSpo7RsR+2gDJvWic4ta-_SWfUwECaVxRrCVnTFZyFG5RCkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:63451 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890Ab2A3Swx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 30 Jan 2012 13:52:53 -0500
In-Reply-To: <CAErSpo7RsR+2gDJvWic4ta-_SWfUwECaVxRrCVnTFZyFG5RCkw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Mon, Jan 30, 2012 at 8:04 AM, Bjorn Helgaas <bhelgaas@google.com> wr=
ote:
> On Fri, Jan 27, 2012 at 6:49 PM, Yinghai Lu <yinghai@kernel.org> wrot=
e:
>> children bridges busn range should be able to be allocated from pare=
nt bus range.
>>
>> to avoid overlapping between sibling bridges on same bus.
>>
>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>> ---
>> =A0drivers/pci/probe.c | =A0 27 +++++++++++++++++++++++++++
>> =A01 files changed, 27 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 83df3fb..e12f65f0 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -791,6 +791,33 @@ reduce_needed_size:
>> =A0 =A0 =A0 =A0return ret;
>> =A0}
>>
>> +static int __devinit pci_bridge_check_busn_res(struct pci_bus *bus,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct=
 pci_dev *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int se=
condary, int subordinate)
>
> This function returns a boolean, but the function name doesn't give
> any clue about what a true/false return means. =A0Something like
> "busn_valid" would make the callers more readable.

ok

>
>> +{
>> + =A0 =A0 =A0 int broken =3D 0;
>> +
>> + =A0 =A0 =A0 struct resource busn_res;
>> + =A0 =A0 =A0 int ret;
>> +
>> + =A0 =A0 =A0 memset(&busn_res, 0, sizeof(struct resource));
>> + =A0 =A0 =A0 dev_printk(KERN_DEBUG, &dev->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"check if busn %02x-%02x is in busn=
_res: %06llx-%06llx\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0secondary, subordinate,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(unsigned long long)bus->busn_res.s=
tart,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(unsigned long long)bus->busn_res.e=
nd);
>> + =A0 =A0 =A0 ret =3D allocate_resource(&bus->busn_res, &busn_res,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(subordinate - seco=
ndary + 1),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(pci_domain_nr(bus)=
<<8) | secondary,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(pci_domain_nr(bus)=
<<8) | subordinate,
>
> I think this "(pci_domain_nr(bus)<<8) | secondary" stuff needs to be =
a
> macro or something.

maybe.
