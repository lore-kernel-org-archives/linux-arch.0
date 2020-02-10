From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] asm-generic: make more kernel-space headers mandatory
Date: Mon, 10 Feb 2020 14:30:52 -0800
Message-ID: <20200210143052.1d89f7e26c9bd115d617cc92@linux-foundation.org>
References: <20200210175452.5030-1-masahiroy@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20200210175452.5030-1-masahiroy@kernel.org>
Sender: linux-kbuild-owner@vger.kernel.org
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, x86@kernel.org, Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

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
