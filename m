From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/4] bug: completely remove code of disabled VM_BUG_ON()
Date: Fri, 27 Apr 2012 00:07:47 -0700
Message-ID: <20120427000747.f1eddcca.akpm@linux-foundation.org>
References: <20120425112623.26927.43229.stgit@zurg>
	<20120425112629.26927.21609.stgit@zurg>
	<CAMuHMdW7eQh8eaNZrwRHqduPYCjNXv+LriZoH6-ERdkHH2qL8g@mail.gmail.com>
	<20120426153241.6d4762a2.akpm@linux-foundation.org>
	<CAMuHMdXzLaPoGinwG9EAL5VYAbMdmx+U5m1Fg+53DAQgdi1hxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:48470 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864Ab2D0HF5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 27 Apr 2012 03:05:57 -0400
In-Reply-To: <CAMuHMdXzLaPoGinwG9EAL5VYAbMdmx+U5m1Fg+53DAQgdi1hxg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Konstantin Khlebnikov <khlebnikov@openvz.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Fri, 27 Apr 2012 07:17:50 +0200 Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> On Fri, Apr 27, 2012 at 00:32, Andrew Morton <akpm@linux-foundation.org> wrote:
> > On Wed, 25 Apr 2012 16:40:32 +0200
> > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> >> On Wed, Apr 25, 2012 at 13:26, Konstantin Khlebnikov
> >> <khlebnikov@openvz.org> wrote:
> >> > Even if CONFIG_DEBUG_VM=n gcc genereates code for some VM_BUG_ON()
> >>
> >> That's because of the side effects of the expression
> >>
> >> https://lkml.org/lkml/2012/4/25/146
> >>
> >> But IRIC, we do want them here?
> >>
> >
> > AFAICT (lkml.org appears to be having a meltdown), you've gone and
> > linked to this very thread.
> >
> > Please try again, this time avoiding hyperlinks ;)
> 
> Yeah, I noticed after the fact. I wanted to look up the definition of
> unused_expression(), which obviously wasn't in my tree yet ;-)
> 
> Still, I think people started relyong on the side effects, didn't they?

I hope not.  If they are, they snuck it past me cleverly!  A quick grep
of mm/*.c looks clean.
