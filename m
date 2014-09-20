From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v11 07/10] OF: Introduce helper function for getting PCI domain_nr
Date: Sat, 20 Sep 2014 04:24:20 +0200
Message-ID: <201409200424.20538.arnd@arndb.de>
References: <1411003825-21521-1-git-send-email-Liviu.Dudau@arm.com> <1411003825-21521-8-git-send-email-Liviu.Dudau@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1411003825-21521-8-git-send-email-Liviu.Dudau@arm.com>
Sender: linux-pci-owner@vger.kernel.org
To: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>, Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Russell King <linux@arm.linux.org.uk>, linux-pci <linux-pci@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Tanmay Inamdar <tinamdar@apm.com>, Grant Likely <grant.likely@secretlab.ca>, Sinan Kaya <okaya@codeaurora.org>, Jingoo Han <jg1.han@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Suravee Suthikulanit <suravee.suthikulpanit@amd.com>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Device Tree ML <devicetree@vger.kernel.org>, LAKML <linux-arm-kernel@lists.infradead.org>, Grant Likely <grant.likely@linaro.org>
List-Id: linux-arch.vger.kernel.org

On Thursday 18 September 2014, Liviu Dudau wrote:
> 
> Add of_pci_get_domain_nr() to retrieve the PCI domain number
> of a given device from DT. If the information is not present,
> the function can be requested to allocate a new domain number.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>

This is more elaborate than I remember it, and while the simpler
version (which potentially resulted in a conflict for inconsistent
DTs) was fine, this one also seems ok.

Acked-by: Arnd Bergmann <arnd@arndb.de>
