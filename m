From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v19 09/12] arch: Wire up landlock() syscall
Date: Wed, 8 Jul 2020 09:47:33 +0200
Message-ID: <CAK8P3a3Mf_+-MY5kdeY7sqwUgCUi=PksWz1pGDy+o0ZfgF93Zw@mail.gmail.com>
References: <20200707180955.53024-1-mic@digikod.net> <20200707180955.53024-10-mic@digikod.net>
 <CAK8P3a0docCqHkEn9C7=e0GC_ieN1dsYgKQ9PbUmSZYxh9MRnw@mail.gmail.com> <8d2dab03-289e-2872-db66-ce80ce5c189f@digikod.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:42745 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgGHHrx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jul 2020 03:47:53 -0400
In-Reply-To: <8d2dab03-289e-2872-db66-ce80ce5c189f@digikod.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@amacapital.net>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Casey Schaufler <casey@schaufler-ca.com>, James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Michael Kerrisk <mtk.manpages@gmail.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mickael.salaun@ssi.gouv.fr>, Richard Weinberger <richard@nod.at>, "Serge E . Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>, Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>, Kernel Hardening <kernel-hardening@lists.openwall.com>, Linux API <linux-api@vger.kernel.org>linux-a

On Wed, Jul 8, 2020 at 9:31 AM Mickaël Salaün <mic@digikod.net> wrote:
> On 08/07/2020 09:22, Arnd Bergmann wrote:
> > On Tue, Jul 7, 2020 at 8:10 PM Mickaël Salaün <mic@digikod.net> wrote:
> >
> >> index f4a01305d9a6..a63a411a74d5 100644
> >> --- a/include/uapi/asm-generic/unistd.h
> >> +++ b/include/uapi/asm-generic/unistd.h
>
> OK, I'll rebase the next series on linux-next.

Just change the number to the next free one, without actually rebasing.
It's always a bit messy to have multiple syscalls added, but I think that
causes the least confusion.

> Do you know if there is other syscalls on their way to linux-next?

None that I'm aware of.

> Are the other parts of arch/syscall OK for you?

The arch/* and include/uapi/asm-generic changes look ok to me.
I'll reply to the syscall implementation separately/

     Arnd
