From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [RFC][PATCH 12/24] mips: Provide atomic_{or,xor,and}
Date: Thu, 9 Jul 2015 20:45:19 +0200
Message-ID: <20150709184519.GF18167@linux-mips.org>
References: <20150709172855.564686637@infradead.org>
 <20150709175309.098420045@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:57358 "EHLO
	cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752989AbbGIT4o (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2015 15:56:44 -0400
Received: from localhost.localdomain ([127.0.0.1]:50473 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010225AbbGISp4jiL3t (ORCPT <rfc822;linux-arch@vger.kernel.org>
        + 1 other); Thu, 9 Jul 2015 20:45:56 +0200
Content-Disposition: inline
In-Reply-To: <20150709175309.098420045@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, will.deacon@arm.com, hskinnemoen@gmail.com, realmz6@gmail.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, jejb@parisc-linux.org, benh@kernel.crashing.org, heiko.carstens@de.ibm.com, davem@davemloft.net, cmetcalf@ezchip.com, mingo@kernel.org

On Thu, Jul 09, 2015 at 07:29:07PM +0200, Peter Zijlstra wrote:

> Implement atomic logic ops -- atomic_{or,xor,and}.
> 
> These will replace the atomic_{set,clear}_mask functions that are
> available on some archs.

Acked-by: Ralf Baechle <ralf@linux-mips.org>
