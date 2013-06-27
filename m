From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] arch: frv: mb93090-mb00: remove '__init' for pci_fixup_umc_ide()
 which used by 'DECLARE_PCI_FIXUP_HEADER'
Date: Thu, 27 Jun 2013 08:21:54 +0800
Message-ID: <51CB85A2.9040207@asianux.com>
References: <51CA5829.9060807@asianux.com> <CAErSpo4dg7cVN1grEuKWvDJkZoJPAaELeh8knqD=s-nd5dsBNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:39778 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513Ab3F0AWs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 26 Jun 2013 20:22:48 -0400
In-Reply-To: <CAErSpo4dg7cVN1grEuKWvDJkZoJPAaELeh8knqD=s-nd5dsBNw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "dhowells@redhat.com" <dhowells@redhat.com>, Greg KH <gregkh@linuxfoundation.org>, Yinghai Lu <yinghai@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

On 06/27/2013 12:19 AM, Bjorn Helgaas wrote:
> On Tue, Jun 25, 2013 at 8:55 PM, Chen Gang <gang.chen@asianux.com> wrote:
>> > pci_fixup_umc_ide() is for 'DECLARE_PCI_FIXUP_HEADER', so need remove
>> > it from init section to normal section.
>> >
>> > The related warning (with allmodconfig):
>> >
>> >   LD      arch/frv/mb93090-mb00/built-in.o
>> > WARNING: arch/frv/mb93090-mb00/built-in.o(.pci_fixup_header+0x4c): Section mismatch in reference from the variable __pci_fixup_PCI_VENDOR_ID_UMCPCI_DEVICE_ID_UMC_UM8886BFpci_fixup_umc_ide to the function .init.text:pci_fixup_umc_ide()
>> > The variable __pci_fixup_PCI_VENDOR_ID_UMCPCI_DEVICE_ID_UMC_UM8886BFpci_fixup_umc_ide references
>> > a function __init pci_fixup_umc_ide().
>> > This is often seen when error handling in the init function
>> > uses functionality in the exit path.
>> > The fix is often to remove the __init annotation of
>> > pci_fixup_umc_ide() so it may be used outside an exit section.
>> >
>> >
>> > Signed-off-by: Chen Gang <gang.chen@asianux.com>
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> 

Thanks.

-- 
Chen Gang

Asianux Corporation
