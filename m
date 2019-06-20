From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] ARC: ARCv2: jump label: implement jump label patching
Date: Thu, 20 Jun 2019 09:21:44 +0200
Message-ID: <20190620072144.GS3419@hirez.programming.kicks-ass.net>
References: <20190614164049.31626-1-Eugeniy.Paltsev@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA2307501A252CCC3@us01wembx1.internal.synopsys.com>
 <20190619081227.GL3419@hirez.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA2307501A252E40B@us01wembx1.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA2307501A252E40B@us01wembx1.internal.synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Jason Baron <jbaron@akamai.com>, Paolo Bonzini <pbonzini@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Jun 19, 2019 at 11:55:41PM +0000, Vineet Gupta wrote:
> So we ensure a patched instruction never crosses a
> cache line - using .balign 4. This causes a slight mis-optimization that all
> patched instruction locations are forced to be 4 bytes aligned while ISA allows
> code to be 2 byte aligned. The cost is an extra NOP_S (2 bytes) - no big deal in
> grand scheme of things in IMO.

Right, so the scheme x86 uses (which I outlined in an earlier email)
allows you to get rid of those extra NOPs.

Given jump labels are typically used on fast paths, and NOPs still take
up cycles to, at the very least, fetch and decode, some people might care.

But if you're OK with having them, then sure, your scheme certainly
should work.
