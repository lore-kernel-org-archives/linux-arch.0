From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v5 14/32] x86/mm/64: Enable vmapped stacks
Date: Thu, 14 Jul 2016 20:45:28 +0200
Message-ID: <20160714184527.GB16975@gmail.com>
References: <cover.1468270393.git.luto@kernel.org>
 <8d36dd9b2430b61db64333af7b911d0bca7d5d2f.1468270393.git.luto@kernel.org>
 <20160713075314.GA32700@gmail.com>
 <CALCETrW9B=MAGaLAV0Y86MQ2==pjoShHdOPNM_8ZR1OKZDy2ZQ@mail.gmail.com>
 <20160714083411.GA15437@gmail.com>
 <CALCETrUk9Ae-kGixsoqZZG3gb+=JCpQ-zbuNU8R+V6TFg4ymeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36242 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278AbcGNSpc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 14 Jul 2016 14:45:32 -0400
Content-Disposition: inline
In-Reply-To: <CALCETrUk9Ae-kGixsoqZZG3gb+=JCpQ-zbuNU8R+V6TFg4ymeA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>


* Andy Lutomirski <luto@amacapital.net> wrote:

> If you think it makes sense, I can split out a bunch of the x86 and mm 
> preparatory patches and, if it reorders cleanly and still works, the 
> THREAD_INFO_IN_TASK thing.  Those could plausibly go in 4.7.  Would
> you like me  to see how that goes?  (I'll verify that it builds, that
> the 0day bot likes it,  and that the final result of the patchset is
> exactly identical to what I already sent.)

Yeah, doing that would be useful - the smaller the riskier bits end up
being the better.

Thanks,

	Ingo
