From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: io_uring vs in_compat_syscall()
Date: Mon, 20 Jul 2020 09:58:37 -0700
Message-ID: <BACE670C-6A65-4D86-BC5F-A7EA267C3140@amacapital.net>
References: <ceb21006-26d0-b216-84a9-5da0b89b5fbf@kernel.dk>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729409AbgGTQ6n (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jul 2020 12:58:43 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB79C061794
        for <linux-arch@vger.kernel.org>; Mon, 20 Jul 2020 09:58:43 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 207so9324655pfu.3
        for <linux-arch@vger.kernel.org>; Mon, 20 Jul 2020 09:58:43 -0700 (PDT)
In-Reply-To: <ceb21006-26d0-b216-84a9-5da0b89b5fbf@kernel.dk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, io-uring@vger.kernel.org


> On Jul 20, 2020, at 9:37 AM, Jens Axboe <axboe@kernel.dk> wrote:
>=20
> =EF=BB=BFOn 7/20/20 12:10 AM, Christoph Hellwig wrote:
>> Hi Jens,
>>=20
>> I just found a (so far theoretical) issue with the io_uring submission
>> offloading to workqueues or threads.  We have lots of places using
>> in_compat_syscall() to check if a syscall needs compat treatmenet.
>> While the biggest users is iocttl(), we also have a fair amount of
>> places using in_compat_task() in read and write methods, and these
>> will not do the wrong thing when used with io_uring under certain
>> conditions.  I'm not sure how to best fix this, except for making sure
>> in_compat_syscall() returns true one way or another for these cases.
>=20
> We can probably propagate this information in the io_kiocb via a flag,
> and have the io-wq worker set TS_COMPAT if that's the case.
>=20

Is TS_COMPAT actually a cross-arch concept for which this is safe?  Having a=
 real arch helper for =E2=80=9Cset the current syscall arch for the current k=
ernel thread=E2=80=9D seems more sensible to me.=20=
