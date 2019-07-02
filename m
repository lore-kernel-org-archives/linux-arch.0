Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44245 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfGBNYa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Jul 2019 09:24:30 -0400
From: Greg Ungerer <gregungerer00@gmail.com>
Subject: Re: Archs using generic PCI controller drivers vs. resource policy
References: <5f3dcc3a8dafad188e3adb8ee9cf347bebdee7f6.camel@kernel.crashing.org>
Message-ID: <bafcb3eb-2bf0-2ea7-00e4-50e729406978@linux-m68k.org>
Date: Tue, 2 Jul 2019 23:24:24 +1000
MIME-Version: 1.0
In-Reply-To: <5f3dcc3a8dafad188e3adb8ee9cf347bebdee7f6.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org

Hi Ben,

On 23/6/19 10:30 am, Benjamin Herrenschmidt wrote:
> As part of my cleanup and consolidation of the PCI resource assignment
> policies, I need to clarify something.
> 
> At the moment, unless PCI_PROBE_ONLY is set, a number of
> platforms/archs expect Linux to reassign everything rather than honor
> what has setup, then (re)assign what's left or broken. This is mostly
> the case of embedded platforms. Things like x86 and desktop/server
> powerpc will generally honor the firmware setup.
> 
> One problem is that this policy decision tend to be sprinkled in some
> of the controller drivers themselves in drivers/pci/controller (or the
> pci_host_probe helper).
> 
> This is wrong. I want to move it to the architecture (initially,
> eventually it should be platform driven, but the default will start
> with architecture specific to avoid changing the existing behaviours
> while consolidating the code).
> 
> To do that right, I want to understand which archs can potentially use
> the code in drivers/pci/controller today so I can change those archs to
> explicitely set the default to "reassign everything" (and take the
> policy out of the drivers themselves).
> 
> So far I've counted arm, arm64 (DT, not ACPI) and nios2. Any other ?

For the m68k platforms which support PCI (which is only some of
the more modern ColdFire variants) they expect PCI resources to
be assigned by Linux. There is no boot firmware that will do that
before kernel startup.

The PCI root driver complex is already in the arch area though
(arch/m68k/coldfire/pci.c) so that is essentially what you
want to achieve right?

Regards
Greg


> The remaining archs fall into two categories:
> 
>   - Those who have their own existing PCI management code and don't
> use the generic controller drivers. I'm handling these already.
> 
>   - Those who don't seem to have anything to do with PCI (yet ?) or that
> I've missed. Those will default to the x86 model (honor FW setup unless
> it has conflicts or is broken, and (re)assign what's left) unless
> explicitly changed.
> 
> Cheers,
> Ben.
> 
> 
> 
