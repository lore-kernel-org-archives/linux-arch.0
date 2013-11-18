From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 2/3] kill MMF_DUMPABLE and MMF_DUMP_SECURELY
Date: Mon, 18 Nov 2013 20:16:00 +0100
Message-ID: <20131118191600.GA14679@redhat.com>
References: <20131101232521.GA23119@www.outflux.net> <20131114170337.GA11068@redhat.com> <CAGXu5jLXpLqjCAMFwKp7t7GpMq4+WBqNzSFC=up+CBvgGDuFCw@mail.gmail.com> <20131115203652.GA13476@redhat.com> <CAGXu5j+=LZYAczLVawGPAxd=9VX1FupWZq+2858GsrD1YprL3w@mail.gmail.com> <20131116190057.GA22666@redhat.com> <20131116190141.GC22666@redhat.com> <CAGXu5jK4sJ6zwi+rPqP-FjwY4C+6gsOVUOBfN7ztu9wNQYnk4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:6809 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751612Ab3KRTO6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 18 Nov 2013 14:14:58 -0500
Content-Disposition: inline
In-Reply-To: <CAGXu5jK4sJ6zwi+rPqP-FjwY4C+6gsOVUOBfN7ztu9wNQYnk4g@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "security@kernel.org" <security@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Vasily Kulikov <segoon@openwall.com>, Petr Matousek <pmatouse@redhat.com>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Alex Kelly <alex.page.kelly@gmail.com>, Josh Triplett <josh@joshtriplett.org>

On 11/18, Kees Cook wrote:
>
> On Sat, Nov 16, 2013 at 11:01 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> > @@ -1629,24 +1628,13 @@ void set_dumpable(struct mm_struct *mm, int value)
> >
> >         do {
> >                 old = ACCESS_ONCE(mm->flags);
> > -               new = old & ~MMF_DUMPABLE_MASK;
> > -
> > -               switch (value) {
> > -               case SUID_DUMP_ROOT:
> > -                       new |= (1 << MMF_DUMP_SECURELY);
> > -               case SUID_DUMP_USER:
> > -                       new |= (1<< MMF_DUMPABLE);
> > -               }
> > -
> > +               new = (old & ~MMF_DUMPABLE_MASK) | value;
>
> Just to make this safe against insane callers, perhaps mask the value as well?

Well yes, before this patch set_dumpable() silently ignored the wrong
value, perhaps you are right but see below.

>     new = (old & ~MMF_DUMPABLE_MASK) | (value & MMF_DUMPABLE_MASK);
                                          ^^^^^^^^^^^^^^^^^^^^^^^^^^

this doesn't really help, with this patch "mm->flags & MMF_DUMPABLE_MASK"
has a room for yet another SUID_DUMP == 4 we do not have yet.

And I don't really like the "silently ignore" logic, so perhaps

		if (WARN_ON(value > SUID_DUMP_ROOT))
			return;

at the start makes more sense?

Or perhaps we do not really need the additional check? suid_dumpable
is always sane, other callers can't use the wrong value.

But I am fine either way, please tell me what do you prefer.

Oleg.
