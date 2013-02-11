From: James Hogan <james.hogan@imgtec.com>
Subject: Re: pt_regs leak into userspace (was Re: [PATCH v3 20/71] ARC: Signal
 handling)
Date: Mon, 11 Feb 2013 11:01:47 +0000
Message-ID: <5118CF9B.60102@imgtec.com>
References: <1359024639-21915-1-git-send-email-vgupta@synopsys.com> <1359024639-21915-9-git-send-email-vgupta@synopsys.com> <51189D2F.4030000@synopsys.com> <CACM3HyGNZxfOXpw01POBVT-YcVKQsnPkO6Kgg+epfZS-x-BRCg@mail.gmail.com> <5118C458.2070205@synopsys.com> <5118C7B6.6040807@imgtec.com> <CACM3HyG+4Pzx02iL9atxG+FOLiCcTeXR+ivzRO78bqDHNp5rGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:29391 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754477Ab3BKLCC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 11 Feb 2013 06:02:02 -0500
In-Reply-To: <CACM3HyG+4Pzx02iL9atxG+FOLiCcTeXR+ivzRO78bqDHNp5rGQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonas Bonn <jonas.bonn@gmail.com>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>

Hi Jonas,

On 11/02/13 10:53, Jonas Bonn wrote:
> And now that I think about it some more, I think this is done
> incorrectly in the openrisc arch, too, as the fast-path for
> rt_sigreturn probably only restores the call-clobbered regs.
> sigreturn probably needs to be special-cased to _always_ restore all
> the regs on its way back to userspace.  Not for the "signal" case, but
> for the "setcontext" case; but these two are pretty-much
> indistinguishable.

Wouldn't setcontext restore a different stack, so the sigreturn wouldn't
happen until the ucontext is switched back?

Cheers
James
