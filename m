Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:32768 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751494AbdFLMJ2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Jun 2017 08:09:28 -0400
Date: Mon, 12 Jun 2017 13:09:24 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 04/27] arm64: move generic-y of exported headers to
 uapi/asm/Kbuild
Message-ID: <20170612120923.GB24187@e104818-lin.cambridge.arm.com>
References: <1497238041-7011-1-git-send-email-yamada.masahiro@socionext.com>
 <1497238041-7011-5-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1497238041-7011-5-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20170612120924.lwJfd9w6ZVbZoY5oq6iKL7FzZH-rQsPaP5Vb7EMKqC8@z>

On Mon, Jun 12, 2017 at 12:26:58PM +0900, Masahiro Yamada wrote:
> Since commit fcc8487d477a ("uapi: export all headers under uapi
> directories"), all (and only) headers under uapi directories are
> exported, but asm-generic wrappers are still exceptions.
> 
> scripts/Makefile.headersinst still need to deal with old-kbuild-file
> for headers listed in arch/*/include/asm/Kbuild, but actually exported.
> 
> As the last work to finish de-coupling the uapi from kernel headers,
> move generic-y of exported headers to uapi/asm/Kbuild.
> 
> For arm64, "generic-y += kvm_para.h" is doubled in asm/Kbuild and
> uapi/asm/Kbuild.  So, the one in the former can be simply removed.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/arm64/include/asm/Kbuild      | 17 -----------------
>  arch/arm64/include/uapi/asm/Kbuild | 16 ++++++++++++++++
>  2 files changed, 16 insertions(+), 17 deletions(-)

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
