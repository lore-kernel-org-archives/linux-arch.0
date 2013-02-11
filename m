From: Jonas Bonn <jonas.bonn@gmail.com>
Subject: Re: pt_regs leak into userspace (was Re: [PATCH v3 20/71] ARC: Signal handling)
Date: Mon, 11 Feb 2013 10:36:38 +0100
Message-ID: <CACM3HyGNZxfOXpw01POBVT-YcVKQsnPkO6Kgg+epfZS-x-BRCg@mail.gmail.com>
References: <1359024639-21915-1-git-send-email-vgupta@synopsys.com>
	<1359024639-21915-9-git-send-email-vgupta@synopsys.com>
	<51189D2F.4030000@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:59371 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753600Ab3BKJgn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 11 Feb 2013 04:36:43 -0500
In-Reply-To: <51189D2F.4030000@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>

On 11 February 2013 08:26, Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:

>
> The only downside of this patch is that userspace signal stack grows in size,
> since signal frame only cares about scratch regs (pt_regs), but has to accommodate
> unused placeholder for callee regs too by virtue of using user_regs_struct.

Is this really true?  Don't setcontext and friends require that _all_
the registers be part of sigcontext?

/Jonas
