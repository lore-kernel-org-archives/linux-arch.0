From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 02/12] EXPORT_SYMBOL() for asm
Date: Mon, 01 Feb 2016 15:12:23 +0000
Message-ID: <6928.1454339543@warthog.procyon.org.uk>
References: <1454095114-4128-2-git-send-email-viro@ZenIV.linux.org.uk> <20160129191744.GB17997@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <1454095114-4128-2-git-send-email-viro@ZenIV.linux.org.uk>
Content-ID: <6927.1454339543.1@warthog.procyon.org.uk>
Sender: linux-kbuild-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Al Viro <viro@ZenIV.linux.org.uk> wrote:

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

Acked-by: David Howells <dhowells@redhat.com>
