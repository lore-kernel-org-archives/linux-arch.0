From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/3] X86: Optimise fls(), ffs() and fls64()
Date: Wed, 13 Jan 2010 21:59:23 +0000
Message-ID: <28821.1263419963@redhat.com>
References: <10f740e81001131215y6f15b25bq3bfa2ce2cea164a9@mail.gmail.com> <20100113193923.22272.87546.stgit@warthog.procyon.org.uk>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:64381 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756414Ab0AMV7i (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 13 Jan 2010 16:59:38 -0500
In-Reply-To: <10f740e81001131215y6f15b25bq3bfa2ce2cea164a9@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Why do you put x86 assembler in asm-generic? Those files are supposed
> to be platform-agnostic.

Sorry about that.  I assumed that was an x86_64-specific header.  One of the
downside of going places with etags.

David
