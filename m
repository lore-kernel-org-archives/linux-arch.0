From: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH v2 00/24] C6X: New architecture patch set
Date: Thu, 25 Aug 2011 13:34:04 -0400
Message-ID: <1314293645.2344.34.camel@deneb.redhat.com>
References: <1314043785-2880-1-git-send-email-msalter@redhat.com>
	 <1314284011.27911.29.camel@twins>
	 <1314288020.2344.30.camel@deneb.redhat.com>
	 <1314293250.27911.36.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39929 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752386Ab1HYReK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 25 Aug 2011 13:34:10 -0400
In-Reply-To: <1314293250.27911.36.camel@twins>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org

On Thu, 2011-08-25 at 19:27 +0200, Peter Zijlstra wrote:
> On Thu, 2011-08-25 at 12:00 -0400, Mark Salter wrote:
> > On Thu, 2011-08-25 at 16:53 +0200, Peter Zijlstra wrote:
> > > It would be ever so nice to also point us to a binutils/gcc
> > > source/patch
> > > so that we can actually compile this muck.
> > 
> > Sorry. I did so in the earlier patch series.
> > 
> >   http://www.codesourcery.com/sgpp/lite/c6000/portal/release1882
> 
> OK, so is all that properly merged in upstream binutils/gcc ? 

Mostly, I think. There is enough in place to make a toolchain to
build kernels. We have seen some issues when using the latest
devel head tools, but I'm not sure if that is the c6x bits or just
the usual devel breakage. In any case, folks are working on it.

--Mark
