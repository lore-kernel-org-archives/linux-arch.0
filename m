Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g4t3425.houston.hp.com ([15.201.208.53]:53585 "EHLO
	g4t3425.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752371AbbLXVhX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 24 Dec 2015 16:37:23 -0500
Message-ID: <1450993020.19330.15.camel@hpe.com>
Subject: Re: [PATCH 01/11] resource: Add System RAM resource type
From: Toshi Kani <toshi.kani@hpe.com>
Date: Thu, 24 Dec 2015 14:37:00 -0700
In-Reply-To: <20151224195837.GE4128@pd.tnic>
References: <1450283759.20148.11.camel@hpe.com>
	 <20151216174523.GH29775@pd.tnic>
	 <CAPcyv4h+n51Z2hskP2+PX44OB47OQwrKcqVr3nrvMzG++qjC+w@mail.gmail.com>
	 <20151216181712.GJ29775@pd.tnic> <1450302758.20148.75.camel@hpe.com>
	 <20151222113422.GE3728@pd.tnic> <1450814672.10450.83.camel@hpe.com>
	 <20151223142349.GG30213@pd.tnic> <1450923815.19330.4.camel@hpe.com>
	 <1450976937.19330.11.camel@hpe.com> <20151224195837.GE4128@pd.tnic>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, Linux MM <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Message-ID: <20151224213700.OImhg1KonlQN_0hXnCDE7S-ucGzu7Fe-23jSO5hgJLQ@z>

On Thu, 2015-12-24 at 20:58 +0100, Borislav Petkov wrote:
> On Thu, Dec 24, 2015 at 10:08:57AM -0700, Toshi Kani wrote:
> > As for checkpatch, I noticed that commit 9c0ece069b3 removed "feature
> > -removal.txt" file, and checkpatch removed this check in commit
> > 78e3f1f01d2.  checkpatch does not have such check since then.  So, I am
> > inclined not to add this check back to checkpatch.
> 
> I didn't mean that.
> 
> Rather, something along the lines of, for example,
> the DEFINE_PCI_DEVICE_TABLE matching but match those
> resource matching functions using the strings, i.e.,
> "(walk_iomem_res|find_next_iomem_res|region_intersects)" or so and
> warn when new code uses them and that it should rather use the new
> desc-matching variants.

OK, I will add a check to walk_iomem_res().  I will remove @name from
region_intersects(), and find_next_iomem_res() is an internal function.

Thanks,
-Toshi
