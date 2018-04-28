From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [REVIEW][PATCH 0/5] Improving siginfo_layout and fixing uml's relay_signal
Date: Sat, 28 Apr 2018 09:02:02 -0500
Message-ID: <87zi1nctut.fsf_-_@xmission.com>
References: <87604mhrnb.fsf@xmission.com>
        <20180420143811.9994-19-ebiederm@xmission.com>
        <7074fe36-27c5-ee82-9659-da703cfc91fe@kot-begemot.co.uk>
        <CAFLxGvyM+Kru=ERDvccjVuMjSPbu+FQzjbUbMwSyEbL1rVGkBQ@mail.gmail.com>
        <7ddd238f-88a8-ed03-fe9e-0f4e5f2a490d@kot-begemot.co.uk>
        <87zi1sd28d.fsf@xmission.com>
        <CAMD8JhwgcWCp6c=O4-spNW1VdY5M-eAjr7M5PieeAfeTSe_4yw@mail.gmail.com>
        <CAMD8JhxHwcuXh68o1=fbZ_t6DH7x_dO_0nEMqL=cHXBfZXub=w@mail.gmail.com>
        <87lgdc1bvr.fsf@xmission.com>
        <CAMD8JhxzzCCjo_OLs8wS7ggOh4NqdxeRAGhcvuEJSUZZLO6NDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMD8JhxzzCCjo_OLs8wS7ggOh4NqdxeRAGhcvuEJSUZZLO6NDA@mail.gmail.com>
        ("Martin \=\?utf-8\?Q\?P\=C3\=A4rtel\=22's\?\= message of "Thu, 26 Apr 2018 02:05:44
 +0300")
Sender: linux-kernel-owner@vger.kernel.org
To: Linux-Arch <linux-arch@vger.kernel.org>
Cc: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, Richard Weinberger <richard.weinberger@gmail.com>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, Martin =?utf-8?Q?P=C3=A4rt?= =?utf-8?Q?el?= <martin.partel@gmail.com>
List-Id: linux-arch.vger.kernel.org


This patchset is a respin of my latest patch to relay_signal for uml.

As I understand relay_signal it very carefully scrubs the signal
information it gets from the host kernel before passing it on.
Basically making certain it recognizes what it is dealing with.

This patchset updates siginfo_layout so that relay_signal and arm64's
force_signal_inject can reliably use it to verify the kind of signal
being processed, by recognizing the specializations of SIL_FAULT as
separate cases.

To make the siginfo_layout changes clean.  signalfd is first brought
into the modern world of using a single copy_to_user, no default case
statement (so gcc will flag missing cases), and handling SIGSYS for
seccomp.

The net is a simpler relay_signal is also more careful about which
signals it relays.

Eric

The changes are also available at:
  git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git siginfo-review3

Eric W. Biederman (5):
      signal/signalfd: Remove __put_user from signalfd_copyinfo
      signal/signalfd: Add support for SIGSYS
      signal: Remove unncessary #ifdef SEGV_PKUERR in 32bit compat code
      signal: Extend siginfo_layout with SIL_FAULT_{MCEERR|BNDERR|PKUERR}
      signal/um: More carefully relay signals in relay_signal.

 arch/um/kernel/trap.c         | 38 ++++++++------------
 fs/signalfd.c                 | 84 +++++++++++++++++++++++++------------------
 include/linux/signal.h        |  3 ++
 include/uapi/linux/signalfd.h |  6 +++-
 kernel/signal.c               | 82 +++++++++++++++++++++++++++---------------
 5 files changed, 125 insertions(+), 88 deletions(-)
