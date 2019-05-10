Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38437 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfEJIvZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 May 2019 04:51:25 -0400
Date: Fri, 10 May 2019 17:51:21 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH] vsprintf: Do not break early boot with probing addresses
Message-ID: <20190510085121.GA17632@jagdpanzerIV>
References: <20190510081635.GA4533@jagdpanzerIV>
 <20190510084213.22149-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510084213.22149-1-pmladek@suse.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, "Tobin C . Harding" <me@tobin.cc>, Michal Hocko <mhocko@suse.cz>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Russell Currey <ruscur@russell.cc>, Christophe Leroy <christophe.leroy@c-s.fr>, Stephen Rothwell <sfr@ozlabs.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Message-ID: <20190510085121.odNKC0TIP5NjjMowx6VFDfGImLYzeJZz8lrq7Yx7_hk@z>

On (05/10/19 10:42), Petr Mladek wrote:
[..]
> Fixes: 3e5903eb9cff70730 ("vsprintf: Prevent crash when dereferencing invalid pointers")
> Signed-off-by: Petr Mladek <pmladek@suse.com>

FWIW
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
