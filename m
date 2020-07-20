Return-Path: <SRS0=C7+S=A7=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729686AbgGTR26 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jul 2020 13:28:58 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FD1C0619D5
        for <linux-arch@vger.kernel.org>; Mon, 20 Jul 2020 10:28:58 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p3so10610880pgh.3
        for <linux-arch@vger.kernel.org>; Mon, 20 Jul 2020 10:28:58 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: io_uring vs in_compat_syscall()
Date: Mon, 20 Jul 2020 10:28:55 -0700
Message-ID: <8987E376-6B13-4798-BDBA-616A457447CF@amacapital.net>
References: <b754dad5-ee85-8a2f-f41a-8bdc56de42e8@kernel.dk>
In-Reply-To: <b754dad5-ee85-8a2f-f41a-8bdc56de42e8@kernel.dk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Message-ID: <20200720172855.w9FQJbtoNXAj-ZHNdbycDWJe-AMFVP3m2UN0t0lS7bw@z>



> On Jul 20, 2020, at 10:02 AM, Jens Axboe <axboe@kernel.dk> wrote:
>=20
> =EF=BB=BFOn 7/20/20 10:58 AM, Andy Lutomirski wrote:
>>=20
>>>> On Jul 20, 2020, at 9:37 AM, Jens Axboe <axboe@kernel.dk> wrote:
>>>=20
>>> =EF=BB=BFOn 7/20/20 12:10 AM, Christoph Hellwig wrote:
>>>> Hi Jens,
>>>>=20
>>>> I just found a (so far theoretical) issue with the io_uring submission
>>>> offloading to workqueues or threads.  We have lots of places using
>>>> in_compat_syscall() to check if a syscall needs compat treatmenet.
>>>> While the biggest users is iocttl(), we also have a fair amount of
>>>> places using in_compat_task() in read and write methods, and these
>>>> will not do the wrong thing when used with io_uring under certain
>>>> conditions.  I'm not sure how to best fix this, except for making sure
>>>> in_compat_syscall() returns true one way or another for these cases.
>>>=20
>>> We can probably propagate this information in the io_kiocb via a flag,
>>> and have the io-wq worker set TS_COMPAT if that's the case.
>>>=20
>>=20
>> Is TS_COMPAT actually a cross-arch concept for which this is safe?
>> Having a real arch helper for =E2=80=9Cset the current syscall arch for t=
he
>> current kernel thread=E2=80=9D seems more sensible to me.=20
>=20
> Sure, I'd consider that implementation detail for the actual patch(es)
> for this issue.

There=E2=80=99s a corner case, though: doesn=E2=80=99t io_uring submission f=
requently do the work synchronously in the context of the calling thread?  I=
f so, can a thread do a 64-bit submit with 32-bit work or vice versa?

Sometimes I think that in_compat_syscall() should have a mode in which calli=
ng it warns (e.g. not actually in a syscall when doing things in io_uring). =
 And the relevant operations should be properly wired up to avoid global sta=
te like this.

>=20
> --=20
> Jens Axboe
>=20
