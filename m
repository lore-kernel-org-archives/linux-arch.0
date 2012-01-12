From: Michael Cree <mcree@orcon.net.nz>
Subject: Re: why doesn't x86_32 have the accept4() syscall?
Date: Thu, 12 Jan 2012 13:33:37 +1300
Message-ID: <4F0E2A61.1090609@orcon.net.nz>
References: <CA+8MBbLe5uC4gMg9vySTWYUsNv=P-9spnNbKsFAZqQCT_Wk+YQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from nctlincom02.orcon.net.nz ([60.234.4.75]:37108 "EHLO
	nctlincom02.orcon.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612Ab2ALAne (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 11 Jan 2012 19:43:34 -0500
Received: from mx4.orcon.net.nz (mx4.orcon.net.nz [219.88.242.54])
	by nctlincom02.orcon.net.nz (8.14.3/8.14.3/Debian-9.4) with ESMTP id q0C0Xg7M009019
	for <linux-arch@vger.kernel.org>; Thu, 12 Jan 2012 13:33:42 +1300
Received: from Debian-exim by mx4.orcon.net.nz with local (Exim 4.69)
	(envelope-from <mcree@orcon.net.nz>)
	id 1Rl8bp-0000lR-E0
	for linux-arch@vger.kernel.org; Thu, 12 Jan 2012 13:33:37 +1300
In-Reply-To: <CA+8MBbLe5uC4gMg9vySTWYUsNv=P-9spnNbKsFAZqQCT_Wk+YQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tony Luck <tony.luck@intel.com>
Cc: linux-arch@vger.kernel.org

On 10/01/12 10:26, Tony Luck wrote:
> I've been using the warnings from scripts/checksyscalls.sh to let me know
> when some new system calls are added, so I can add them to ia64. But
> it was recently brought to my attention that I didn't have accept4(). I missed
> it because I didn't see a warning, which was because this script just compares
> against the 32-bit x86 list.
> 
> A casual grep shows that:
> alpha, arm, microblaze, mips, parisc, powerpc, sh and sparc
> managed to add accept4 without getting the "warning syscall
> .... not implemented"

A search of the git log would reveal that on Alpha we only very recently
added accept4 because we had also missed it!  We were badly bit by the
latest udev needing accept4.

The question that I think would be more pertinent is: How do we know
that we have implemented all relevant syscalls when the checksyscalls.sh
script is not a sufficient check?

Cheers
Michael.
