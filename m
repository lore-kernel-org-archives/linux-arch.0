From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] kconfig.h: remove config_enabled() macro
Date: Mon, 17 Oct 2016 11:10:08 +0900
Message-ID: <CAK7LNAQwhw9z0cuPyHVkwRYpyMFmmvVxZebkRnTrTi3dSxzJ0A@mail.gmail.com>
References: <1476616078-32252-1-git-send-email-yamada.masahiro@socionext.com> <2EDBA803-1A4D-41C1-98FD-FFC7DBFB48BB@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2EDBA803-1A4D-41C1-98FD-FFC7DBFB48BB@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.com>, X86 ML <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Thomas Garnier <thgarnie@google.com>
List-Id: linux-arch.vger.kernel.org

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
