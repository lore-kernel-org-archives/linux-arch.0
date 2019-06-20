Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:48528 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfFTVMv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Jun 2019 17:12:51 -0400
Date: Thu, 20 Jun 2019 23:12:42 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] ARC: ARCv2: jump label: implement jump label patching
Message-ID: <20190620211242.GB3436@hirez.programming.kicks-ass.net>
References: <20190614164049.31626-1-Eugeniy.Paltsev@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA2307501A252CCC3@us01wembx1.internal.synopsys.com>
 <20190619081227.GL3419@hirez.programming.kicks-ass.net>
 <50a5120f512e7d6784efa403a7597c159074c8c1.camel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50a5120f512e7d6784efa403a7597c159074c8c1.camel@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>, "jbaron@redhat.com" <jbaron@redhat.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>
Message-ID: <20190620211242.kR2acv02DuWZTXbxkhQpxf9t7gO1dOxP4BlAIoKVigg@z>

On Thu, Jun 20, 2019 at 06:34:29PM +0000, Eugeniy Paltsev wrote:
> On Wed, 2019-06-19 at 10:12 +0200, Peter Zijlstra wrote:
> > On Tue, Jun 18, 2019 at 04:16:20PM +0000, Vineet Gupta wrote:

> > I'm assuming you've looked at what x86 currently does and found
> > something like that doesn't work for ARC?
> 
> To be honest I've mostly look at arm/arm64 implementation :)

Yeah, but that's fixed instruction width RISC. They have it easy.
