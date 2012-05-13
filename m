From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 1/4] [-next] Makefile: Do not call cc-option before
 including the arch's Makefile
Date: Sat, 12 May 2012 18:01:08 -0700
Message-ID: <20120513010108.GD27196@tassilo.jf.intel.com>
References: <1336855148-18817-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:45571 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756544Ab2EMBBJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 12 May 2012 21:01:09 -0400
Content-Disposition: inline
In-Reply-To: <1336855148-18817-1-git-send-email-geert@linux-m68k.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Michal Marek <mmarek@suse.cz>, linux-kbuild@vger.kernel.org

On Sat, May 12, 2012 at 10:39:05PM +0200, Geert Uytterhoeven wrote:
> On architectures that setup CROSS_COMPILE in their arch/*/Makefile
> (blackfin, h8300, m68k, mips, parisc, score, sh, tile, unicore32, xtensa),
> cc-option may check against the wrong compiler, causing errors like
> 
> cc1: error: unrecognized command line option "-fno-ipa-cp-clone"
> 
> if the host gcc supports -fno-ipa-cp-clone, while the cross compiler
> doesn't support that option.
> 
> Move the CONFIG_READABLE_ASM section below the inclusion of the arch's
> Makefile to fix this.

Thanks Geert for tracking that down.

Michael, are the patches already in the queue or should I resubmit them?

-Andi
