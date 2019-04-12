Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vs1-f66.google.com ([209.85.217.66]:35029 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfDLAte (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 Apr 2019 20:49:34 -0400
MIME-Version: 1.0
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
 <20190213091936.GA22829@shao2-debian> <CAHk-=wiF2qv4TdKOTaTYeMnmsn4h6z9ot+MRj1=s7dm5y1FUwQ@mail.gmail.com>
 <CAC=cRTM5=e7rJX80m0vL10aQoLawK_VTnQubH8A7_sUO2VUCNA@mail.gmail.com> <cc8af095-50e0-cd3e-e498-8c3350d314b7@redhat.com>
In-Reply-To: <cc8af095-50e0-cd3e-e498-8c3350d314b7@redhat.com>
From: huang ying <huang.ying.caritas@gmail.com>
Date: Fri, 12 Apr 2019 08:49:21 +0800
Message-ID: <CAC=cRTP38JmFWe8C=y6ew_m1Lswb8DghnqLtdiMc0EW_fyPH7g@mail.gmail.com>
Subject: Re: [PATCH-tip 00/22] locking/rwsem: Rework rwsem-xadd & enable new
 rwsem features
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Chen Rong <rong.a.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>, "IngoMolnar@shao2-debian" <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Linux-sh list <linux-sh@vger.kernel.org>, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch <linux-arch@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Davidlohr Bueso <dave@stgolabs.net>, Andrew Morton <akpm@linux-foundation.org>, Tim Chen <tim.c.chen@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20190412004921.Ymvczi884b01bx7gv0ihdcAbDH5cBnrpKJxK9oML-3w@z>

On Thu, Apr 11, 2019 at 12:08 AM Waiman Long <longman@redhat.com> wrote:
>
> On 04/10/2019 04:15 AM, huang ying wrote:
> > Hi, Waiman,
> >
> > What's the status of this patchset?  And its merging plan?
> >
> > Best Regards,
> > Huang, Ying
>
> I have broken the patch into 3 parts (0/1/2) and rewritten some of them.
> Part 0 has been merged into tip. Parts 1 and 2 are still under testing.

Thanks!  Please keep me updated!

Best Regards,
Huang, Ying

> Cheers,
> Longman
>
