Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S261740AbUKIWZ3@vger.kernel.org>
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:54616 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261732AbUKIWYk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 9 Nov 2004 17:24:40 -0500
From: Paolo Giarrusso <blaisorblade_personal@yahoo.it>
Subject: Re: last call for 4-level-pagetable patches
Date: Tue, 9 Nov 2004 23:25:18 +0100
References: <20041109122919.49d8f2f5.akpm@osdl.org>
In-Reply-To: <20041109122919.49d8f2f5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411092325.18790.blaisorblade_personal@yahoo.it>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org, Jeff Dike <jdike@addtoit.com>
List-ID: <linux-arch.vger.kernel.org>

On Tuesday 09 November 2004 21:29, Andrew Morton wrote:
> I'd like to merge these up in the next few days.

> UML might need some work?
Not "some work", but a lot of that. UML is currently two levels. There is a 
patch from Jeff to make it three-levels, but I want it very mainline 
reviewed.

The ghash replacing had at least two trivial type errors, which become 
warnings.

Yes, that code is a yet unused hook, in the very moment, so it's not critical 
stuff (in fact even before noticing that, UML got 0 stability problem from 
the patch) but getting things reviewed by VM hackers would be nice.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
