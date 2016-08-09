Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:49276 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752234AbcHIDQH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 8 Aug 2016 23:16:07 -0400
Date: Mon, 8 Aug 2016 20:16:05 -0700
From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 2/5] kbuild: allow archs to select build for link dead
 code/data elimination
Message-ID: <20160809031605.GF3078@tassilo.jf.intel.com>
References: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
 <12986071.MeSB5hmlsH@wuerfel>
 <20160807234947.GV20904@bubble.grove.modra.org>
 <1882847.dG563Vieov@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1882847.dG563Vieov@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alan Modra <amodra@gmail.com>, linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Nicolas Pitre <nico@linaro.org>, linux-kbuild@vger.kernel.org
Message-ID: <20160809031605.3IoQ4g-Me3CfjakXpVMJLeGci5_vZdOUO-Lfq7WFbh8@z>

> I don't understand what led Andi Kleen to also move .text.hot and
> .text.unlikely together with .text [2], but this may have
> been a related issue.

The goal was just to move .hot and .unlikely all together, so that
they are clustered and use the minimum amount of cache. On x86 doesn't
matter where they are exactly, as long as each is together.
If they are not explicitely listed then the linker interleaves
them with the normal text, which defeats the purpose.

-Andi
