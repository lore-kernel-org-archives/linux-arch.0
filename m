Return-Path: <SRS0=8toe=6G=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgDVNRe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Apr 2020 09:17:34 -0400
Date: Wed, 22 Apr 2020 15:17:29 +0200
From: Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH v2] arch: split MODULE_ARCH_VERMAGIC definitions out to
 <asm/vermagic.h>
Message-ID: <20200422131729.GB20103@linux-8ccs>
References: <20200421161355.1357112-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200421161355.1357112-1-masahiroy@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>
Message-ID: <20200422131729.ezuNcfabXE5wvOsOp0XGxtCxqBM4CbePVU_kbXB_2PE@z>

+++ Masahiro Yamada [22/04/20 01:13 +0900]:
[snip]
>diff --git a/arch/xtensa/include/asm/module.h b/arch/xtensa/include/asm/vermagic.h
>similarity index 72%
>rename from arch/xtensa/include/asm/module.h
>rename to arch/xtensa/include/asm/vermagic.h
>index 488b40c6f9b9..6f9e359a54ac 100644
>--- a/arch/xtensa/include/asm/module.h
>+++ b/arch/xtensa/include/asm/vermagic.h
>@@ -1,6 +1,4 @@
> /*
>- * include/asm-xtensa/module.h
>- *
>  * This file contains the module code specific to the Xtensa architecture.

Maybe we can remove this comment too? Since it's now asm/vermagic.h and
not asm/module.h anymore.

Thanks for the cleanup. I agree that <linux/vermagic.h> shouldn't have
any ordering dependency on <linux/module.h>.

I just double checked to see if there were any other users of
MODULE_ARCH_VERMAGIC that needed it through module.h, and there are
none. It was literally just being defined in asm/module.h to be used
in linux/vermagic.h. So there was no reason really to confine the
MODULE_ARCH_VERMAGIC definition to asm/module.h.

Acked-by: Jessica Yu <jeyu@kernel.org>
