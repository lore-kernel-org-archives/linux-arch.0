From: Roland McGrath <mcgrathr@google.com>
Subject: Re: [PATCH v10 07/11] signal, x86: add SIGSYS info and make it synchronous.
Date: Wed, 22 Feb 2012 16:50:40 -0800
Message-ID: <CAB=4xhq1sm_ewZ_8Kerf2aN7nGx+DEENse7Lqg5N0wuvqtzUAw@mail.gmail.com>
References: <1329845435-2313-1-git-send-email-wad@chromium.org>
 <1329845435-2313-7-git-send-email-wad@chromium.org> <9edbabb2262e3d91a7b8c75dbec03d7f.squirrel@webmail.greenhost.nl>
 <CABqD9hY1n9EOAKKT0r9Ev+azhBMnLMAM_FgDNe5we9upVePk_A@mail.gmail.com>
 <CAObL_7Gc0U2JMBQr_kbcVUJwyJq7LRfgdFr+84LR=ec4kSCwEA@mail.gmail.com>
 <CAGXu5jJQrnkCZtcLqK8NEihRgB25C12b0nKp+XWXV_=4QfcVoA@mail.gmail.com>
 <CABqD9hbC8v-rUBW+4T_-EwDwe1+VDohQZweQ-cxOg2A-iDH5CQ@mail.gmail.com>
 <CAGXu5j+fQqkrrKSm3kmCkCcZJKo-VZjL6kkrOD81LZYBY7tf2g@mail.gmail.com> <4F45887A.5010809@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:39284 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754109Ab2BWAvE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 22 Feb 2012 19:51:04 -0500
Received: by mail-qw0-f46.google.com with SMTP id c10so6175813qad.19
        for <linux-arch@vger.kernel.org>; Wed, 22 Feb 2012 16:51:04 -0800 (PST)
In-Reply-To: <4F45887A.5010809@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>, Will Drewry <wad@chromium.org>, Andrew Lutomirski <luto@mit.edu>, Indan Zupancic <indan@nul.nu>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, kernel-hardening@lists.openwall.com, netdev@vger.kernel.org, x86@kernel.org, arnd@arndb.de, davem@davemloft.net, mingo@redhat.com, oleg@redhat.com, peterz@infradead.org, rdunlap@xenotime.net, tglx@linutronix.de, eparis@redhat.com, serge.hallyn@canonical.com, djm@mindrot.org, scarybeasts@gmail.com, pmoore@redhat.com, akpm@linux-foundation.org, corbet@lwn.net, eric.dumazet@gmail.com, markus@chromium.org

On Wed, Feb 22, 2012 at 4:29 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> Can we really introduce force-kill semantics for a POSIX-defined signal?
> Other user space programs might use it for other purposes.

The semantics are based on how the signal was generated, not what signal
number it was.  The only thing that depends on the signal number is
SYNCHRONOUS_MASK, which just determines in which order pending signals are
dequeued (POSIX says it may be any order).  We only have that so your state
doesn't get unhelpfully warped to another signal handler entry point
(including fiddling the stack) before you dump core.

No use of SIGSYS is specified by POSIX at all, of course, since "system
call" is an implementation concept below the level POSIX specifies.
