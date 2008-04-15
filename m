Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:47609 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982AbYDOQMM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 15 Apr 2008 12:12:12 -0400
Subject: Re: + kernel-add-common-infrastructure-for-unaligned-access.patch
	added to -mm tree
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1208272073.11920.74.camel@brick>
References: <200804142214.m3EMET5L029431@imap1.linux-foundation.org>
	 <1208261668.9212.18.camel@pmac.infradead.org>
	 <1208272073.11920.74.camel@brick>
Content-Type: text/plain
Date: Tue, 15 Apr 2008 17:12:07 +0100
Message-ID: <1208275927.9212.58.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: akpm@linux-foundation.org, mm-commits@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20080415161207.l_tFdqsPijIzH6OAbWnpq8gTk3MfK5Tuas8j5Mai64w@z>

On Tue, 2008-04-15 at 08:07 -0700, Harvey Harrison wrote:
> The reason I kept the byte-shifting versions around was that for
> arches that need special handling of unaligned access,

Are there any? GCC should emit appropriate code for the packed-structure
version on all architectures, shouldn't it?

> they could do the byteshifting manually and get the unaligned access
> 'for free' as it were. 

GCC really ought to be able to sort that out for itself. Let the dog see
the rabbit.

>  The packed struct implementation works fine for the same endianness,
> but I tried to make this as little of a change for each arch as a
> consolidation step...which is why I kept the
> memmove variant.  We can discuss moving arches over to other
> implementations after the fact.

TBH I'd rather just provide the generic implementations (using packed
structs) then convert the arches to them one at a time.

-- 
dwmw2

