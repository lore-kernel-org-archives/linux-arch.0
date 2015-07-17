From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 00/28] arch: Provide atomic logic ops
Date: Fri, 17 Jul 2015 13:57:34 +0100
Message-ID: <20150717125734.GP18994@arm.com>
References: <20150716172110.587529075@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48852 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758041AbbGQM5j (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 17 Jul 2015 08:57:39 -0400
Content-Disposition: inline
In-Reply-To: <20150716172110.587529075@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "rth@twiddle.net" <rth@twiddle.net>, "vgupta@synopsys.com" <vgupta@synopsys.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "hskinnemoen@gmail.com" <hskinnemoen@gmail.com>, "realmz6@gmail.com" <realmz6@gmail.com>, "dhowells@redhat.com" <dhowells@redhat.com>, "rkuo@codeaurora.org" <rkuo@codeaurora.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "geert@linux-m68k.org" <geert@linux-m68k.org>, "james.hogan@imgtec.com" <james.hogan@imgtec.com>, "ralf@linux-mips.org" <ralf@linux-mips.org>, "jejb@parisc-linux.org" <jejb@parisc-linux.org>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, "davem@davemloft.net" <davem@davemloft.net>, "cmetcalf@ezchip.com" <cmetcalf@ezchip.com>, ysa

On Thu, Jul 16, 2015 at 06:21:10PM +0100, Peter Zijlstra wrote:
> Currently there is an incoherent mess of atomic_{set,clear}_mask() and
> atomic_or() (but no atomic_{and,nand,xor}()) in the tree.
> 
> Those archs that implement atomic_{set,clear}_mask() are not even consistent on
> its signature.
> 
> Implement atomic_{or,and,xor}() on all archs and deprecate
> atomic_{set,clear}_mask().
> 
> The series has been compile tested by the build-bot, no known failures at this time.
> 
> I would like to take this through tip; I'll ask Ingo to put it in a separate
> branch such that people can pull in that branch if there is conflicting work
> elsewhere (Will has some for Argh64).

Cheers, Peter. FWIW, the ARM/arm64 bits look fine to me:

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
