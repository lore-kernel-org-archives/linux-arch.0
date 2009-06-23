From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: S+core architecture (arch/score/) support files
Date: Tue, 23 Jun 2009 15:55:54 +0200
Message-ID: <200906231555.54887.arnd@arndb.de>
References: <OF318304AE.9C3DA8BC-ON482575DE.002B7553-482575DE.002FC96B@sunplusct.com> <200906231143.22985.arnd@arndb.de> <87zlbz17fb.fsf@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:57219 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753975AbZFWN4a (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 23 Jun 2009 09:56:30 -0400
In-Reply-To: <87zlbz17fb.fsf@basil.nowhere.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: liqin.chen@sunplusct.com, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Tuesday 23 June 2009, Andi Kleen wrote:
> IMHO a full successfull LTP run should be minimal criterium for
> merging an architecture. That should catch most of the possible
> "simple" mistakes in the syscall ABI. I would suggest to wait to after
> this has been done.

I agree in general, but in this case the ABI is essentially defined
through the asm-generic headers, with the exception of the functions
that actually were tested before the change (sys_clone, sys_execve,
sys_rt_sigreturn and sys_sig).

We should certainly fix the asm-generic versions if there are some
unexpected problems found by LTP, but delaying the score merge
won't help that, because the interesting code is already there.

While I understand the argument against merging untested code
(that's why I mentioned it in the first place), I think in
this case it's not about the ABI and the code is obviously
self-contained enough to cause no harm to others.

	Arnd <><
