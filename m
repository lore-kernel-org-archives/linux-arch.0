Return-Path: <SRS0=eIS7=36=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727385AbgBJWax (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 10 Feb 2020 17:30:53 -0500
Date: Mon, 10 Feb 2020 14:30:52 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] asm-generic: make more kernel-space headers mandatory
Message-ID: <20200210143052.1d89f7e26c9bd115d617cc92@linux-foundation.org>
In-Reply-To: <20200210175452.5030-1-masahiroy@kernel.org>
References: <20200210175452.5030-1-masahiroy@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, x86@kernel.org, Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20200210223052.jiY54IN-yXvXrtBfuYh0AR0wjyM2eXPE0b16iD15vcU@z>

On Tue, 11 Feb 2020 02:54:52 +0900 Masahiro Yamada <masahiroy@kernel.org> wrote:

> Change a header to mandatory-y if both of the following are met:
> 
> [1] At least one architecture (except um) specifies it as generic-y in
>     arch/*/include/asm/Kbuild
> 
> [2] Every architecture (except um) either has its own implementation
>     (arch/*/include/asm/*.h) or specifies it as generic-y in
>     arch/*/include/asm/Kbuild

(reads Documentation/kbuild/makefiles.rst to remember what these things
do).

Why are we making this change?  What's the benefit?
