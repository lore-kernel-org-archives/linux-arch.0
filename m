From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 00/24] C6X: New architecture patch set
Date: Thu, 25 Aug 2011 19:36:47 +0200
Message-ID: <1314293807.27911.41.camel@twins>
References: <1314043785-2880-1-git-send-email-msalter@redhat.com>
	 <1314284011.27911.29.camel@twins>
	 <1314288020.2344.30.camel@deneb.redhat.com>
	 <1314293250.27911.36.camel@twins>
	 <1314293645.2344.34.camel@deneb.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:47290 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754947Ab1HYRg5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 25 Aug 2011 13:36:57 -0400
In-Reply-To: <1314293645.2344.34.camel@deneb.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-arch@vger.kernel.org

On Thu, 2011-08-25 at 13:34 -0400, Mark Salter wrote:
> On Thu, 2011-08-25 at 19:27 +0200, Peter Zijlstra wrote:
> > On Thu, 2011-08-25 at 12:00 -0400, Mark Salter wrote:
> > > On Thu, 2011-08-25 at 16:53 +0200, Peter Zijlstra wrote:
> > > > It would be ever so nice to also point us to a binutils/gcc
> > > > source/patch
> > > > so that we can actually compile this muck.
> > > 
> > > Sorry. I did so in the earlier patch series.
> > > 
> > >   http://www.codesourcery.com/sgpp/lite/c6000/portal/release1882
> > 
> > OK, so is all that properly merged in upstream binutils/gcc ? 
> 
> Mostly, I think. There is enough in place to make a toolchain to
> build kernels. We have seen some issues when using the latest
> devel head tools, but I'm not sure if that is the c6x bits or just
> the usual devel breakage. In any case, folks are working on it.

Goodness ;-)

The sad fact is that binutils/gcc releases simply don't build for most
linux kernel archs and non releases tend not to build much at all.
Nobody in those projects seems to think at least (cross) compiling all
supported targets is a release criteria or so.
