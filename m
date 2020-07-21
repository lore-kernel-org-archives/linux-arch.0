Return-Path: <SRS0=7mXE=BA=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728600AbgGUObQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Jul 2020 10:31:16 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F9C920717
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 14:31:15 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id z2so21469965wrp.2
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 07:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <b754dad5-ee85-8a2f-f41a-8bdc56de42e8@kernel.dk>
 <8987E376-6B13-4798-BDBA-616A457447CF@amacapital.net> <20200721070709.GB11432@lst.de>
In-Reply-To: <20200721070709.GB11432@lst.de>
From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 21 Jul 2020 07:31:02 -0700
Message-ID: <CALCETrXWZBXZuCeRYvYY8AWG51e_P3bOeNeqc8zXPLOTDTHY0g@mail.gmail.com>
Subject: Re: io_uring vs in_compat_syscall()
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-arch <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, io-uring@vger.kernel.org
Message-ID: <20200721143102.wA1fXQErnrJxUFbqjZZQ5zgrAP-_twSh6c2qSFZcTM4@z>

On Tue, Jul 21, 2020 at 12:07 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Jul 20, 2020 at 10:28:55AM -0700, Andy Lutomirski wrote:
> > > Sure, I'd consider that implementation detail for the actual patch(es=
)
> > > for this issue.
> >
> > There=E2=80=99s a corner case, though: doesn=E2=80=99t io_uring submiss=
ion frequently do the work synchronously in the context of the calling thre=
ad?
>
> Yes.
>
> > If so, can a thread do a 64-bit submit with 32-bit work or vice versa?
>
> In theory you could share an fd created in a 32-bit thread to a 64-bit
> thread or vice versa, but I think at that point you absolutely are in
> "you get to keep the pieces" land.

That seems potentially okay as long as these are pieces of userspace
and not pieces of the kernel.  If the kernel freaks out, we have a
problem.

>
> > Sometimes I think that in_compat_syscall() should have a mode in which =
calling it warns (e.g. not actually in a syscall when doing things in io_ur=
ing).  And the relevant operations should be properly wired up to avoid glo=
bal state like this.
>
> What do you mean with "properly wired up".  Do you really want to spread
> ->compat_foo methods everywhere, including read and write?  I found
> in_compat_syscall() a lot small and easier to maintain than all the
> separate compat cruft.

I was imagining using a flag.  Some of the net code uses
MSG_CMSG_COMPAT for this purpose.

--Andy
