From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 0/5] move everyone over to thin archives
Date: Sat, 17 Jun 2017 23:10:54 +1000
Message-ID: <20170617231054.63aeb5ac@roar.ozlabs.ibm.com>
References: <20170609052417.561-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34628 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751962AbdFQNLJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 17 Jun 2017 09:11:09 -0400
In-Reply-To: <20170609052417.561-1-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <mmarek@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>

On Fri,  9 Jun 2017 15:24:12 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> This has gone through 0day several times now, and I think I've
> weeded out all the build breakage. Following what Linus asked
> for, I did not make it a user selectable option. I kept the
> option there in case we need to do a depend on !ARCH for any
> reason.
> 
> Please consider for the kbuild tree.

Any thoughts on this?

Thanks,
Nick
