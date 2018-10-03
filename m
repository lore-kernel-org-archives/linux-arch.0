Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727197AbeJCXIP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 Oct 2018 19:08:15 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 539AE214D5
        for <linux-arch@vger.kernel.org>; Wed,  3 Oct 2018 16:19:11 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id y140-v6so7531605wmd.0
        for <linux-arch@vger.kernel.org>; Wed, 03 Oct 2018 09:19:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180921150351.20898-1-yu-cheng.yu@intel.com> <20180921150351.20898-25-yu-cheng.yu@intel.com>
 <20181003045611.GB22724@asgard.redhat.com> <CALCETrU-Ny-uC1NqRedQwNKe2MMhsFEqZ08TtHJwbLfCACMmLw@mail.gmail.com>
 <5ddb0ad33298d1858e530fce9c9ea2788b2fac81.camel@intel.com>
In-Reply-To: <5ddb0ad33298d1858e530fce9c9ea2788b2fac81.camel@intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 3 Oct 2018 09:18:57 -0700
Message-ID: <CALCETrVNp4Emx6z-+boE6_rhxi75pyA7O0Ay9sDDikX-VUWa0Q@mail.gmail.com>
Subject: Re: [RFC PATCH v4 24/27] mm/mmap: Create a guard area between VMAs
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: Eugene Syromiatnikov <esyr@redhat.com>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Balbir Singh <bsingharora@gmail.com>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Florian Weimer <fweimer@redhat.com>, "H. J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>
Message-ID: <20181003161857.m376idvf-kxI-ZVNVUgjRrLDBhSaeNd-4X93OTHwZBU@z>

On Wed, Oct 3, 2018 at 9:06 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> On Tue, 2018-10-02 at 22:36 -0700, Andy Lutomirski wrote:
> > On Tue, Oct 2, 2018 at 9:55 PM Eugene Syromiatnikov <esyr@redhat.com> wrote:
> > >
> > > On Fri, Sep 21, 2018 at 08:03:48AM -0700, Yu-cheng Yu wrote:
> > > > Create a guard area between VMAs, to detect memory corruption.
> > >
> > > Do I understand correctly that with this patch a user space program
> > > no longer be able to place two mappings back to back? If it is so,
> > > it will likely break a lot of things; for example, it's a common ring
> > > buffer implementations technique, to map buffer memory twice back
> > > to back in order to avoid special handling of items wrapping its end.
> >
> > I haven't checked what the patch actually does, but it shouldn't have
> > any affect on MAP_FIXED or the new no-replace MAP_FIXED variant.
> >
> > --Andy
>
> I did some mmap tests with/without MAP_FIXED, and it works as intended.
> In addition to the ring buffer, are there other test cases?
>

Various ELF loaders, perhaps?  Do they use MAP_FIXED or do they just
use address hints?
