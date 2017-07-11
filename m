From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH v2 18/28] nios2: move generic-y of exported headers to
 uapi/asm/Kbuild
Date: Tue, 11 Jul 2017 11:20:08 +0200
Message-ID: <20170711092008.GH5851@distanz.ch>
References: <1499625180-8067-1-git-send-email-yamada.masahiro@socionext.com>
 <1499625180-8067-19-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from sym2.noone.org ([178.63.92.236]:52649 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751130AbdGKJUL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 Jul 2017 05:20:11 -0400
Content-Disposition: inline
In-Reply-To: <1499625180-8067-19-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On 2017-07-09 at 20:32:50 +0200, Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
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
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Tobias Klauser <tklauser@distanz.ch>

Looks good, thanks!
