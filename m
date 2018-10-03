Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39193 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbeJCMXS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Oct 2018 08:23:18 -0400
Received: by mail-wr1-f67.google.com with SMTP id 61-v6so3858062wrb.6
        for <linux-arch@vger.kernel.org>; Tue, 02 Oct 2018 22:36:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180921150351.20898-1-yu-cheng.yu@intel.com> <20180921150351.20898-25-yu-cheng.yu@intel.com>
 <20181003045611.GB22724@asgard.redhat.com>
In-Reply-To: <20181003045611.GB22724@asgard.redhat.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 2 Oct 2018 22:36:15 -0700
Message-ID: <CALCETrU-Ny-uC1NqRedQwNKe2MMhsFEqZ08TtHJwbLfCACMmLw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 24/27] mm/mmap: Create a guard area between VMAs
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eugene Syromiatnikov <esyr@redhat.com>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Balbir Singh <bsingharora@gmail.com>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Florian Weimer <fweimer@redhat.com>, "H. J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>
Message-ID: <20181003053615.klFdV_Wzm_UiopblpGS1AvEJnlmamUl39p_OzJw7xW4@z>

On Tue, Oct 2, 2018 at 9:55 PM Eugene Syromiatnikov <esyr@redhat.com> wrote:
>
> On Fri, Sep 21, 2018 at 08:03:48AM -0700, Yu-cheng Yu wrote:
> > Create a guard area between VMAs, to detect memory corruption.
>
> Do I understand correctly that with this patch a user space program
> no longer be able to place two mappings back to back? If it is so,
> it will likely break a lot of things; for example, it's a common ring
> buffer implementations technique, to map buffer memory twice back
> to back in order to avoid special handling of items wrapping its end.

I haven't checked what the patch actually does, but it shouldn't have
any affect on MAP_FIXED or the new no-replace MAP_FIXED variant.

--Andy
