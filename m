From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 02/12] EXPORT_SYMBOL() for asm
Date: Fri, 29 Jan 2016 22:06:15 +0100
Message-ID: <3120161.7CSEIIFIYh@wuerfel>
References: <20160129191744.GB17997@ZenIV.linux.org.uk> <1454095114-4128-2-git-send-email-viro@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <1454095114-4128-2-git-send-email-viro@ZenIV.linux.org.uk>
Sender: linux-kbuild-owner@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Friday 29 January 2016 19:18:24 Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> Add asm-usable variants of EXPORT_SYMBOL/EXPORT_SYMBOL_GPL.  This
> commit just adds the default implementation; most of the architectures
> can simply add export.h to asm/Kbuild and start using <asm/export.h>
> from assembler.  The area where the things might diverge from default
> is the alignment; normally it's 8 bytes on 64bit targets and 4 on
> 32bit ones, both for unsigned long and for struct kernel_symbol.
> 
> Unfortunately, amd64 and m68k are unusual - m68k aligns to 2 bytes
> (for both) and amd64 aligns struct kernel_symbol to 16 bytes.  For
> those we'll need to have asm/export.h overriding the constants used
> by generic version (KSYM_ALIGN and KCRC_ALIGN for kernel_symbol and
> unsigned long resp.) and including asm-generic/export.h.
> 
> And no, __alignof__ would not do the trick - on amd64 __alignof__
> of struct kernel_symbol is 8, not 16.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  include/asm-generic/export.h | 61 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 include/asm-generic/export.h
> 

For asm-generic:

Acked-by: Arnd Bergmann <arnd@arndb.de>
