From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH] modules: add default loader hook implementations
Date: Sat, 25 Jun 2011 12:39:27 +0200
Message-ID: <1308998367.6699.30.camel@localhost>
References: <1308987512-6583-1-git-send-email-jonas@southpole.se>
	 <20110625100449.GA19097@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.southpole.se ([193.12.106.18]:56542 "EHLO
	mail.southpole.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041Ab1FYKjb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 25 Jun 2011 06:39:31 -0400
In-Reply-To: <20110625100449.GA19097@elte.hu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: rusty@rustcorp.com.au, arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, monstr@monstr.eu, cmetcalf@tilera.com, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>


On Sat, 2011-06-25 at 12:04 +0200, Ingo Molnar wrote:
> Also, and more importantly, don't we generally do such things via 
> __weak aliases, because the result looks cleaner and needs no changes 
> for architectures beyond the removal of the generic functions? We 
> have excluded broken toolchains that miscompile/mislink __weak IIRC 
> so __weak ought to work.

When we discussed this briefly yesterday, both Rusty and Arnd showed a
preference for not using __weak aliases... I'll leave it to them to
comment further.

The alternative patch that just provides __weak implementations for
these hooks is much less invasive than the patch I sent, effectively
touching only kernel/module.c

Let me know which is preferable.

/Jonas
