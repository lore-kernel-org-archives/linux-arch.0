Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36394 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfJYVfP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 25 Oct 2019 17:35:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id c22so3440718wmd.1
        for <linux-arch@vger.kernel.org>; Fri, 25 Oct 2019 14:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1571798507.git.thehajime@gmail.com>
In-Reply-To: <cover.1571798507.git.thehajime@gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Fri, 25 Oct 2019 23:34:59 +0200
Message-ID: <CAFLxGvyshYxocTNrzWV0mLQ-_qZzMG7u64=ySMbjrsu8j4cwTQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/47] Unifying LKL into UML
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, Octavian Purdila <tavi.purdila@gmail.com>, Akira Moroo <retrage01@gmail.com>, Linux-Arch <linux-arch@vger.kernel.org>

On Wed, Oct 23, 2019 at 6:39 AM Hajime Tazaki <thehajime@gmail.com> wrote:
>
> This RFC patchset is to ask opinions from UML people, whether LKL codes is
> good to integrate into UML code base.  We wish to have any kind of feedback
> from your kind reviews.  There are numbers of commits which should be asked
> for reviews to other mailing lists; we will do it later once we got
> discussed in this mailing list.

Thanks a lot for doing this, this effort is much appreciated! :-)

> # sorry for the long list of patches: we can make it smaller by only
>   including basic set of LKL (e.g., removing foreign OS support, etc) if
>   you wish.

Let use see how the review goes. First I'll give it a high level review to make
sure we all talk about the same things.

Please CC linux-arch@vger.kernel.org for the next patch round.
Integrating LKL (into arch/um/) is something which needs more audience and
feedback from Arnd Bergmann, our global arch maintainer.


>
>
> LKL (Linux Kernel Library) is aiming to allow reusing the Linux kernel code
> as extensively as possible with minimal effort and reduced maintenance
> overhead.
>
> Examples of how LKL can be used are: creating userspace applications
> (running on Linux and other operating systems) that can read or write Linux
> filesystems or can use the Linux networking stack, creating kernel drivers
> for other operating systems that can read Linux filesystems, bootloaders
> support for reading/writing Linux filesystems, etc.
>
> With LKL, the kernel code is compiled into an object file that can be
> directly linked by applications. The API offered by LKL is based on the
> Linux system call interface.
>
> LKL is originally implemented as an architecture port in arch/lkl, but this
> series of commits tries to integrate this into arch/um as one of the mode
> of UML.  This was discussed during RFC email of LKL (*1).
>
> The latest LKL version can be found at https://github.com/lkl/linux
>
> Milestone
> =========
> This patches is just a first step toward upstreaming *library mode* of
> Linux kernel, but we think we need to have several steps toward our goal,
> describing in the below.
>
> 1. Put LKL code under arch/um (arch/um/lkl), and build it in a
> separate way from UML.

Makes sense.

> 2. Share common parts of implementation between UML and LKL.

Since both UML and LKL are usermode ports there is a lot of potential.
