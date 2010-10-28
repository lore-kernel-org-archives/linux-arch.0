From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH] parisc: fix compile failure with kmap_atomic changes
Date: Thu, 28 Oct 2010 12:39:40 -0500
Message-ID: <1288287580.3043.159.camel@mulgrave.site>
References: <20101028171302.5D8944CFC@hiauly1.hia.nrc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:34518 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760223Ab0J1Rjn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 28 Oct 2010 13:39:43 -0400
In-Reply-To: <20101028171302.5D8944CFC@hiauly1.hia.nrc.ca>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: John David Anglin <dave@hiauly1.hia.nrc.ca>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org, peterz@infradead.org

On Thu, 2010-10-28 at 13:13 -0400, John David Anglin wrote:
> > On Thu, 2010-10-28 at 01:18 -0400, John David Anglin wrote:
> > > Signed-off-by: John David Anglin  <dave.anglin@nrc-cnrc.gc.ca>
> > > 
> > > Sent effectively the same change to parisc-linux list months ago...
> > 
> > You did?  Why didn't you send it to Peter?  When I grumbled at him on
> > IRC for breaking parisc (as well as quite a few other 64 bit
> > architectures in mainline) he had no idea there was a problem.
> 
> For example, it is in the diff recently posted here:
> http://permalink.gmane.org/gmane.linux.ports.parisc/3173
> This diff is from last May.

Um, so that doesn't fix the compile failure.

The specific problem is that kmap_atomic no longer takes the index
argument because Peter moved it to a stack based implementation.  All
our kmap_atomic primitives in asm/cacheflush.h still have the extra
index argument which causes a compile failure.

To fix it, I had to run through a bunch of renames and extra argument
removals.

James
