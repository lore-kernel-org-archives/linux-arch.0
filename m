From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3 7/8] uapi: export all headers under uapi directories
Date: Mon, 23 Jan 2017 20:00:19 +1100
Message-ID: <878tq2b17g.fsf@concordia.ellerman.id.au>
References: <3131144.4Ej3KFWRbz@wuerfel> <1484304406-10820-1-git-send-email-nicolas.dichtel@6wind.com> <1484304406-10820-8-git-send-email-nicolas.dichtel@6wind.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <1484304406-10820-8-git-send-email-nicolas.dichtel@6wind.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

Nicolas Dichtel <nicolas.dichtel@6wind.com> writes:

> Regularly, when a new header is created in include/uapi/, the developer
> forgets to add it in the corresponding Kbuild file. This error is usually
> detected after the release is out.
>
> In fact, all headers under uapi directories should be exported, thus it's
> useless to have an exhaustive list.
>
> After this patch, the following files, which were not exported, are now
> exported (with make headers_install_all):
...
> asm-powerpc/perf_regs.h
...
>  arch/powerpc/include/uapi/asm/Kbuild        |  45 ---

Thanks for cleaning it up.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)


cheers
