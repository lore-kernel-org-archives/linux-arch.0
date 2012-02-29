From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 12/24] PCI, ia64: Register busn_res for root buses
Date: Tue, 28 Feb 2012 17:22:46 -0700
Message-ID: <CAErSpo5NOqnqWxCBV+NecA34z0YJHP7FCy6mNd5GUJ8q__CZHw@mail.gmail.com>
References: <1330466863-28469-1-git-send-email-yinghai@kernel.org>
 <1330466863-28469-13-git-send-email-yinghai@kernel.org> <CAErSpo66PD3+E3ZFqp73XHabL+8GavpX97pUkd28T6KWTBH-aA@mail.gmail.com>
 <CAE9FiQWBvYZO-D+Z2zwdd0a-bkatF-0YPtmxKP4Se75vccgPrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:34603 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757111Ab2B2AXI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 28 Feb 2012 19:23:08 -0500
Received: by wibhm11 with SMTP id hm11so2351786wib.19
        for <linux-arch@vger.kernel.org>; Tue, 28 Feb 2012 16:23:07 -0800 (PST)
In-Reply-To: <CAE9FiQWBvYZO-D+Z2zwdd0a-bkatF-0YPtmxKP4Se75vccgPrA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, David Miller <davem@davemloft.net>, x86 <x86@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org

On Tue, Feb 28, 2012 at 5:12 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Tue, Feb 28, 2012 at 4:01 PM, Bjorn Helgaas <bhelgaas@google.com> =
wrote:
>> On Tue, Feb 28, 2012 at 3:07 PM, Yinghai Lu <yinghai@kernel.org> wro=
te:
>>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>>> Cc: Tony Luck <tony.luck@intel.com>
>>> Cc: Fenghua Yu <fenghua.yu@intel.com>
>>> Cc: linux-ia64@vger.kernel.org
>>> ---
>>> =A0arch/ia64/include/asm/pci.h | =A0 =A01 +
>>> =A0arch/ia64/pci/pci.c =A0 =A0 =A0 =A0 | =A0 =A05 +++++
>>> =A02 files changed, 6 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/ia64/include/asm/pci.h b/arch/ia64/include/asm/pc=
i.h
>>> index b22e5f5..6e54220 100644
>>> --- a/arch/ia64/include/asm/pci.h
>>> +++ b/arch/ia64/include/asm/pci.h
>>> @@ -94,6 +94,7 @@ struct pci_controller {
>>>
>>> =A0 =A0 =A0 =A0unsigned int windows;
>>> =A0 =A0 =A0 =A0struct pci_window *window;
>>> + =A0 =A0 =A0 struct resource busn;
>>
>> Why do you add a new struct resource here? =A0Can't you just use the=
 one
>> passed in from acpi_pci_root_add()?
>
> not quite sure about the life cycle for that object.

The struct acpi_pci_root is allocated in acpi_pci_root_add() and freed
in acpi_pci_root_remove(), so it should be safe for PCI to use.

Same thing applies for x86, of course.

Bjorn
