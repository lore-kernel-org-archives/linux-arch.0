Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:51896 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753837AbbGIVV5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2015 17:21:57 -0400
Date: Thu, 9 Jul 2015 14:21:55 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: mm: new mm hook framework
Message-ID: <20150709142155.f749ec0dd92b0a4ee0ba8d32@linux-foundation.org>
In-Reply-To: <558BBF05.1050703@linux.vnet.ibm.com>
References: <20150625040814.6C421660F7B@gitolite.kernel.org>
	<CAMuHMdUG3CbPGvTuPF_JO4JL1C6aqPpLwuZjfixF1zU117Vjfw@mail.gmail.com>
	<558BBF05.1050703@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, Linux-Arch <linux-arch@vger.kernel.org>
Message-ID: <20150709212155.hZ8O0OwsEhD3WT0V0dz_X3iUYeIzgrebhwPxakEfFZE@z>

On Thu, 25 Jun 2015 10:42:45 +0200 Laurent Dufour <ldufour@linux.vnet.ibm.com> wrote:

> > IMHO this screams for the generic version in include/asm-generic/,
> > and "generic-y += mm-arch-hooks.h" in arch/*/include/asm/Kbuild/.
> 
> I do like your proposal which avoid creating too many *empty* files.
> Since Andrew suggested the way I did the current patch, I'd appreciate
> his feedback too.

But this infrastructure works the other way.  If an architecture wants
a private implementation of arch_remap(), it adds a definition into
arch/XXX/include/asm/mm-arch-hooks.h and does #define arch_remap arch_remap.

If the architecture is OK with the default implementation of
arch_remap(), it does nothing at all.
