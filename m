Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from condef004-v.nifty.com ([210.131.4.241]:35682 "EHLO
        condef004-v.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757212AbcJQCPW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 16 Oct 2016 22:15:22 -0400
Received: from conssluserg-04.nifty.com ([10.26.8.83])by condef004-v.nifty.com with ESMTP id u9H2CXDZ023097
        for <linux-arch@vger.kernel.org>; Mon, 17 Oct 2016 11:12:33 +0900
MIME-Version: 1.0
In-Reply-To: <2EDBA803-1A4D-41C1-98FD-FFC7DBFB48BB@zytor.com>
References: <1476616078-32252-1-git-send-email-yamada.masahiro@socionext.com> <2EDBA803-1A4D-41C1-98FD-FFC7DBFB48BB@zytor.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 17 Oct 2016 11:10:08 +0900
Message-ID: <CAK7LNAQwhw9z0cuPyHVkwRYpyMFmmvVxZebkRnTrTi3dSxzJ0A@mail.gmail.com>
Subject: Re: [PATCH] kconfig.h: remove config_enabled() macro
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.com>, X86 ML <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Thomas Garnier <thgarnie@google.com>
Message-ID: <20161017021008.FO05nxtPKeniXyVJzikLHMl_OD3fSeVyRvaHK-2FFlU@z>

Hi Peter.


2016-10-17 3:44 GMT+09:00  <hpa@zytor.com>:
>
> How is __is_defined() different from defined()?



defined() can be used only in pre-processor's #if context, like

    #if defined(FOO)
          ...
    #endif



__is_defined() can be used more flexibly.




-- 
Best Regards
Masahiro Yamada
