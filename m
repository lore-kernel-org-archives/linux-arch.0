Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:42837 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754956AbbLPSRV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 16 Dec 2015 13:17:21 -0500
Date: Wed, 16 Dec 2015 19:17:12 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 01/11] resource: Add System RAM resource type
Message-ID: <20151216181712.GJ29775@pd.tnic>
References: <1450136246-17053-1-git-send-email-toshi.kani@hpe.com>
 <20151216122642.GE29775@pd.tnic>
 <1450280642.29051.76.camel@hpe.com>
 <20151216154916.GF29775@pd.tnic>
 <1450283759.20148.11.camel@hpe.com>
 <20151216174523.GH29775@pd.tnic>
 <CAPcyv4h+n51Z2hskP2+PX44OB47OQwrKcqVr3nrvMzG++qjC+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPcyv4h+n51Z2hskP2+PX44OB47OQwrKcqVr3nrvMzG++qjC+w@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Toshi Kani <toshi.kani@hpe.com>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, Linux MM <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Message-ID: <20151216181712.wb86g5MJXumONs7gIUDyu-Hn9GGympFbGrlCKsG3lr4@z>

On Wed, Dec 16, 2015 at 09:52:37AM -0800, Dan Williams wrote:
> It's possible that as far as the resource table is concerned the
> resource type might just be "reserved".  It may not be until after a
> driver loads that we discover the memory range type.  The identifying
> string is driver specific at that point.

So how many types are we talking about here? Because I don't find a whole lot:

$ git grep -E "(walk_iomem_res|find_next_iomem_res|region_intersects)" -- *.c | grep -Eo '\".*\"'
"GART"
"ACPI Tables"
"ACPI Non-volatile Storage"
"Crash kernel"
"System RAM"
"System RAM"
"System RAM"

An int type could contain 2^32 different types.

> All this to say that with strcmp we can search for any custom type .
> Otherwise I think we're looking at updating the request_region()
> interface to take a type parameter.  That makes strcmp capability more
> attractive compared to updating a potentially large number of
> request_region() call sites.

Right, but I don't think that @name param to request_region() was ever
meant to be mis-used as a matching attribute when iterating over the
resource types.

Now, imagine you have to do this pretty often. Which is faster: a
strcmp() or an int comparison...?

Even if this cannot be changed easily/in one go, maybe we should at
least think about starting doing it right so that the strcmp() "fun" is
phased out gradually...

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
