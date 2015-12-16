From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 01/11] resource: Add System RAM resource type
Date: Wed, 16 Dec 2015 16:49:16 +0100
Message-ID: <20151216154916.GF29775@pd.tnic>
References: <1450136246-17053-1-git-send-email-toshi.kani@hpe.com>
 <20151216122642.GE29775@pd.tnic>
 <1450280642.29051.76.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:51255 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934012AbbLPPtZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 16 Dec 2015 10:49:25 -0500
Content-Disposition: inline
In-Reply-To: <1450280642.29051.76.camel@hpe.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Toshi Kani <toshi.kani@hpe.com>
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dan Williams <dan.j.williams@intel.com>

On Wed, Dec 16, 2015 at 08:44:02AM -0700, Toshi Kani wrote:
> Besides "System RAM", which is commonly searched by multiple callers, we
> only have a few other uncommon cases:
>  - crash.c searches for "GART", "ACPI Tables", and "ACPI Non-volatile
> Storage".
>  - kexec_file.c searches for "Crash kernel".
>  - einj.c will search for "Persistent Memory".

Right, about those other types: your patchset improves the situation
but doesn't really get rid of the strcmp() and the strings. And using
strings to find resource types still looks yucky to me, even a week
later. :)

So how hard is it to do:

	region_intersects(base_addr, size, IORESOURCE_SYSTEM_RAM);
	region_intersects(base_addr, size, IORESOURCE_MEM, RES_TYPE_PERSISTENT);
	walk_iomem_res(RES_TYPE_GART, IORESOURCE_MEM, 0, -1, ced, get_gart_ranges_callback);
	...

and so on instead of using those silly strings?

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
