Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:47565 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101Ab2DMEki (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 13 Apr 2012 00:40:38 -0400
Received: by dake40 with SMTP id e40so3375854dak.11
        for <linux-arch@vger.kernel.org>; Thu, 12 Apr 2012 21:40:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.1204131432430.22093@tundra.namei.org>
References: <1334267284-19166-1-git-send-email-wad@chromium.org>
 <alpine.LRH.2.02.1204131414580.22039@tundra.namei.org> <CAObL_7ER32AesD6bHk591ss0hTFmp0bjVOKV9oEdhiFwCEVOBA@mail.gmail.com>
 <alpine.LRH.2.02.1204131432430.22093@tundra.namei.org>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 12 Apr 2012 21:40:13 -0700
Message-ID: <CALCETrUciLZfC4W6CwSzrvCRUxGtamx6gMbrA18R0ZoUUyJZfg@mail.gmail.com>
Subject: Re: [PATCH v18 01/15] Add PR_{GET,SET}_NO_NEW_PRIVS to prevent execve
 from granting privs
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Morris <jmorris@namei.org>
Cc: Andrew Lutomirski <luto@mit.edu>, Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org, linux-man@vger.kernel.org, linux-security-module@vger.kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, kernel-hardening@lists.openwall.com, netdev@vger.kernel.org, x86@kernel.org, arnd@arndb.de, "David S. Miller" <davem@davemloft.net>, hpa@zytor.com, mingo@redhat.com, Oleg Nesterov <oleg@redhat.com>, peterz@infradead.org, rdunlap@xenotime.net, mcgrathr@chromium.org, tglx@linutronix.de, Eric Paris <eparis@redhat.com>, Serge Hallyn <serge.hallyn@canonical.com>, djm@mindrot.org, scarybeasts@gmail.com, indan@nul.nu, pmoore@redhat.com, Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, eric.dumazet@gmail.com, markus@chromium.org, coreyb@linux.vnet.ibm.com, Kees Cook <keescook@chromium.org>, Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <20120413044013.9vO-PTTtaW5RS-SkDnZa2IGyiYdTSh83SFp0wKoeSx8@z>

On Thu, Apr 12, 2012 at 9:34 PM, James Morris <jmorris@namei.org> wrote:
> On Thu, 12 Apr 2012, Andrew Lutomirski wrote:
>
>> > What about dynamic transitions in SELinux ?
>> >
>>
>> What's a dynamic transition?
>
> The security label can be changed without an exec:
>
> See selinux_setprocattr(), for "current".

Ah.

I see nothing wrong with that, for the same reason I see nothing wrong
with setuid (the system call) after PR_SET_NO_NEW_PRIVS.  The
privileges granted by writing to /proc/self/attr/current were already
available in the sense that you could have written to current whenever
you wanted to.

(FWIW, I think that selinux should have made that the only way to
change contexts, full stop.  And I think that the setuid and setgid
bits were mistakes.  Water under the bridge...)

--Andy
