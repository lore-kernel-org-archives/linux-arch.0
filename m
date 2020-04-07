From: Octavian Purdila <tavi.purdila@gmail.com>
Subject: Re: [RFC v4 02/25] um lkl: architecture skeleton for Linux kernel library
Date: Tue, 7 Apr 2020 22:25:27 +0300
Message-ID: <CAMoF9u11mUvOO6NZoEq9Hu=ndOz_2he3Mjb2dEpCEAT6fk_CjQ@mail.gmail.com>
References: <cover.1585579244.git.thehajime@gmail.com> <dca6ea7260830a03c060f57e6ab9961f16ad55ed.1585579244.git.thehajime@gmail.com>
 <a84f3d7bcddbaa6125349c4bcdec6e3e07d6b783.camel@sipsolutions.net>
 <CAFLxGvyFqXZSmMcD_=o81AHLzdM_u2iH8h412w7VZrxON7Ohig@mail.gmail.com>
 <m21rp9xaqt.wl-thehajime@gmail.com> <ba2199bd17b6457c97305f6688b13ed36e7feac3.camel@sipsolutions.net>
 <m2tv22wfmr.wl-thehajime@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f179.google.com ([209.85.208.179]:45210 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgDGTZl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Apr 2020 15:25:41 -0400
Received: by mail-lj1-f179.google.com with SMTP id t17so4998847ljc.12
        for <linux-arch@vger.kernel.org>; Tue, 07 Apr 2020 12:25:39 -0700 (PDT)
In-Reply-To: <m2tv22wfmr.wl-thehajime@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, Richard Weinberger <richard.weinberger@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, Levente Kurusa <levex@linux.com>, Matthieu Coudron <mattator@gmail.com>, cem <cem@freebsd.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Jens Staal <staal1978@gmail.com>, Motomu Utsumi <motomuman@gmail.com>, linux-um <linux-um@lists.infradead.org>, Akira Moroo <retrage01@gmail.com>, Petros Angelatos <petrosagg@gmail.com>, Yuan Liu <liuyuan@google.com>, Mark Stillwell <mark@stillwell.me>, pscollins <pscollins@google.com>, linux-kernel-library <linux-kernel-library@freelists.org>, Pierre-Hugues Husson <phh@phh.me>, sigmaepsilon92 <sigmaepsilon92@gmail.com>, Luca Dariz <luca.dariz@gmail.com>

<snip>


> > And like I said before, that decision will frame everything else. I
> > really don't think we can make significant progress here without having
> > decided whether this is possible.
> >
> > Perhaps UML *can* become a "special case" of LKL, with a special API
> > function (that's not part of the syscall surface) to "boot(cmdline)" or
> > something. But if it can't, and has to remain as separated as the two
> > are today, I would argue we're better off just not calling them the sam=
e
> > architecture.
>
> I agree with this if the unification has all completed.
>

I tought a lot about this and I agree with Johannes that if we want to
unity UML and LKL we should start with the hard parts.

I am also starting to think that it is unlikely to be able to merge the
two "nicely" and that we should probably turn this on its head and start
with reworking UML towards the LKL features. We will end up
re-implementing *some* of the LKL concepts from scratch in UML but I
think at this point this is unavoidable.

Here are my thoughts on a very rough plan for doing that:

Milestone 1: LKL lib on top of UML
 * Kernel - Host build split
   Build UML as a relocatable object using the UML=E2=80=99s kernel linker
   script.
   Move the ptrace and other well isolated os code out of arch/um to
   tools/um (or maybe start directly with tools/lkl?)
   Use standard host toolchain to create a static library stripped of
   the ptrace code. Use standard host toolchain to build the main UML
   executable.
   Add library init API that creates the UML kernel process and starts
   UML.
* System calls APIs
   Add new system call interface dbased on fd irq.
   Use the LKL scripts to export the required headers to create system
   calls APIs that use the UML system calls infrastructure.
   Keep the underlying host and driver operations (threads, irqs, etc.)
   as they are now in UML.
 * Boot test
   Port the LKL boot test to verify that we are able to programatically
   issue system calls.

Milestone 2: add virtio disk support
 * Export asm/io.h operations to host/os. Create IO access operations
   and redirect them to weak os_ variants that use the current UML
   implementation.
 * Add the LKL IO access layer including generic virtio handling and the
   virtio block device code.
 * Port LKL disk test and disk apps (lklfuse, fs2tar, cptofs)

Milestone 3: new arch ports
  * Abstrac the system call / IRQ mode the move the implementation to host
  * Abstract the thread model and move the implementation to host
  * Add LKL thread model and LKL ports

Thanks,
Tavi
