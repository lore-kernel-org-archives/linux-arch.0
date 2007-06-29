Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:45366 "EHLO
	stout.engsoc.carleton.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754608AbXF2Sb4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jun 2007 14:31:56 -0400
Date: Fri, 29 Jun 2007 10:48:20 -0400
From: Kyle McMartin <kyle@parisc-linux.org>
Subject: Re: [PARISC] Handle wrapping in expand_upwards()
Message-ID: <20070629144820.GE9495@fattire.cabal.ca>
References: <20070623095548.a7117833.akpm@linux-foundation.org> <617E1C2C70743745A92448908E030B2A01C206AB@scsmsx411.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <617E1C2C70743745A92448908E030B2A01C206AB@scsmsx411.amr.corp.intel.com>
Sender: linux-arch-owner@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kyle McMartin <kyle@parisc-linux.org>, linux-arch@vger.kernel.org, torvalds@linux-foundation.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, Jun 25, 2007 at 02:36:04PM -0700, Luck, Tony wrote:
> > I will magically infer from your To: line that you consider it 2.6.22
> > material, but if so I think that we'll need suitable reviewing, testing and
> > acking from Tony, please.  If he's offline (ols, perhaps?) then we might
> > have a problem.  Perhaps find a suitable ia64-enabled alternate?
> 
> Wrap-around to zero for the ia64 RSE stack isn't possible (it must be
> in a user region (0-4), so it is far, far away from the top of the
> address space.
> 

Thanks, this is what I had suspected from reading the code.

Cheers,
	Kyle M.

> -Tony
> -
> To unsubscribe from this list: send the line "unsubscribe linux-arch" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
