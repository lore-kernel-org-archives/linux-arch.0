From: Toshi Kani <toshi.kani@hpe.com>
Subject: Re: [PATCH 01/11] resource: Add System RAM resource type
Date: Wed, 23 Dec 2015 19:23:35 -0700
Message-ID: <1450923815.19330.4.camel@hpe.com>
References: <20151216122642.GE29775@pd.tnic>
	 <1450280642.29051.76.camel@hpe.com> <20151216154916.GF29775@pd.tnic>
	 <1450283759.20148.11.camel@hpe.com> <20151216174523.GH29775@pd.tnic>
	 <CAPcyv4h+n51Z2hskP2+PX44OB47OQwrKcqVr3nrvMzG++qjC+w@mail.gmail.com>
	 <20151216181712.GJ29775@pd.tnic> <1450302758.20148.75.camel@hpe.com>
	 <20151222113422.GE3728@pd.tnic> <1450814672.10450.83.camel@hpe.com>
	 <20151223142349.GG30213@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g4t3428.houston.hp.com ([15.201.208.56]:50399 "EHLO
	g4t3428.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208AbbLXCX6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 23 Dec 2015 21:23:58 -0500
In-Reply-To: <20151223142349.GG30213@pd.tnic>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, Linux MM <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Wed, 2015-12-23 at 15:23 +0100, Borislav Petkov wrote:
> On Tue, Dec 22, 2015 at 01:04:32PM -0700, Toshi Kani wrote:
 :
> > I agree that we can add new interfaces with the type check.  This
> > 'type'
> > may need some clarification since it is an assigned type, which is
> > different from I/O resource type.  That is, "System RAM" is an I/O 
> > resource type (i.e. IORESOURCE_SYSTEM_RAM), but "Crash kernel" is an 
> > assigned type to a particular range of System RAM.  A range may be 
> > associated with multiple names, so as multiple assigned types.  For 
> > lack of a better idea, I may call it 'assign_type'.  I am open for a
> > better name.
> 
> Or assigned_type or named_type or so...
> 
> I think we should avoid calling it "type" completely in order to avoid
> confusion with the IORESOURCE_* types and call it "desc" or so to mean
> description, sort, etc, because the name is also a description of the
> resource to a certain degree...

Agreed. I will use 'desc'.

> > OK, I will try to convert the existing callers with the new interfaces.
> 
> Either that or add the new interfaces, use them in your use case, add
> big fat comments explaining that people should use those from now on
> when searching by name and add a check to checkpatch to catch future
> mis-uses...

Sounds good.  I will look into it.

Thanks,
-Toshi
