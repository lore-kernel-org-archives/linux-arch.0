Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55630 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965130AbdGTQQI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 Jul 2017 12:16:08 -0400
Date: Thu, 20 Jul 2017 18:16:04 +0200
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 6/7] fcntl: Don't use ambiguous SIG_POLL si_codes
Message-ID: <20170720161603.GA14430@redhat.com>
References: <87o9shg7t7.fsf_-_@xmission.com>
 <20170718140651.15973-6-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170718140651.15973-6-ebiederm@xmission.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrei Vagin <avagin@virtuozzo.com>, Thomas Gleixner <tglx@linutronix.de>, Greg KH <greg@kroah.com>, Andrey Vagin <avagin@openvz.org>, Serge Hallyn <serge@hallyn.com>, Pavel Emelyanov <xemul@virtuozzo.com>, Cyrill Gorcunov <gorcunov@openvz.org>, Peter Zijlstra <peterz@infradead.org>, Willy Tarreau <w@1wt.eu>, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Linux Containers <containers@lists.linux-foundation.org>, Michael Kerrisk <mtk.manpages@gmail.com>
Message-ID: <20170720161604.PiWz-tlx8ZVfRK7k3gCbR2HNRCVK_K_-oXBWYidSkWQ@z>

On 07/18, Eric W. Biederman wrote:
>
> -			BUG_ON((reason & __SI_MASK) != __SI_POLL);
> +			BUG_ON((reason < POLL_IN) || (reason > NSIGPOLL));
                                                      ^^^^^^^^^^^^^^^^^
looks obviously wrong? Say, POLL_IN is obviously > NSIGPOLL == 6.

Probably you meant

			BUG_ON((reason < POLL_IN) || (reason - POLL_IN > NSIGPOLL)

?

but this contradicts with the next line:

>  			if (reason - POLL_IN >= NSIGPOLL)
>  				si.si_band  = ~0L;

confused...

Oleg.
