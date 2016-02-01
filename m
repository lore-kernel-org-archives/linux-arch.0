Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53939 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752319AbcBAPMZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 1 Feb 2016 10:12:25 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1454095114-4128-2-git-send-email-viro@ZenIV.linux.org.uk>
References: <1454095114-4128-2-git-send-email-viro@ZenIV.linux.org.uk> <20160129191744.GB17997@ZenIV.linux.org.uk>
Subject: Re: [PATCH 02/12] EXPORT_SYMBOL() for asm
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6927.1454339543.1@warthog.procyon.org.uk>
Date: Mon, 01 Feb 2016 15:12:23 +0000
Message-ID: <6928.1454339543@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20160201151223.rhGql6v80SibB5y4L34m6QWc21N9ZGwr_k4r482NTaE@z>

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
