Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34019 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754467AbdGJUVy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jul 2017 16:21:54 -0400
Date: Tue, 11 Jul 2017 05:21:50 +0900
From: Stafford Horne <shorne@gmail.com>
Subject: Re: [PATCH v2 19/28] openrisc: move generic-y of exported headers to
 uapi/asm/Kbuild
Message-ID: <20170710202150.GA2600@lianli.shorne-pla.net>
References: <1499625180-8067-1-git-send-email-yamada.masahiro@socionext.com>
 <1499625180-8067-20-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1499625180-8067-20-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20170710202150.nBPArgMItWCe3I46Yp_-cmqRlHYNrpWqOaavSv0_cnc@z>

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
