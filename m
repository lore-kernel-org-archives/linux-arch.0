Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:33670 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762884Ab2DLWRG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 12 Apr 2012 18:17:06 -0400
Received: by mail-bk0-f46.google.com with SMTP id ik5so1885839bkc.19
        for <linux-arch@vger.kernel.org>; Thu, 12 Apr 2012 15:17:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1334267284-19166-1-git-send-email-wad@chromium.org>
References: <1334267284-19166-1-git-send-email-wad@chromium.org>
Date: Thu, 12 Apr 2012 15:17:01 -0700
Message-ID: <CAGXu5jJgjcEGUW2SyDsVbTtthYByg8_y1h+tbnNdSn5qjEu+NQ@mail.gmail.com>
Subject: Re: [PATCH v18 01/15] Add PR_{GET,SET}_NO_NEW_PRIVS to prevent execve
 from granting privs
From: Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Drewry <wad@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-man@vger.kernel.org, linux-security-module@vger.kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, kernel-hardening@lists.openwall.com, netdev@vger.kernel.org, x86@kernel.org, arnd@arndb.de, davem@davemloft.net, hpa@zytor.com, mingo@redhat.com, oleg@redhat.com, peterz@infradead.org, rdunlap@xenotime.net, mcgrathr@chromium.org, tglx@linutronix.de, luto@mit.edu, eparis@redhat.com, serge.hallyn@canonical.com, djm@mindrot.org, scarybeasts@gmail.com, indan@nul.nu, pmoore@redhat.com, akpm@linux-foundation.org, corbet@lwn.net, eric.dumazet@gmail.com, markus@chromium.org, coreyb@linux.vnet.ibm.com, jmorris@namei.org, Andy Lutomirski <luto@amacapital.net>
Message-ID: <20120412221701.e_lODPDwJb_e5VdFdfC4VNSmX4wb3sfwBnDjKbZWfPc@z>

On Thu, Apr 12, 2012 at 2:47 PM, Will Drewry <wad@chromium.org> wrote:
> From: Andy Lutomirski <luto@amacapital.net>
>
> With this change, calling
>  prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)
> disables privilege granting operations at execve-time.  For example, a
> process will not be able to execute a setuid binary to change their uid
> or gid if this bit is set.  The same is true for file capabilities.
>
> Additionally, LSM_UNSAFE_NO_NEW_PRIVS is defined to ensure that
> LSMs respect the requested behavior.
>
> To determine if the NO_NEW_PRIVS bit is set, a task may call
>  prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0);
> It returns 1 if set and 0 if it is not set. If any of the arguments are
> non-zero, it will return -1 and set errno to -EINVAL.
> (PR_SET_NO_NEW_PRIVS behaves similarly.)
>
> This functionality is desired for the proposed seccomp filter patch
> series.  By using PR_SET_NO_NEW_PRIVS, it allows a task to modify the
> system call behavior for itself and its child tasks without being
> able to impact the behavior of a more privileged task.
>
> Another potential use is making certain privileged operations
> unprivileged.  For example, chroot may be considered "safe" if it cannot
> affect privileged tasks.
>
> Note, this patch causes execve to fail when PR_SET_NO_NEW_PRIVS is
> set and AppArmor is in use.  It is fixed in a subsequent patch.
>
> Signed-off-by: Andy Lutomirski <luto@amacapital.net>
> Signed-off-by: Will Drewry <wad@chromium.org>
> Acked-by: Eric Paris <eparis@redhat.com>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
ChromeOS Security
