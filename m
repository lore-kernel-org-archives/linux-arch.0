Return-Path: <SRS0=MbEv=AF=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729867AbgFXUsQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 16:48:16 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11BDC061573
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:48:15 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id t6so2030845pgq.1
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:48:15 -0700 (PDT)
Date: Wed, 24 Jun 2020 13:48:13 -0700
From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v3 4/7] init: main: add KUnit to kernel init
Message-ID: <202006241345.43D22CB261@keescook>
References: <20200228012036.15682-5-brendanhiggins@google.com>
 <202003021439.A6B6FD8@keescook>
 <CAFd5g45Jz-5wtO-YNuqPN2Zc_rJtoA1qbPLVs2wrJFQyZpd5QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g45Jz-5wtO-YNuqPN2Zc_rJtoA1qbPLVs2wrJFQyZpd5QQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Brendan Higgins <brendanhiggins@google.com>
Cc: Frank Rowand <frowand.list@gmail.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Arnd Bergmann <arnd@arndb.de>, Shuah Khan <skhan@linuxfoundation.org>, Alan Maguire <alan.maguire@oracle.com>, Iurii Zaikin <yzaikin@google.com>, David Gow <davidgow@google.com>, Andrew Morton <akpm@linux-foundation.org>, rppt@linux.ibm.com, Greg KH <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@kernel.org>, Logan Gunthorpe <logang@deltatee.com>, Luis Chamberlain <mcgrof@kernel.org>, linux-um <linux-um@lists.infradead.org>, linux-arch@vger.kernel.org, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, KUnit Development <kunit-dev@googlegroups.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Message-ID: <20200624204813.twGM3Q47-1RDB_Fj4fsyuQS3HgFzbg9_SnqhuXBJb2s@z>

On Wed, Jun 24, 2020 at 01:20:35PM -0700, Brendan Higgins wrote:
> On Mon, Mar 2, 2020 at 2:45 PM Kees Cook <keescook@chromium.org> wrote:
> > Now, I realize kunit tests _should_ be self-contained, but this seems
> > like a possible robustness problem. Is there any reason this can't be
> > moved after rcu_end_inkernel_boot() in kernel_init() instead?
> 
> I tried that, but it doesn't work without an initramfs. We could add

I'm curious to know what happened. To me it looks like it would be
possible to do it in here:

        system_state = SYSTEM_RUNNING;
        numa_default_policy();

        rcu_end_inkernel_boot();

        do_sysctl_args();

	put it here?

        if (ramdisk_execute_command) {
                ret = run_init_process(ramdisk_execute_command);

That should be before anything happens with an initramfs. (i.e. boot the
kernel without an initrd and it won't be required...)

> an initramfs for KUnit at some point if highly desired, but I think
> that is outside the scope of this patchset. Additionally, this patch
> actually moves running tests to later in the init process, which is
> still an improvement over the way KUnit works today.

Later is better! :)

> There are some other reasons I wouldn't want to make that change right
> now, which will become apparent in a patch that I will send out in
> short order.

Cool; I'll look for it.

-- 
Kees Cook
