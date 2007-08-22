Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from waste.org ([66.93.16.53]:38346 "EHLO waste.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932293AbXHVXss (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 22 Aug 2007 19:48:48 -0400
Date: Wed, 22 Aug 2007 18:50:11 -0500
From: Matt Mackall <mpm@selenic.com>
Subject: Re: [RFC][PATCH] introduce TASK_SIZE_OF() for all arches
Message-ID: <20070822235011.GP30556@waste.org>
References: <20070821193835.258D7DD4@kernel> <31048.1187773615@redhat.com> <1187823350.16177.1326.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1187823350.16177.1326.camel@localhost>
Sender: linux-arch-owner@vger.kernel.org
To: Dave Hansen <haveblue@us.ibm.com>
Cc: David Howells <dhowells@redhat.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, Aug 22, 2007 at 03:55:50PM -0700, Dave Hansen wrote:
> On Wed, 2007-08-22 at 10:06 +0100, David Howells wrote:
> > Dave Hansen <haveblue@us.ibm.com> wrote:
> > 
> > > For the /proc/<pid>/pagemap code[1], we need to able to query how
> > > much virtual address space a particular task has.
> > 
> > How does this relate to NOMMU conditions?
> 
> It probably doesn't make any sense to use the /proc/<pid>/pagemap
> feature on NOMMU systems.  There are no pagetables to dump, and no
> shared pages, right?

Nor is there any present/not present to report. VSS == RSS on NOMMU,
right?

So we could provide pagemap, but it's not clear it'd be very
interesting. kpagemap might be interesting, simply because of the
flags though.

-- 
Mathematics is the supreme nostalgia of our time.
