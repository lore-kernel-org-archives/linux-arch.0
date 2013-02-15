From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: pt_regs leak into userspace (was Re: [PATCH v3 20/71] ARC: Signal
 handling)
Date: Fri, 15 Feb 2013 13:05:00 +0530
Message-ID: <511DE524.3070901@synopsys.com>
References: <1359024639-21915-1-git-send-email-vgupta@synopsys.com> <1359024639-21915-9-git-send-email-vgupta@synopsys.com> <51189D2F.4030000@synopsys.com> <CACM3HyGNZxfOXpw01POBVT-YcVKQsnPkO6Kgg+epfZS-x-BRCg@mail.gmail.com> <5118C458.2070205@synopsys.com> <CACM3HyF2GHz5PKuurYG2Hg+UEKeto+zme5gcv2fxQDC=tpZYRw@mail.gmail.com> <20130211140704.GI4503@ZenIV.linux.org.uk> <CACM3HyExw6WDtF6gtFrmLjyvPDTAKodSerChaoqUNZsSyD+b2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtp2.synopsys.com ([198.182.44.80]:60453 "EHLO
	kiruna.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932857Ab3BOHgQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 15 Feb 2013 02:36:16 -0500
In-Reply-To: <CACM3HyExw6WDtF6gtFrmLjyvPDTAKodSerChaoqUNZsSyD+b2g@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonas Bonn <jonas.bonn@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Friday 15 February 2013 12:53 PM, Jonas Bonn wrote:
> On 11 February 2013 15:07, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>> I'd suggest asking itanic folks; they do *not* put callee-saved stuff into
>> sigcontext.  AFAICS, they don't have setcontext() implemented as a syscall
>> at all - it's done as sigprocmask() + doing to callee-saved registers what
>> longjmp() does.
>
> Just to round off this discussion, after giving it some more thought I
> agree that the case where you would need callee-saved registers
> restored is probably rather pathological.  Any sane use of
> get/set/swapcontext is manageable without this.
>
> So, Vineet, I'm now convinced your approach is sound.  I will probably
> amend the OpenRISC arch to behave similarly.  Consider your entire
> patch Acked now.

I'll add your ack to the the signal handling patch as the contention was primarily
on sigcontext bits.

Thx,
-Vineet
