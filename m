From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v9 11/12] arm64: Add pgprot_device() interface for device
 mappings.
Date: Wed, 13 Aug 2014 10:59:45 +0100
Message-ID: <20140813095944.GB18495@arm.com>
References: <1407860725-25202-1-git-send-email-Liviu.Dudau@arm.com>
 <1407860725-25202-12-git-send-email-Liviu.Dudau@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1407860725-25202-12-git-send-email-Liviu.Dudau@arm.com>
Sender: linux-pci-owner@vger.kernel.org
To: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Will Deacon <Will.Deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@arm.linux.org.uk>, Tanmay Inamdar <tinamdar@apm.com>, Grant Likely <grant.likely@secretlab.ca>, Sinan Kaya <okaya@codeaurora.org>, Jingoo Han <jg1.han@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Suravee Suthikulanit <suravee.suthikulpanit@amd.com>, linux-pci <linux-pci@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Device Tree ML <devicetree@vger.kernel.org>, LAKML <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Aug 12, 2014 at 05:25:24PM +0100, Liviu Dudau wrote:
> Add pgprot_device(). It will be aliased to pgprot_noncached for
> architectures that do not support special attributes for device
> mapping. Used by arm64 to define new attributes for devices.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
