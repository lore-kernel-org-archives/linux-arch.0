Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:35935 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751857AbdHGRlk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2017 13:41:40 -0400
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.00.1708071706290.17596@tp.orcam.me.uk>
References: <87o9shg7t7.fsf_-_@xmission.com> <20170718140651.15973-4-ebiederm@xmission.com>
 <alpine.DEB.2.00.1708071706290.17596@tp.orcam.me.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 7 Aug 2017 10:41:39 -0700
Message-ID: <CA+55aFx3ss90b4x2bo4si80kQUjMVL1zUX3Oxvu04OE14nUtFw@mail.gmail.com>
Subject: Re: [PATCH 4/7] signal/mips: Document a conflict with SI_USER with SIGFPE
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Maciej W. Rozycki" <macro@imgtec.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, Andrei Vagin <avagin@virtuozzo.com>, Thomas Gleixner <tglx@linutronix.de>, Greg KH <greg@kroah.com>, Andrey Vagin <avagin@openvz.org>, Serge Hallyn <serge@hallyn.com>, Pavel Emelyanov <xemul@virtuozzo.com>, Cyrill Gorcunov <gorcunov@openvz.org>, Peter Zijlstra <peterz@infradead.org>, Willy Tarreau <w@1wt.eu>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Linux Containers <containers@lists.linux-foundation.org>, Michael Kerrisk <mtk.manpages@gmail.com>, Ralf Baechle <ralf@linux-mips.org>
Message-ID: <20170807174139.nX44UkKxvnCc39n1W-ySI4Z60SBCTSTfj8aHIsz0Cx4@z>

On Mon, Aug 7, 2017 at 9:18 AM, Maciej W. Rozycki <macro@imgtec.com> wrote:
>
>  So what would be the right value of `si_code' to use here for such an
> unexpected exception condition?  I think `BUG()' would be too big a
> hammer here.  Or wouldn't it?

Hell no. NEVER EVER BUG().

The only case to use BUG() is if there is some core data structure
(say, kernel stack) that is so corrupted that you know you cannot
continue. That's the *only* valid use.

If this is a "this condition cannot happen" issue, then just remove
the damn conditional. It's pointless. Adding a BUG() to show "this
cannot happen" is not acceptable.

                        Linus
