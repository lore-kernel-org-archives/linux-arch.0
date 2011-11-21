From: David Rientjes <rientjes@google.com>
Subject: Re: [patch] hugetlb: remove dummy definitions of HPAGE_MASK and
 HPAGE_SIZE
Date: Mon, 21 Nov 2011 14:48:07 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1111211445470.5318@chino.kir.corp.google.com>
References: <1321567050-13197-1-git-send-email-ddaney.cavm@gmail.com> <alpine.DEB.2.00.1111171520130.20133@chino.kir.corp.google.com> <alpine.DEB.2.00.1111171522131.20133@chino.kir.corp.google.com> <4ECACF68.3020701@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40985 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373Ab1KUWsK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 21 Nov 2011 17:48:10 -0500
Received: by iage36 with SMTP id e36so7900301iag.19
        for <linux-arch@vger.kernel.org>; Mon, 21 Nov 2011 14:48:10 -0800 (PST)
In-Reply-To: <4ECACF68.3020701@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Daney <ddaney.cavm@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-mips@linux-mips.org, ralf@linux-mips.org, linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>, linux-arch@vger.kernel.org, Robin Holt <holt@sgi.com>

On Mon, 21 Nov 2011, David Daney wrote:

> > So, just remove the dummy and dangerous definitions since they are no
> > longer needed and reveals the correct dependencies.  Tested on
> > architectures using the definitions with allyesconfig: x86 (even with
> > thp), hppa, mips, powerpc, s390, sh3, sh4, sparc, and sparc64, and
> > with defconfig on ia64.
> > 
> 
> This whole comment strikes me as somewhat dishonest, as at the time David
> Rientjes wrote it, he knew that there were dependencies on these symbols in
> the linux-next tree.
> 

I was referring to Linus' tree at the time the patch was merged, not 
linux-next.  However, yes, I was aware of the build breakage it caused in 
Ralf's mips tree and I sent a patch to fix that breakage to the mips 
folks:

	http://marc.info/?l=linux-mips&m=132175788803677

Thanks.
