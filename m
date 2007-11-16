Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:35745 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757369AbXKPXoU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 16 Nov 2007 18:44:20 -0500
Date: Fri, 16 Nov 2007 15:43:58 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: + aout-mark-arches-that-support-aout-format.patch added to -mm
 tree
Message-Id: <20071116154358.e57a36a8.akpm@linux-foundation.org>
In-Reply-To: <1195206038.23776.3.camel@localhost>
References: <200711152352.lAFNqkQp022343@imap1.linux-foundation.org>
	<1195206038.23776.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: schwidefsky@de.ibm.com
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, 16 Nov 2007 10:40:38 +0100
Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:

> On Thu, 2007-11-15 at 15:52 -0800, akpm@linux-foundation.org wrote:
> > The patch titled
> >      AOUT: Mark arches that support A.OUT format
> > has been added to the -mm tree.  Its filename is
> >      aout-mark-arches-that-support-aout-format.patch
> >
> > diff -puN arch/s390/Kconfig~aout-mark-arches-that-support-aout-format arch/s390/Kconfig
> > --- a/arch/s390/Kconfig~aout-mark-arches-that-support-aout-format
> > +++ a/arch/s390/Kconfig
> > @@ -47,6 +47,9 @@ config NO_IOMEM
> >  config NO_DMA
> >  	def_bool y
> > 
> > +config ARCH_SUPPORTS_AOUT
> > +	def_bool n
> > +
> >  mainmenu "Linux Kernel Configuration"
> > 
> >  config S390
> 
> There never has been an a.out binary on s390 and very probably there
> never will be ..
> 

well, it is set to `n'...

Which I guess has some commentary value, but as we normally make these
things opt-in-if-you-need-it I queued a patch to remove that hunk.
