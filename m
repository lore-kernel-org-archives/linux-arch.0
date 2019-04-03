Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conssluserg-01.nifty.com ([210.131.2.80]:38337 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbfDCFSa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Apr 2019 01:18:30 -0400
MIME-Version: 1.0
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 3 Apr 2019 14:17:43 +0900
Message-ID: <CAK7LNAQwHRJL=3yD_7P2mMSVnwZbayww+dHC22+v4oTpMZv58w@mail.gmail.com>
Subject: Does vdso_install attempt to re-compile objects under root privilege?
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, X86 ML <x86@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Message-ID: <20190403051743.0FU5bv5Sur_vDLIwW0Yy5HNwWH6-qDf-piw1CZ2-MHU@z>

Hi.

I have a question about 'vdso_install'.


In my understanding, vdso is embedded in the kernel.
In addition, you can run 'make vdso_install'
to install an unstripped version of vdso.
(Mainly, debugging purpose?)

By default, 'make vdso_install' will install it to
/lib/modules/$(uname -r)/vdso/.


Since that directly is owned by root,
'make vdso_install' could potentially be
executed by root, isn't it?


Currently, 'vdso_install' depends on vdso,
so it may cause recompilation of objects
in the source tree.


This violates the basic rule:
"Installation targets must not modify the source tree".

We often miss this point. For example, see
commit 19514fc665ffbce624785f76ee7ad0ea6378a527


If this is a problem, I will fix Makefiles to
make 'vdso_install' not depend on vdso

Thanks.


-- 
Best Regards
Masahiro Yamada
