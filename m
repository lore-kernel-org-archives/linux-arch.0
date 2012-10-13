From: guanxuetao@mprc.pku.edu.cn
Subject: Re: [PATCH 23/25] unicore32: Use Kbuild infrastructure for
     kvm_para.h
Date: Sat, 13 Oct 2012 20:27:43 +0800 (CST)
Message-ID: <4190.124.205.227.162.1350131263.squirrel@mprc.pku.edu.cn>
References: <20121013022632.024527228@goodmis.org>
    <20121013022955.738395112@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain;charset=GB2312
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mprc.pku.edu.cn ([162.105.203.9]:55867 "EHLO mprc.pku.edu.cn"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752551Ab2JMMNh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 13 Oct 2012 08:13:37 -0400
In-Reply-To: <20121013022955.738395112@goodmis.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>

> From: Steven Rostedt <srostedt@redhat.com>
>
> All the headers but kvm_para.h use the Kbuild infrastructure to
> get to the asm-generic headers.

I merged the uapi patch for unicore32.
In that patch, kvm_para.h was moved to
arch/unicore32/include/uapi/asm/kvm_para.h.
Anyway, I'd like to apply this patch based on uapi modification.

Thanks & Regards,
Guan Xuetao

>
> Cc: linux-kbuild@vger.kernel.org
> Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>  arch/unicore32/include/asm/Kbuild     |    1 +
>  arch/unicore32/include/asm/kvm_para.h |    1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  delete mode 100644 arch/unicore32/include/asm/kvm_para.h
>
> diff --git a/arch/unicore32/include/asm/Kbuild
> b/arch/unicore32/include/asm/Kbuild
> index c910c98..15b47f2 100644
> --- a/arch/unicore32/include/asm/Kbuild
> +++ b/arch/unicore32/include/asm/Kbuild
> @@ -24,6 +24,7 @@ generic-y += ipcbuf.h
>  generic-y += irq_regs.h
>  generic-y += kdebug.h
>  generic-y += kmap_types.h
> +generic-y += kvm_para.h
>  generic-y += local.h
>  generic-y += mman.h
>  generic-y += module.h
> diff --git a/arch/unicore32/include/asm/kvm_para.h
> b/arch/unicore32/include/asm/kvm_para.h
> deleted file mode 100644
> index 14fab8f..0000000
> --- a/arch/unicore32/include/asm/kvm_para.h
> +++ /dev/null
> @@ -1 +0,0 @@
> -#include <asm-generic/kvm_para.h>
> --
> 1.7.10.4
>
>
