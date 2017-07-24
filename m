Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35120 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754175AbdGXRng (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jul 2017 13:43:36 -0400
MIME-Version: 1.0
In-Reply-To: <8760ek5ics.fsf_-_@xmission.com>
References: <87o9shg7t7.fsf_-_@xmission.com> <20170718140651.15973-7-ebiederm@xmission.com>
 <CA+55aFyKsmf+BpYjcH30MGpHTDJ=zgYPx6kwyEB9CXXFxj_xsw@mail.gmail.com>
 <878tjlbqpt.fsf@xmission.com> <8760ek5ics.fsf_-_@xmission.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 24 Jul 2017 10:43:34 -0700
Message-ID: <CA+55aFyH5W2doo9vxXta_-pXfNXqQ19d7z48k1hmfAot+aJvMw@mail.gmail.com>
Subject: Re: Simplfying copy_siginfo_to_user
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, Andrei Vagin <avagin@virtuozzo.com>, Thomas Gleixner <tglx@linutronix.de>, Greg KH <greg@kroah.com>, Andrey Vagin <avagin@openvz.org>, Serge Hallyn <serge@hallyn.com>, Pavel Emelyanov <xemul@virtuozzo.com>, Cyrill Gorcunov <gorcunov@openvz.org>, Peter Zijlstra <peterz@infradead.org>, Willy Tarreau <w@1wt.eu>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Linux Containers <containers@lists.linux-foundation.org>, Michael Kerrisk <mtk.manpages@gmail.com>
Message-ID: <20170724174334.wWg2qJVwA1q1GuPaPkisy98PUu-mhSQon_8ehWPiDrY@z>

On Sat, Jul 22, 2017 at 1:25 PM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> I played with some clever changes such as limiting the copy to 48 bytes,
> disabling the memset and the like but I could not get a strong enough
> signal to say that any one change removed the extra or a clear part of
> it 20ns.

What CPU did you use? Because the SMAP bit in particular matters.

The field-by-field copies are extremely slow on modern CPU's that
implement SMAP, unless you also use the special "unsafe_put_user()"
code (or the nasty old put_user_ex() code that some of the x86 signal
code uses).

So one of the advantages of just copy_to_user() ends up being visible
only on Broadwell+ (or whatever the SMAP cutoff is).

                 Linus
