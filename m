From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 12/24] PCI, ia64: Register busn_res for root buses
Date: Tue, 28 Feb 2012 20:26:48 -0800
Message-ID: <CAE9FiQXiCAxtNCafBtvx2Wj6=te5ciLjbC9icaPn788xQD06kQ@mail.gmail.com>
References: <1330466863-28469-1-git-send-email-yinghai@kernel.org>
	<1330466863-28469-13-git-send-email-yinghai@kernel.org>
	<CAErSpo66PD3+E3ZFqp73XHabL+8GavpX97pUkd28T6KWTBH-aA@mail.gmail.com>
	<CAE9FiQWBvYZO-D+Z2zwdd0a-bkatF-0YPtmxKP4Se75vccgPrA@mail.gmail.com>
	<CAErSpo5NOqnqWxCBV+NecA34z0YJHP7FCy6mNd5GUJ8q__CZHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:44469 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755095Ab2B2E0t convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 28 Feb 2012 23:26:49 -0500
In-Reply-To: <CAErSpo5NOqnqWxCBV+NecA34z0YJHP7FCy6mNd5GUJ8q__CZHw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, David Miller <davem@davemloft.net>, x86 <x86@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org

On Tue, Feb 28, 2012 at 4:22 PM, Bjorn Helgaas <bhelgaas@google.com> wr=
ote:
> On Tue, Feb 28, 2012 at 5:12 PM, Yinghai Lu <yinghai@kernel.org> wrot=
e:
>>>
>>> Why do you add a new struct resource here? =A0Can't you just use th=
e one
>>> passed in from acpi_pci_root_add()?
>>
>> not quite sure about the life cycle for that object.
>
> The struct acpi_pci_root is allocated in acpi_pci_root_add() and free=
d
> in acpi_pci_root_remove(), so it should be safe for PCI to use.

ok will change that for ia64.

>
> Same thing applies for x86, of course.

for x86, will have separate addon patch.

Thanks

      Yinghai
