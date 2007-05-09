Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:41481 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751581AbXEINhd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 9 May 2007 09:37:33 -0400
From: Andi Kleen <ak@suse.de>
Subject: Re: New slab allocator SLUB
Date: Wed, 9 May 2007 15:36:20 +0200
References: <Pine.LNX.4.64.0705081145360.11368@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0705081145360.11368@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200705091536.21526.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-arch@vger.kernel.org, akpm@linux-foundation.org
List-ID: <linux-arch.vger.kernel.org>


>
> i386:
>  Uses slab for pgd handling and modifies the page structs of those
>  Fix has been in Andrew's tree for awhile now.

Should be already upstream.


> I would expect that the experimental status of SLUB will be removed
> soon. SLUB then become the default slab allocator. It may not be the
> default when we release 2.6.22 but it is scheduled to be the default for
> 2.6.23.

Assuming you fix the performance regressions first?

-Andi
