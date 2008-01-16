Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:58656 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625AbYAPST7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 16 Jan 2008 13:19:59 -0500
Date: Wed, 16 Jan 2008 18:18:49 +0000
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [rfc][patch 2/2] mm: introduce optional pte_special pte bit
Message-ID: <20080116181849.GA23371@flint.arm.linux.org.uk>
References: <20080113043922.GA22345@wotan.suse.de> <alpine.LFD.1.00.0801122042220.2806@woody.linux-foundation.org> <20080113050605.GA1340@wotan.suse.de> <alpine.LFD.1.00.0801130846000.2806@woody.linux-foundation.org> <20080116033800.GA8890@wotan.suse.de> <alpine.LFD.1.00.0801151944120.2806@woody.linux-foundation.org> <20080116043728.GA7684@wotan.suse.de> <alpine.LFD.1.00.0801152040310.2806@woody.linux-foundation.org> <20080116051759.GA14049@wotan.suse.de> <1200480750.19045.33.camel@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1200480750.19045.33.camel@pc1117.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Nick Piggin <npiggin@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Hugh Dickins <hugh@veritas.com>, Jared Hulbert <jaredeh@gmail.com>, Carsten Otte <cotte@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-arch@vger.kernel.org

On Wed, Jan 16, 2008 at 10:52:29AM +0000, Catalin Marinas wrote:
> If Xscale3 supports TEX remapping (it's an ARMv6, so it should but I'm
> not sure)

For the elimination of doubt, Xscale 3 is ARMv5 with cherry picked ARMv6
features - eg, it's VIVT, no ASID.  I don't believe it has any remapping
ability... but as I've said - when I get around to resolving this shared
mmap issue I'll know more about the way forward.

At the moment, the hold up is this EABI crap - the filesystem I have for
the Xscale 3 platform is EABI only so I can't run any of my existing test
programs, and I don't have a toolchain capable of generating executables
for EABI userspace - and I don't think I can sensibly put the OABI
libraries on the platform either.

So my first problem to resolve is how to run my test programs which show
up the issue on this hardware.

The second problem which is proving difficult is to find out why one of
the patches which enabled proper use of the set_pte_ext() function on
Xscale 3 CPUs resulted in Lennert's IOP board falling over - I've not
heard anything further from Lennert on that issue yet, despite prodding.
So, I might just throw it into the next merge window _anyway_ and then
we'll get more people testing it and hopefully get to the bottom of the
window.  The other alternative is to just let the patch sit around for
ever and nothing will happen - which clearly isn't productive.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
