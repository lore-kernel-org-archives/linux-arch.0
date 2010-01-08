From: Andreas Mohr <andi@lisas.de>
Subject: Re: [PATCH 1/3] generic sys_old_select
Date: Fri, 8 Jan 2010 23:52:31 +0100
Message-ID: <20100108225231.GA11332@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:45377 "EHLO
	rhlx01.hs-esslingen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754259Ab0AHWwc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 8 Jan 2010 17:52:32 -0500
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Christoph Hellwig <hch@lst.de>, Al Viro <viro@ZenIV.linux.org.uk>, Matthew Wilcox <matthew@wil.cx>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux@arm.linux.org.uk, dhowells@redhat.com, ysato@users.sourceforge.jp, tony.luck@intel.com

> There is, however, a reason *not* to do it which should be carefully
> considered: by co-locating the compatibility version with the modern
> version, it gets access to static functions that are part of the
> implementation of the modern version.  If we move the compatibility
> versions out, it may entail having to export those statics.
> 
>         -hpa

Hmm, do I hear a reason to simply fully #include the (newly separated)
old-style .c file from within the new-style .c file?
Not necessarily a wonderful approach, but perhaps it beats doing a "correct
full separation" and thus having a couple new-born (and unhappy ;) exports
any day?

Andreas Mohr
