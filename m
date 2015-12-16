From: Toshi Kani <toshi.kani@hpe.com>
Subject: Re: [PATCH 01/11] resource: Add System RAM resource type
Date: Wed, 16 Dec 2015 09:35:59 -0700
Message-ID: <1450283759.20148.11.camel@hpe.com>
References: <1450136246-17053-1-git-send-email-toshi.kani@hpe.com>
	 <20151216122642.GE29775@pd.tnic> <1450280642.29051.76.camel@hpe.com>
	 <20151216154916.GF29775@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g4t3428.houston.hp.com ([15.201.208.56]:29689 "EHLO
	g4t3428.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933012AbbLPQgP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 16 Dec 2015 11:36:15 -0500
In-Reply-To: <20151216154916.GF29775@pd.tnic>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dan Williams <dan.j.williams@intel.com>

On Wed, 2015-12-16 at 16:49 +0100, Borislav Petkov wrote:
> On Wed, Dec 16, 2015 at 08:44:02AM -0700, Toshi Kani wrote:
> > Besides "System RAM", which is commonly searched by multiple callers,
> > we
> > only have a few other uncommon cases:
> >  - crash.c searches for "GART", "ACPI Tables", and "ACPI Non-volatile
> > Storage".
> >  - kexec_file.c searches for "Crash kernel".
> >  - einj.c will search for "Persistent Memory".
> 
> Right, about those other types: your patchset improves the situation
> but doesn't really get rid of the strcmp() and the strings. And using
> strings to find resource types still looks yucky to me, even a week
> later. :)
> 
> So how hard is it to do:
> 
> 	region_intersects(base_addr, size, IORESOURCE_SYSTEM_RAM);
> 	region_intersects(base_addr, size, IORESOURCE_MEM,
> RES_TYPE_PERSISTENT);
> 	walk_iomem_res(RES_TYPE_GART, IORESOURCE_MEM, 0, -1, ced,
> get_gart_ranges_callback);
> 	...
> 
> and so on instead of using those silly strings?

We do not have enough bits left to cover any potential future use-cases
with other strings if we are going to get rid of strcmp() completely. 
 Since the searches from crash and kexec are one-time thing, and einj is a
R&D tool, I think we can leave the strcmp() check for these special cases,
and keep the interface flexible with any strings.

Thanks,
-Toshi
