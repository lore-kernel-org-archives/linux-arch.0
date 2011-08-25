From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 00/24] C6X: New architecture patch set
Date: Thu, 25 Aug 2011 19:27:30 +0200
Message-ID: <1314293250.27911.36.camel@twins>
References: <1314043785-2880-1-git-send-email-msalter@redhat.com>
	 <1314284011.27911.29.camel@twins>
	 <1314288020.2344.30.camel@deneb.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:36177 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754411Ab1HYR1q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 25 Aug 2011 13:27:46 -0400
In-Reply-To: <1314288020.2344.30.camel@deneb.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-arch@vger.kernel.org

On Thu, 2011-08-25 at 12:00 -0400, Mark Salter wrote:
> On Thu, 2011-08-25 at 16:53 +0200, Peter Zijlstra wrote:
> > It would be ever so nice to also point us to a binutils/gcc
> > source/patch
> > so that we can actually compile this muck.
> 
> Sorry. I did so in the earlier patch series.
> 
>   http://www.codesourcery.com/sgpp/lite/c6000/portal/release1882

OK, so is all that properly merged in upstream binutils/gcc ? 

These codesourcery things are an utter friggin pain since they release a
complete source tree for each target instead of patches. Nor do they
release a single source for all targets.

For someone who wants to simply be able to cross-compile all linux
kernel archs life is hell, and looking at all these new archs recently
that hell is only getting worse.
