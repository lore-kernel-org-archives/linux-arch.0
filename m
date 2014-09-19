Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:42655 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757804AbaISVDT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 19 Sep 2014 17:03:19 -0400
Received: by mail-pa0-f42.google.com with SMTP id et14so823991pad.15
        for <linux-arch@vger.kernel.org>; Fri, 19 Sep 2014 14:03:19 -0700 (PDT)
Date: Fri, 19 Sep 2014 15:03:13 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v11 07/10] OF: Introduce helper function for getting PCI
 domain_nr
Message-ID: <20140919210313.GH19374@google.com>
References: <1411003825-21521-1-git-send-email-Liviu.Dudau@arm.com>
 <1411003825-21521-8-git-send-email-Liviu.Dudau@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1411003825-21521-8-git-send-email-Liviu.Dudau@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>, Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Russell King <linux@arm.linux.org.uk>, linux-pci <linux-pci@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Tanmay Inamdar <tinamdar@apm.com>, Grant Likely <grant.likely@secretlab.ca>, Sinan Kaya <okaya@codeaurora.org>, Jingoo Han <jg1.han@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Suravee Suthikulanit <suravee.suthikulpanit@amd.com>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Device Tree ML <devicetree@vger.kernel.org>, LAKML <linux-arm-kernel@lists.infradead.org>, Grant Likely <grant.likely@linaro.org>
Message-ID: <20140919210313.6CmMJnw-hTog1vFBXDt0uAPyWBqFlW3skqjF3t8IqBo@z>

On Thu, Sep 18, 2014 at 02:30:22AM +0100, Liviu Dudau wrote:
> Add of_pci_get_domain_nr() to retrieve the PCI domain number
> of a given device from DT. If the information is not present,
> the function can be requested to allocate a new domain number.

Is of_pci_get_domain_nr() used somewhere?  If the use is in some future
series, please mention it explicitly.  I'm just trying to avoid merging
unused code.

Bjorn
