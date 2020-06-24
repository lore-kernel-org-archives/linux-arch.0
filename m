Return-Path: <SRS0=MbEv=AF=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405057AbgFXVwh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 17:52:37 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5C4C061795
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 14:52:37 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x8so792907plm.10
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 14:52:37 -0700 (PDT)
Date: Wed, 24 Jun 2020 14:52:31 -0700
From: Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH 17/22] arm64: vdso: disable LTO
Message-ID: <20200624215231.GC120457@google.com>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200624203200.78870-18-samitolvanen@google.com>
 <CAKwvOdnEbCfYZ9o=OF51oswyqDvN4iP-9syWUDhxfueq4q0xcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnEbCfYZ9o=OF51oswyqDvN4iP-9syWUDhxfueq4q0xcw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, Kees Cook <keescook@chromium.org>, clang-built-linux <clang-built-linux@googlegroups.com>, Kernel Hardening <kernel-hardening@lists.openwall.com>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Message-ID: <20200624215231.JrrhRQAfIMVNe7e1Y5a334xE3zMFuZppdJ0wOj_CfuY@z>

On Wed, Jun 24, 2020 at 01:58:57PM -0700, 'Nick Desaulniers' via Clang Built Linux wrote:
> On Wed, Jun 24, 2020 at 1:33 PM Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > Filter out CC_FLAGS_LTO for the vDSO.
> 
> Just curious about this patch (and the following one for x86's vdso),
> do you happen to recall specifically what the issues with the vdso's
> are?

I recall the compiler optimizing away functions at some point, but as
LTO is not really needed in the vDSO, it's just easiest to disable it
there.

Sami
