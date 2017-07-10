From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v2 00/28] kbuild: complete UAPI de-coupling and cleanup
 scripts/Makefile.headersinst
Date: Mon, 10 Jul 2017 10:42:08 +0200
Message-ID: <20170710084208.GA25874@ravnborg.org>
References: <1499625180-8067-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1499625180-8067-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hi Masahiro.

On Mon, Jul 10, 2017 at 03:32:32AM +0900, Masahiro Yamada wrote:
> In v4.12-rc1, we had a big progress for headers_install.
> All (and only) headers under UAPI directories are exported.
> However, asm-generic wrappers are still exceptions because
> most of arch/*/include/asm/Kbuild include "generic-y" for
> exported headers.  As a result, many of generic-wrappers to be
> exported are generated outside UAPI directories.
> 
> To finish de-coupling UAPI, "generic-y" for exported headers
> should be moved to arch/*/include/uapi/asm/Kbuild.
> 
> With those cleanups, the logic of headers_install will become
> even simpler.  UAPI will be completely self-contained.
> 
> This series is based on:
> commit 19bf2e0ef18ec8a7284ecc83459a2664cb885cd5
> 
> Changes for v2:
>   - rebase on the latest in the mainline in order to avoid merge conflicts

Series looks good.

In several of your patches assignments are moved to the arch
specific uapi file, but the same assignment are already present in
include/uapi/asm-generic/Kbuild.asm so the assignment is redundant.

For example:
$ARCH uapi Kbuild:
generic-y += errno.h

uapi/asm-generic Kbuild:
mandatory-y += errno.h

As this patch-set is touching all arch files this
could be a good opportunity to clean this up too.

But maybe mandatory-y and generic-y do something different,
and both are needed. In wich cases all is good.

	Sam
