Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vs1-f66.google.com ([209.85.217.66]:43553 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbfDRML5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Apr 2019 08:11:57 -0400
Received: by mail-vs1-f66.google.com with SMTP id t23so1005086vso.10
        for <linux-arch@vger.kernel.org>; Thu, 18 Apr 2019 05:11:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190418084119.056416939@linutronix.de> <20190418084254.361284697@linutronix.de>
 <CAG_fn=WP9+bVv9hedoaTzWK+xBzedxaGJGVOPnF0o115s-oWvg@mail.gmail.com> <alpine.DEB.2.21.1904181353420.3174@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1904181353420.3174@nanos.tec.linutronix.de>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 18 Apr 2019 14:11:44 +0200
Message-ID: <CAG_fn=WL0yLqavV_mhodT=B6KcAzJ+LS0hss1jqany9Cn92RHw@mail.gmail.com>
Subject: Re: [patch V2 14/29] dm bufio: Simplify stack trace retrieval
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>, Alasdair Kergon <agk@redhat.com>, Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Pekka Enberg <penberg@kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, Catalin Marinas <catalin.marinas@arm.com>, Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, kasan-dev <kasan-dev@googlegroups.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Akinobu Mita <akinobu.mita@gmail.com>, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Johannes Thumshirn <jthumshirn@suse.de>, David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org, intel-gfx@lists.freedesktop.org, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>, Jani Nikula <jani.nikula@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>, Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-arch@vger.kernel.org
Message-ID: <20190418121144.LNd5b6hFGrMGa75fG45XW7CNDASM1RWBcwkz70RjDcU@z>

On Thu, Apr 18, 2019 at 1:54 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Thu, 18 Apr 2019, Alexander Potapenko wrote:
> > On Thu, Apr 18, 2019 at 11:06 AM Thomas Gleixner <tglx@linutronix.de> w=
rote:
> > > -       save_stack_trace(&b->stack_trace);
> > > +       b->stack_len =3D stack_trace_save(b->stack_entries, MAX_STACK=
, 2);
> > As noted in one of similar patches before, can we have an inline
> > comment to indicate what does this "2" stand for?
>
> Come on. We have gazillion of functions which take numerical constant
> arguments. Should we add comments to all of them?
Ok, sorry. I might not be familiar enough with the kernel style guide.
> Thanks,
>
>         tglx



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
