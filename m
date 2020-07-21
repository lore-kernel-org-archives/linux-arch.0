Return-Path: <SRS0=7mXE=BA=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729107AbgGURZh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Jul 2020 13:25:37 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B01A22BEF
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 17:25:37 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id z2so22017089wrp.2
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 10:25:37 -0700 (PDT)
MIME-Version: 1.0
References: <b754dad5-ee85-8a2f-f41a-8bdc56de42e8@kernel.dk>
 <8987E376-6B13-4798-BDBA-616A457447CF@amacapital.net> <20200721070709.GB11432@lst.de>
 <CALCETrXWZBXZuCeRYvYY8AWG51e_P3bOeNeqc8zXPLOTDTHY0g@mail.gmail.com> <20200721143412.GA8099@lst.de>
In-Reply-To: <20200721143412.GA8099@lst.de>
From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 21 Jul 2020 10:25:24 -0700
Message-ID: <CALCETrWMQpKe7jqw2t39yn4HgGhGTSEFGK6MPR4wPs=tBBhjbg@mail.gmail.com>
Subject: Re: io_uring vs in_compat_syscall()
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andy Lutomirski <luto@kernel.org>, Jens Axboe <axboe@kernel.dk>, linux-arch <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, io-uring@vger.kernel.org
Message-ID: <20200721172524.FDAF2Wds9PkCA6xIKNmfUaomtrAqx8t_oFvVY9Y-xz0@z>

On Tue, Jul 21, 2020 at 7:34 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Jul 21, 2020 at 07:31:02AM -0700, Andy Lutomirski wrote:
> > > What do you mean with "properly wired up".  Do you really want to spread
> > > ->compat_foo methods everywhere, including read and write?  I found
> > > in_compat_syscall() a lot small and easier to maintain than all the
> > > separate compat cruft.
> >
> > I was imagining using a flag.  Some of the net code uses
> > MSG_CMSG_COMPAT for this purpose.
>
> Killing that nightmarish monster is what actually got me into looking
> io_uring and starting this thread.

I agree that MSG_CMSG_COMPAT is nasty, but I think the concept is
sound -- rather than tracking whether we're compat by using a
different function or a per-thread variable, actually explicitly
tracking the mode seems sensible.

If we're going to play in_compat_syscall() games, let's please make
io_uring_enter() return -EINVAL if in_compat_syscall() != ctx->compat.

--Andy
