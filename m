Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S261749AbUKIWpM@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:11199 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261747AbUKIWnW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Nov 2004 17:43:22 -0500
Date: Tue, 9 Nov 2004 14:42:24 -0800
From: Andrew Morton <akpm@osdl.org>
Subject: Re: last call for 4-level-pagetable patches
Message-Id: <20041109144224.4a036c96.akpm@osdl.org>
In-Reply-To: <200411092325.18790.blaisorblade_personal@yahoo.it>
References: <20041109122919.49d8f2f5.akpm@osdl.org>
	<200411092325.18790.blaisorblade_personal@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Paolo Giarrusso <blaisorblade_personal@yahoo.it>
Cc: linux-arch@vger.kernel.org, jdike@addtoit.com
List-ID: <linux-arch.vger.kernel.org>

Paolo Giarrusso <blaisorblade_personal@yahoo.it> wrote:
>
> On Tuesday 09 November 2004 21:29, Andrew Morton wrote:
> > I'd like to merge these up in the next few days.
> 
> > UML might need some work?
> Not "some work", but a lot of that. UML is currently two levels. There is a 
> patch from Jeff to make it three-levels, but I want it very mainline 
> reviewed.

I don't fully understand.  Would a merge of the 4-level patches cause UML a
lot of problems?  Or are you confident that we can get things patched up
fairly promptly?  
