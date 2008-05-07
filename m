From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: RE: [microblaze-uclinux] [PATCH 04/56] microblaze_v2: Open firmware files
Date: Wed, 7 May 2008 09:04:09 -0700
Message-ID: <20080507160432.93FC11750046@mail35-dub.bigfish.com>
References: <a4a778e34c66d126f5c4bf1ca423cf32950ea5ab.1209897266.git.monstr@monstr.eu> <684c36e5ad3f598e5079e88ec195545c4a7150c2.1209897266.git.monstr@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from outbound-dub.frontbridge.com ([213.199.154.16]:13684 "EHLO
	outbound3-dub-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758174AbYEGQEe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 7 May 2008 12:04:34 -0400
Content-class: urn:content-classes:message
In-reply-to: <684c36e5ad3f598e5079e88ec195545c4a7150c2.1209897266.git.monstr@monstr.eu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: microblaze-uclinux@itee.uq.edu.au, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, John Linn <linnj@xilinx.com>, john.williams@petalogix.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, grant.likely@secretlab.ca, Michal Simek <monstr@monstr.eu>

> +#ifdef CONFIG_PPC_PSERIES
> +#include <asm/rtas.h>
> +#include <asm/kdump.h>
> +#include <asm/smp.h>
> +#include <asm/iommu.h>
> +#include <asm/btext.h>
> +#include <asm/machdep.h>
> +#include <asm/pSeries_reconfig.h>
> +#include <asm/phyp_dump.h>
> +#include <asm/kexec.h>
> +#endif

I don't think we need CONFIG_PPC_PSERIES (multiple times)

> +#ifdef CONFIG_PPC64
> +int __initdata iommu_is_off;
> +int __initdata iommu_force_on;
> +unsigned long tce_alloc_start, tce_alloc_end;
> +#endif

or PPC64 (multiple times

> +#ifdef CONFIG_PPC32

or PPC32

Steve
