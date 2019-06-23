Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:57041 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfFWAat (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 22 Jun 2019 20:30:49 -0400
Message-ID: <5f3dcc3a8dafad188e3adb8ee9cf347bebdee7f6.camel@kernel.crashing.org>
Subject: Archs using generic PCI controller drivers vs. resource policy
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sun, 23 Jun 2019 10:30:42 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org

Hi !

As part of my cleanup and consolidation of the PCI resource assignment
policies, I need to clarify something.

At the moment, unless PCI_PROBE_ONLY is set, a number of
platforms/archs expect Linux to reassign everything rather than honor
what has setup, then (re)assign what's left or broken. This is mostly
the case of embedded platforms. Things like x86 and desktop/server
powerpc will generally honor the firmware setup.

One problem is that this policy decision tend to be sprinkled in some
of the controller drivers themselves in drivers/pci/controller (or the
pci_host_probe helper).

This is wrong. I want to move it to the architecture (initially,
eventually it should be platform driven, but the default will start
with architecture specific to avoid changing the existing behaviours
while consolidating the code).

To do that right, I want to understand which archs can potentially use
the code in drivers/pci/controller today so I can change those archs to
explicitely set the default to "reassign everything" (and take the
policy out of the drivers themselves).

So far I've counted arm, arm64 (DT, not ACPI) and nios2. Any other ?

The remaining archs fall into two categories:

 - Those who have their own existing PCI management code and don't
use the generic controller drivers. I'm handling these already.

 - Those who don't seem to have anything to do with PCI (yet ?) or that
I've missed. Those will default to the x86 model (honor FW setup unless
it has conflicts or is broken, and (re)assign what's left) unless
explicitly changed.

Cheers,
Ben.
