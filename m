From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 2/3] kill MMF_DUMPABLE and MMF_DUMP_SECURELY
Date: Mon, 18 Nov 2013 20:37:52 +0100
Message-ID: <20131118193752.GA15948@redhat.com>
References: <20131101232521.GA23119@www.outflux.net> <20131114170337.GA11068@redhat.com> <CAGXu5jLXpLqjCAMFwKp7t7GpMq4+WBqNzSFC=up+CBvgGDuFCw@mail.gmail.com> <20131115203652.GA13476@redhat.com> <CAGXu5j+=LZYAczLVawGPAxd=9VX1FupWZq+2858GsrD1YprL3w@mail.gmail.com> <20131116190057.GA22666@redhat.com> <20131116190141.GC22666@redhat.com> <CAGXu5jK4sJ6zwi+rPqP-FjwY4C+6gsOVUOBfN7ztu9wNQYnk4g@mail.gmail.com> <20131118191600.GA14679@redhat.com> <CAGXu5jKRvLqWkOF=3qoQ1ZdaKNLai_kai4Png5Ls3X1WAtdzJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57159 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751558Ab3KRTgu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 18 Nov 2013 14:36:50 -0500
Content-Disposition: inline
In-Reply-To: <CAGXu5jKRvLqWkOF=3qoQ1ZdaKNLai_kai4Png5Ls3X1WAtdzJA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "security@kernel.org" <security@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Vasily Kulikov <segoon@openwall.com>, Petr Matousek <pmatouse@redhat.com>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Alex Kelly <alex.page.kelly@gmail.com>, Josh Triplett <josh@joshtriplett.org>

On 11/18, Kees Cook wrote:
>
> On Mon, Nov 18, 2013 at 11:16 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > And I don't really like the "silently ignore" logic, so perhaps
> >
> >                 if (WARN_ON(value > SUID_DUMP_ROOT))
> >                         return;
>
> Ah, good point about == 4. Yeah, I like the WARN_ON. No reason not to
> be defensive as long as this code is getting changed.

OK. I'll send v2 tomorrow.


And I just noticed I forgot to remove security@kernel.org, sorry for
unnecessary noise.

Oleg.
