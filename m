From: Kees Cook <keescook@chromium.org>
Subject: Re: Docs for PR_SET_NO_NEW_PRIVS
Date: Tue, 5 Jun 2012 10:33:14 -0700
Message-ID: <CAGXu5jLc6UW85TxA7ccA4e1u78hkTbSrWeBJE+oTXXQECPvtjg@mail.gmail.com>
References: <4FCE3C18.4080302@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:47693 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754983Ab2FERdQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 5 Jun 2012 13:33:16 -0400
Received: by bkcji2 with SMTP id ji2so4846460bkc.19
        for <linux-arch@vger.kernel.org>; Tue, 05 Jun 2012 10:33:14 -0700 (PDT)
In-Reply-To: <4FCE3C18.4080302@amacapital.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Will Drewry <wad@chromium.org>, linux-security-module@vger.kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, kernel-hardening@lists.openwall.com, hpa@zytor.com, mingo@redhat.com, peterz@infradead.org, tglx@linutronix.de, eparis@redhat.com, serge.hallyn@canonical.com, djm@mindrot.org, scarybeasts@gmail.com, indan@nul.nu, pmoore@redhat.com, corbet@lwn.net, eric.dumazet@gmail.com, markus@chromium.org, coreyb@linux.vnet.ibm.com, jmorris@namei.org, linux-man@vger.kernel.org, Michael Kerrisk <mtk.manpages@gmail.com>

Hi,

As-is, this could probably live in
Documentation/security/no-new-privs.txt (maybe with some examples
added).

As for a manpage section, I think Michael Kerrisk would happily add a
section for PR_[SG]ET_NO_NEW_PRIVS to prctl if this could be
summarized into a paragraph or two.

(And this reminds me I should send an update for the seccomp section
in the prctl manpage too.)

-Kees

On Tue, Jun 5, 2012 at 10:04 AM, Andy Lutomirski <luto@amacapital.net> =
wrote:
> Hi all-
>
> As promised (although belatedly), I wrote up some proposed documentat=
ion
> for the no_new_privs feature. =A0What should I do with it? =A0I don't=
 speak
> groff/troff/whatever man pages are written in.
>
> I would be happy to license this text appropriately for whatever tree
> it might end up in. =A0In the mean time, it's GPLv2+.
>
> --- cut here ---
>
> The execve system call can grant a newly-started program privileges
> that its parent did not have. =A0The most obvious examples are
> setuid/setgid programs and file capabilities. =A0To prevent the paren=
t
> program from gaining these privileges as well, the kernel and user
> code must be careful to prevent the parent from doing anything that
> could subvert the child. =A0For example:
>
> =A0- The dynamic loader handles LD_* environment variables differentl=
y
> if a program is setuid.
> =A0- chroot is disallowed to unprivileged processes, since it would
> allow /etc/passwd to be replaced from the point of view of a process
> that inherited chroot.
> =A0- The exec code has special handling for ptrace.
>
> These are all ad-hoc fixes. =A0The no_new_privs bit (since Linux 3.5)=
 is
> a new, generic mechanism to make it safe for a process to modify its
> execution environment in a manner that persists across execve. =A0Any
> task can set no_new_privs. =A0Once the bit is set, it is inherited
> across fork, clone, and execve and cannot be unset. =A0With no_new_pr=
ivs
> set, execve promises not to grant the privilege to do anything that
> could not have been done without the execve call. =A0For example, the
> setuid and setgid bits will no longer change the uid or gid; file
> capabilities will not add to the permitted set, and LSMs will not
> relax constraints after execve.
>
> Note that no_new_privs does not prevent privilege changes that do not
> involve execve. =A0An appropriately privileged task can still call
> setuid(2) and receive SCM_RIGHTS datagrams.
>
> There are two main use cases for no_new_privs so far:
>
> =A0- Filters installed for the seccomp mode 2 sandbox persist across
> execve and can change the behavior of newly-executed programs.
> Unprivileged users are therefore only allowed to install such filters
> if no_new_privs is set.
>
> =A0- By itself, no_new_privs can be used to reduce the attack surface
> available to an unprivileged user. =A0If everything running with a gi=
ven
> uid has no_new_privs set, then that uid will be unable to escalate it=
s
> privileges by directly attacking setuid, setgid, and fcap-using
> binaries; it will need to compromise something without the
> no_new_privs bit set first.
>
> In the future, other potentially dangerous kernel features could
> become available to unprivileged tasks if no_new_privs is set. =A0In
> principle, several options to unshare(2) and clone(2) would be safe
> when no_new_privs is set, and no_new_privs + chroot is considerable
> less dangerous than chroot by itself.
>
> --- cut here ---
>
> --Andy



--=20
Kees Cook
Chrome OS Security
