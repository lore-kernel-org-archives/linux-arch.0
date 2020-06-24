From: Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH 11/22] pci: lto: fix PREL32 relocations
Date: Wed, 24 Jun 2020 16:21:37 -0700
Message-ID: <20200624232137.GA243469@google.com>
References: <20200624203200.78870-12-samitolvanen@google.com>
 <202006250618.DQj64eMK%lkp@intel.com>
 <CAKwvOdnREuOmN_Vinn8pn6fxEpjzCM1_=9tDzbd2z884GNLFeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388711AbgFXXVp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 19:21:45 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C75C061573
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 16:21:44 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ev7so1436399pjb.2
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 16:21:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAKwvOdnREuOmN_Vinn8pn6fxEpjzCM1_=9tDzbd2z884GNLFeA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: kernel test robot <lkp@intel.com>, Masahiro Yamada <masahiroy@kernel.org>, Will Deacon <will@kernel.org>, kbuild-all@lists.01.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, Kees Cook <keescook@chromium.org>, clang-built-linux <clang-built-linux@googlegroups.com>, Kernel Hardening <kernel-hardening@lists.openwall.com>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Wed, Jun 24, 2020 at 04:03:48PM -0700, Nick Desaulniers wrote:
> On Wed, Jun 24, 2020 at 3:50 PM kernel test robot <lkp@intel.com> wrote:
> >
> > Hi Sami,
> >
> > Thank you for the patch! Perhaps something to improve:
> >
> > [auto build test WARNING on 26e122e97a3d0390ebec389347f64f3730fdf48f]
> >
> > url:    https://github.com/0day-ci/linux/commits/Sami-Tolvanen/add-support-for-Clang-LTO/20200625-043816
> > base:    26e122e97a3d0390ebec389347f64f3730fdf48f
> > config: i386-alldefconfig (attached as .config)
> > compiler: gcc-9 (Debian 9.3.0-13) 9.3.0
> > reproduce (this is a W=1 build):
> >         # save the attached .config to linux build tree
> >         make W=1 ARCH=i386
> 
> Note: W=1 ^
> 
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> >    In file included from arch/x86/kernel/pci-dma.c:9:
> > >> include/linux/compiler-gcc.h:72:45: warning: no previous prototype for '__UNIQUE_ID_via_no_dac190' [-Wmissing-prototypes]
> >       72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
> >          |                                             ^~~~~~~~~~~~
> >    include/linux/pci.h:1914:7: note: in definition of macro '___DECLARE_PCI_FIXUP_SECTION'
> >     1914 |  void stub(struct pci_dev *dev) { hook(dev); }   \
> >          |       ^~~~
> 
> Should `stub` be qualified as `static inline`? https://godbolt.org/z/cPBXxW
> Or should stub be declared in this header, but implemented in a .c
> file?  (I'm guessing the former, since the `hook` callback comes from
> the macro).

Does static inline guarantee that the compiler won't rename the symbol?
The purpose of this change is to have a stable symbol name, which we can
safely use in inline assembly.

Sami
