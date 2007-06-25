Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:36960 "EHLO
	stout.engsoc.carleton.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226AbXFYBLj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 24 Jun 2007 21:11:39 -0400
Date: Sun, 24 Jun 2007 21:01:11 -0400
From: Kyle McMartin <kyle@parisc-linux.org>
Subject: Re: [PARISC] Handle wrapping in expand_upwards()
Message-ID: <20070625010111.GA27973@fattire.cabal.ca>
References: <20070621091104.GA10043@fattire.cabal.ca> <20070623095548.a7117833.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070623095548.a7117833.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kyle McMartin <kyle@parisc-linux.org>, linux-arch@vger.kernel.org, tony.luck@intel.com, torvalds@linux-foundation.org
List-ID: <linux-arch.vger.kernel.org>

On Sat, Jun 23, 2007 at 09:55:48AM -0700, Andrew Morton wrote:
> You did't really provide enough information for us to be able to decide
> whether this change is needed in 2.6.22, let alone 2.6.21.
> 
> I will magically infer from your To: line that you consider it 2.6.22
> material, but if so I think that we'll need suitable reviewing, testing and
> acking from Tony, please.  If he's offline (ols, perhaps?) then we might
> have a problem.  Perhaps find a suitable ia64-enabled alternate?
> 

Yes. It's not an issue on ia64 afaict since it isn't used for the
stack, just the register stack engine backing store.

On parisc, the symptom is basically that dereferencing 0xffffffff would
oops the kernel.

> 
> As for 2.6.21: I'll assume it's needed there as well.  Please advise if
> otherwise.
> 

I'm not horribly worried about parisc in 2.6-stable...

Cheers,
	Kyle M.
