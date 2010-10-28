Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:48802 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933088Ab0J1O0g (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 28 Oct 2010 10:26:36 -0400
Subject: Re: [PATCH] parisc: fix compile failure with kmap_atomic changes
From: James Bottomley <James.Bottomley@HansenPartnership.com>
In-Reply-To: <20101028141616.GY8332@bombadil.infradead.org>
References: <1288204547.6886.23.camel@mulgrave.site>
	 <20101028141616.GY8332@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 28 Oct 2010 09:26:32 -0500
Message-ID: <1288275993.3043.3.camel@mulgrave.site>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kyle McMartin <kyle@mcmartin.ca>
Cc: linux-mm <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>
Message-ID: <20101028142632.ZWJ5CxZKvinJQViI8na-TPzi6S3Bxj-3okqpqRxTuYk@z>

On Thu, 2010-10-28 at 10:16 -0400, Kyle McMartin wrote:
> On Wed, Oct 27, 2010 at 01:35:47PM -0500, James Bottomley wrote:
> > Author: Peter Zijlstra <a.p.zijlstra@chello.nl>
> > Date:   Tue Oct 26 14:21:51 2010 -0700
> > 
> >     mm: stack based kmap_atomic()
> > 
> > overlooked the fact that parisc uses kmap as a coherence mechanism, so
> > even though we have no highmem, we do need to supply our own versions of
> > kmap (and atomic).  This patch converts the parisc kmap to the form
> > which is needed to keep it compiling (it's a simple prototype and name
> > change).
> > 
> > Signed-off-by: James Bottomley <James.Bottomley@suse.de>
> 
> Signed-off-by: Kyle McMartin <kyle@redhat.com>
> 
> Care to send it straight to Linus? I didn't want to rebase my tree to
> pull in the fix and risk his wrath...

Sure ... I was hoping Peter would ... as part of some fairly extensive
fixes for this code, but apparently he's unavailable while flying to the
US today.  By the way, it would be Acked-by: you if I do, since the
patch didn't pass through your hands.

James


