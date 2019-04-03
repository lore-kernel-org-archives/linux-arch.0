From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Does vdso_install attempt to re-compile objects under root privilege?
Date: Wed, 3 Apr 2019 14:17:43 +0900
Message-ID: <CAK7LNAQwHRJL=3yD_7P2mMSVnwZbayww+dHC22+v4oTpMZv58w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, X86 ML <x86@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

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
