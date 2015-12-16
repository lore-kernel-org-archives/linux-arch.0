Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:33980 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934706AbbLPRwi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 16 Dec 2015 12:52:38 -0500
Received: by mail-qk0-f171.google.com with SMTP id p187so76238059qkd.1
        for <linux-arch@vger.kernel.org>; Wed, 16 Dec 2015 09:52:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20151216174523.GH29775@pd.tnic>
References: <1450136246-17053-1-git-send-email-toshi.kani@hpe.com>
	<20151216122642.GE29775@pd.tnic>
	<1450280642.29051.76.camel@hpe.com>
	<20151216154916.GF29775@pd.tnic>
	<1450283759.20148.11.camel@hpe.com>
	<20151216174523.GH29775@pd.tnic>
Date: Wed, 16 Dec 2015 09:52:37 -0800
Message-ID: <CAPcyv4h+n51Z2hskP2+PX44OB47OQwrKcqVr3nrvMzG++qjC+w@mail.gmail.com>
Subject: Re: [PATCH 01/11] resource: Add System RAM resource type
From: Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Toshi Kani <toshi.kani@hpe.com>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, Linux MM <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Message-ID: <20151216175237._uTD3S38WdgDVC-TxZU0ejGr7Q4IrMCFZWZ1DRI31c0@z>

On Wed, Dec 16, 2015 at 9:45 AM, Borislav Petkov <bp@alien8.de> wrote:
> On Wed, Dec 16, 2015 at 09:35:59AM -0700, Toshi Kani wrote:
>> We do not have enough bits left to cover any potential future use-cases
>> with other strings if we are going to get rid of strcmp() completely.
>
> Look at the examples I gave. I'm talking about having an additional
> identifier which can be a number and not a bit.
>
>>  Since the searches from crash and kexec are one-time thing, and einj
>> is a R&D tool, I think we can leave the strcmp() check for these
>> special cases, and keep the interface flexible with any strings.
>
> I don't think using strings is anywhere close to flexible. If at all, it
> is an odd use case which shouldnt've been allowed in in the first place.
>

It's possible that as far as the resource table is concerned the
resource type might just be "reserved".  It may not be until after a
driver loads that we discover the memory range type.  The identifying
string is driver specific at that point.

All this to say that with strcmp we can search for any custom type .
Otherwise I think we're looking at updating the request_region()
interface to take a type parameter.  That makes strcmp capability more
attractive compared to updating a potentially large number of
request_region() call sites.
