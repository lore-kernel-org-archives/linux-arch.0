From: Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v2] arch: split MODULE_ARCH_VERMAGIC definitions out to <asm/vermagic.h>
Date: Thu, 23 Apr 2020 01:06:26 +0900
Message-ID: <CAK7LNAQ-WcKf1QDOnefjkzg7Cq1fKNuEPDvH9TYU8tLwbUhtmg@mail.gmail.com>
References: <20200421161355.1357112-1-masahiroy@kernel.org> <20200422131729.GB20103@linux-8ccs>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200422131729.GB20103@linux-8ccs>
Sender: linux-kernel-owner@vger.kernel.org
To: Jessica Yu <jeyu@kernel.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@suse.de>
List-Id: linux-arch.vger.kernel.org

On Wed, Apr 22, 2020 at 10:17 PM Jessica Yu <jeyu@kernel.org> wrote:
>
> +++ Masahiro Yamada [22/04/20 01:13 +0900]:
> [snip]
> >diff --git a/arch/xtensa/include/asm/module.h b/arch/xtensa/include/asm/vermagic.h
> >similarity index 72%
> >rename from arch/xtensa/include/asm/module.h
> >rename to arch/xtensa/include/asm/vermagic.h
> >index 488b40c6f9b9..6f9e359a54ac 100644
> >--- a/arch/xtensa/include/asm/module.h
> >+++ b/arch/xtensa/include/asm/vermagic.h
> >@@ -1,6 +1,4 @@
> > /*
> >- * include/asm-xtensa/module.h
> >- *
> >  * This file contains the module code specific to the Xtensa architecture.
>
> Maybe we can remove this comment too? Since it's now asm/vermagic.h and
> not asm/module.h anymore.

OK, I will delete it.

Thanks for checking it closely.




>
> Thanks for the cleanup. I agree that <linux/vermagic.h> shouldn't have
> any ordering dependency on <linux/module.h>.
>
> I just double checked to see if there were any other users of
> MODULE_ARCH_VERMAGIC that needed it through module.h, and there are
> none. It was literally just being defined in asm/module.h to be used
> in linux/vermagic.h. So there was no reason really to confine the
> MODULE_ARCH_VERMAGIC definition to asm/module.h.
>
> Acked-by: Jessica Yu <jeyu@kernel.org>



-- 
Best Regards
Masahiro Yamada
