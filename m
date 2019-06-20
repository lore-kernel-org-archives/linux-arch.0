Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:39460 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfFTHPX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Jun 2019 03:15:23 -0400
Date: Thu, 20 Jun 2019 09:15:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] ARC: ARCv2: jump label: implement jump label patching
Message-ID: <20190620071514.GR3419@hirez.programming.kicks-ass.net>
References: <20190614164049.31626-1-Eugeniy.Paltsev@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA2307501A252CCC3@us01wembx1.internal.synopsys.com>
 <20190619081227.GL3419@hirez.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA2307501A252E40B@us01wembx1.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA2307501A252E40B@us01wembx1.internal.synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Jason Baron <jbaron@akamai.com>, Paolo Bonzini <pbonzini@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20190620071514.88Yqf7kE06Uo4t3r2R4oCH9HXhyP8X6jNK6fbwI_r2E@z>

On Wed, Jun 19, 2019 at 11:55:41PM +0000, Vineet Gupta wrote:

> FWIW I tried to avoid all of this by using the 2 byte NOP_S and B_S variants which
> ensures we can never straddle cache line so the alignment issue goes away. There's
> a nice code size reduction too - see [1] . But I get build link errors in
> networking code around DO_ONCE where the unlikely code is too much and offset
> can't be encoded in signed 10 bits which B_S is allowed.

Yeah, so on x86 we have a 2 byte and a 5 byte relative jump and have the
exact same issue. We're currently using 5 byte jumps unconditionally for
the same reason.

Getting it to use the 2 byte one where possible is a 'fun' project for
someone with spare time at some point.  It might need a GCC plugin to
pull off, I've not put too much tought into it.
