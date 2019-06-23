Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:48706 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbfFXCCC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 23 Jun 2019 22:02:02 -0400
Message-ID: <c82439de338dfd26266305013cd4ebbb8fd30834.camel@kernel.crashing.org>
Subject: Re: Archs using generic PCI controller drivers vs. resource policy
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 24 Jun 2019 09:49:04 +1000
In-Reply-To: <5f3dcc3a8dafad188e3adb8ee9cf347bebdee7f6.camel@kernel.crashing.org>
References: <5f3dcc3a8dafad188e3adb8ee9cf347bebdee7f6.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org

On Sun, 2019-06-23 at 10:30 +1000, Benjamin Herrenschmidt wrote:
> 
> So far I've counted arm, arm64 (DT, not ACPI) and nios2. Any other ?

Hrm... nios2 doesn't do PCI despite what the Kconfig entry for
PCIE_ALTERA might want to let you believe.

So, anybody other than arm and arm64 using host bridge drivers in
drivers/pci/controller ?

Cheers,
Ben.
