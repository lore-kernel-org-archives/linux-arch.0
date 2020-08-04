From: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v5 09/12] kunit: test: add test plan to KUnit TAP format
Date: Tue, 4 Aug 2020 13:10:59 -0700
Message-ID: <CAFd5g45HeXUBVNW31ZYgpqhYOOu=1jwK_LKZQUOO_6mGaqtSUA@mail.gmail.com>
References: <20200626210917.358969-1-brendanhiggins@google.com>
 <20200626210917.358969-10-brendanhiggins@google.com> <202006261434.119AE33DBB@keescook>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgHDULL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Aug 2020 16:11:11 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D674C06179E
        for <linux-arch@vger.kernel.org>; Tue,  4 Aug 2020 13:11:11 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id 2so3147516pjx.5
        for <linux-arch@vger.kernel.org>; Tue, 04 Aug 2020 13:11:11 -0700 (PDT)
In-Reply-To: <202006261434.119AE33DBB@keescook>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Arnd Bergmann <arnd@arndb.de>, Shuah Khan <skhan@linuxfoundation.org>, Alan Maguire <alan.maguire@oracle.com>, Iurii Zaikin <yzaikin@google.com>, David Gow <davidgow@google.com>, Andrew Morton <akpm@linux-foundation.org>, rppt@linux.ibm.com, Frank Rowand <frowand.list@gmail.com>, catalin.marinas@arm.com, will@kernel.org, Michal Simek <monstr@monstr.eu>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Chris Zankel <chris@zankel.net>, jcmvbkbc@gmail.com, Greg KH <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@kernel.org>, Logan Gunthorpe <logang@deltatee.com>

On Fri, Jun 26, 2020 at 2:35 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Jun 26, 2020 at 02:09:14PM -0700, Brendan Higgins wrote:
> > TAP 14 allows an optional test plan to be emitted before the start of
> > the start of testing[1]; this is valuable because it makes it possible
> > for a test harness to detect whether the number of tests run matches the
> > number of tests expected to be run, ensuring that no tests silently
> > failed.
> >
> > Link[1]: https://github.com/isaacs/testanything.github.io/blob/tap14/tap-version-14-specification.md#the-plan
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
>
> Look good, except...
>
> > diff --git a/tools/testing/kunit/test_data/test_is_test_passed-all_passed.log b/tools/testing/kunit/test_data/test_is_test_passed-all_passed.log
> > index 62ebc0288355c4b122ccc18ae2505f971efa57bc..bc0dc8fe35b760b1feb74ec419818dbfae1adb5c 100644
> > GIT binary patch
> > delta 28
> > jcmbQmGoME|#4$jjEVZaOGe1wk(1goSPtRy09}gP<dC~`u
> >
> > delta 23
> > ecmbQwGmD2W#4$jjEVZaOGe1wk&}5@94;uhhkp{*9
> >
> > diff --git a/tools/testing/kunit/test_data/test_is_test_passed-crash.log b/tools/testing/kunit/test_data/test_is_test_passed-crash.log
> > index 0b249870c8be417a5865bd40a24c8597bb7f5ab1..4d97f6708c4a5ad5bb2ac879e12afca6e816d83d 100644
> > GIT binary patch
> > delta 15
> > WcmX>hepY;fFN>j`p3z318g2k9Uj*m?
> >
> > delta 10
> > RcmX>renNbL@5Z2NZU7lr1S$Xk
> >
> > diff --git a/tools/testing/kunit/test_data/test_is_test_passed-failure.log b/tools/testing/kunit/test_data/test_is_test_passed-failure.log
> > index 9e89d32d5667a59d137f8adacf3a88fdb7f88baf..7a416497e3bec044eefc1535f7d84ee85703ba97 100644
> > GIT binary patch
> > delta 28
> > jcmZ3&yOLKp#4$jjEVZaOGe1wk(1goSPtRy0-!wJ=eKrU$
> >
> > delta 23
> > ecmZ3<yM&i7#4$jjEVZaOGe1wk&}5_VG&TTPhX-Z=
>
> What is happening here?? Those logs appear as text to me. Why did git
> freak out?

That's because this is all test data; it's all plaintext, but out of
necessity some of the test data is kind of munged up and causes
checkpatch to complain, so Shuah asked us to mark it as binary since
it isn't actually code and so checkpatch will stop flagging it.
