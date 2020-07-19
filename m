Return-Path: <SRS0=fRWW=A6=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgGSPZI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 19 Jul 2020 11:25:08 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67E6C0619D5
        for <linux-arch@vger.kernel.org>; Sun, 19 Jul 2020 08:25:08 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p3so9138916pgh.3
        for <linux-arch@vger.kernel.org>; Sun, 19 Jul 2020 08:25:08 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [patch V3 01/13] entry: Provide generic syscall entry functionality
Date: Sun, 19 Jul 2020 08:25:05 -0700
Message-ID: <A790AF9D-3BF7-4FEE-9E29-7C13FA3FE0C3@amacapital.net>
References: <87v9ijollo.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87v9ijollo.fsf@nanos.tec.linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>, Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <Mark.Rutland@arm.com>, Keno Fischer <keno@juliacomputing.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm list <kvm@vger.kernel.org>, Gabriel Krisman Bertazi <krisman@collabora.com>
Message-ID: <20200719152505.k45smq3_d8lD9QWOD4dQPea6J-_CIPJm6WjfbBl487Q@z>



> On Jul 19, 2020, at 3:17 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
> =EF=BB=BFAndy Lutomirski <luto@kernel.org> writes:
>>> On Sat, Jul 18, 2020 at 7:16 AM Thomas Gleixner <tglx@linutronix.de> wro=
te:
>>> Andy Lutomirski <luto@kernel.org> writes:
>>>> FWIW, TIF_USER_RETURN_NOTIFY is a bit of an odd duck: it's an
>>>> entry/exit word *and* a context switch word.  The latter is because
>>>> it's logically a per-cpu flag, not a per-task flag, and the context
>>>> switch code moves it around so it's always set on the running task.
>>>=20
>>> Gah, I missed the context switch thing of that. That stuff is hideous.
>>=20
>> It's also delightful because anything that screws up that dance (such
>> as failure to do the exit-to-usermode path exactly right) likely
>> results in an insta-root-hole.  If we fail to run user return
>> notifiers, we can run user code with incorrect syscall MSRs, etc.
>=20
> Looking at it deeper, having that thing in the loop is a pointless
> exercise. This really wants to be done _after_ the loop.
>=20

As long as we=E2=80=99re confident that nothing after the loop can set the f=
lag again.

> Thanks,
>=20
>        tglx
