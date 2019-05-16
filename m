Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55550 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727021AbfEPPGV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 16 May 2019 11:06:21 -0400
Date: Thu, 16 May 2019 17:06:12 +0200
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v1 1/2] pid: add pidfd_open()
Message-ID: <20190516150611.GC22564@redhat.com>
References: <20190516135944.7205-1-christian@brauner.io>
 <20190516142659.GB22564@redhat.com>
 <20190516145607.j43xyj26k6l5vmbd@yavin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516145607.j43xyj26k6l5vmbd@yavin>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Christian Brauner <christian@brauner.io>, jannh@google.com, viro@zeniv.linux.org.uk, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, arnd@arndb.de, akpm@linux-foundation.org, dhowells@redhat.com, ebiederm@xmission.com, elena.reshetova@intel.com, keescook@chromium.org, luto@amacapital.net, luto@kernel.org, tglx@linutronix.de, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, joel@joelfernandes.org, dancol@google.com, serge@hallyn.com, Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <20190516150612.uXpxqAaOcS2qNMVLNLq1oor-eQRs53J2hbO2TIjb1Xw@z>

On 05/17, Aleksa Sarai wrote:
>
> On 2019-05-16, Oleg Nesterov <oleg@redhat.com> wrote:
> > On 05/16, Christian Brauner wrote:
> > >
> > > With the introduction of pidfds through CLONE_PIDFD it is possible to
> > > created pidfds at process creation time.
> >
> > Now I am wondering why do we need CLONE_PIDFD, you can just do
> >
> > 	pid = fork();
> > 	pidfd_open(pid);
>
> While the race window would be exceptionally short, there is the
> possibility that the child will die

Yes,

> and their pid will be recycled
> before you do pidfd_open().

No.

Unless the caller's sub-thread does wait() before pidfd_open(), of course.
Or unless you do signal(SIGCHILD, SIG_IGN).

Oleg.
