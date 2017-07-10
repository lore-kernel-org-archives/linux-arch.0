From: Stafford Horne <shorne@gmail.com>
Subject: Re: [PATCH v2 19/28] openrisc: move generic-y of exported headers to
 uapi/asm/Kbuild
Date: Tue, 11 Jul 2017 05:21:50 +0900
Message-ID: <20170710202150.GA2600@lianli.shorne-pla.net>
References: <1499625180-8067-1-git-send-email-yamada.masahiro@socionext.com>
 <1499625180-8067-20-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1499625180-8067-20-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Jul 10, 2017 at 03:32:51AM +0900, Masahiro Yamada wrote:
> Since commit fcc8487d477a ("uapi: export all headers under uapi
> directories"), all (and only) headers under uapi directories are
> exported, but asm-generic wrappers are still exceptions.
> 
> To complete de-coupling the uapi from kernel headers, move generic-y
> of exported headers to uapi/asm/Kbuild.
> 
> With this change, "make headers_install" will just need to parse
> uapi/asm/Kbuild to build up exported headers.
> 
> Also, move "generic-y += kprobes.h" up in order to keep the entries
> sorted.

Thanks this looks good.

Acked-by: Stafford Horne <shorne@gmail.com>

> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

