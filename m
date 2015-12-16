From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 01/11] resource: Add System RAM resource type
Date: Wed, 16 Dec 2015 20:16:15 +0100
Message-ID: <20151216191614.GK29775@pd.tnic>
References: <1450136246-17053-1-git-send-email-toshi.kani@hpe.com>
 <20151216122642.GE29775@pd.tnic>
 <1450280642.29051.76.camel@hpe.com>
 <20151216154916.GF29775@pd.tnic>
 <1450283759.20148.11.camel@hpe.com>
 <20151216174523.GH29775@pd.tnic>
 <CAPcyv4h+n51Z2hskP2+PX44OB47OQwrKcqVr3nrvMzG++qjC+w@mail.gmail.com>
 <20151216181712.GJ29775@pd.tnic>
 <CAPcyv4iw=ww3VwgG7XMO7oSX648W89q0czohLZPf=0pL_1p4Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:44201 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752170AbbLPTQY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 16 Dec 2015 14:16:24 -0500
Content-Disposition: inline
In-Reply-To: <CAPcyv4iw=ww3VwgG7XMO7oSX648W89q0czohLZPf=0pL_1p4Dw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Toshi Kani <toshi.kani@hpe.com>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, Linux MM <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Wed, Dec 16, 2015 at 10:57:52AM -0800, Dan Williams wrote:
> Aside from "System RAM" checks I don't think any of these strcmp
> usages are in fast paths.

Sure, 0.1% slowdown here, 0.2% slowdown there... this is how you get a
bloated kernel.

In addition to that, using strings to identify resources is ugly. "It
was there so we used it" is not an excuse.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
