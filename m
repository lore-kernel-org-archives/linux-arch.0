Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:33624 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754987AbbLPS5x (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 16 Dec 2015 13:57:53 -0500
Received: by mail-qk0-f182.google.com with SMTP id k189so79669881qkc.0
        for <linux-arch@vger.kernel.org>; Wed, 16 Dec 2015 10:57:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20151216181712.GJ29775@pd.tnic>
References: <1450136246-17053-1-git-send-email-toshi.kani@hpe.com>
	<20151216122642.GE29775@pd.tnic>
	<1450280642.29051.76.camel@hpe.com>
	<20151216154916.GF29775@pd.tnic>
	<1450283759.20148.11.camel@hpe.com>
	<20151216174523.GH29775@pd.tnic>
	<CAPcyv4h+n51Z2hskP2+PX44OB47OQwrKcqVr3nrvMzG++qjC+w@mail.gmail.com>
	<20151216181712.GJ29775@pd.tnic>
Date: Wed, 16 Dec 2015 10:57:52 -0800
Message-ID: <CAPcyv4iw=ww3VwgG7XMO7oSX648W89q0czohLZPf=0pL_1p4Dw@mail.gmail.com>
Subject: Re: [PATCH 01/11] resource: Add System RAM resource type
From: Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Toshi Kani <toshi.kani@hpe.com>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, Linux MM <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Message-ID: <20151216185752.VcsP0XzAkkXrcWQZOuKaY_RxzBvguReUq0El0E6u1A4@z>

On Wed, Dec 16, 2015 at 10:17 AM, Borislav Petkov <bp@alien8.de> wrote:
> On Wed, Dec 16, 2015 at 09:52:37AM -0800, Dan Williams wrote:
[..]
> Now, imagine you have to do this pretty often. Which is faster: a
> strcmp() or an int comparison...?

Aside from "System RAM" checks I don't think any of these strcmp
usages are in fast paths.

> Even if this cannot be changed easily/in one go, maybe we should at
> least think about starting doing it right so that the strcmp() "fun" is
> phased out gradually...

Sure, but I really don't find use of strcmp() that onerous in slow paths.
