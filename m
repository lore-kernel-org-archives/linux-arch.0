Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:50880 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751378AbYCCMQ4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 3 Mar 2008 07:16:56 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20080303114310.GA28139@flint.arm.linux.org.uk>
References: <20080303114310.GA28139@flint.arm.linux.org.uk> <4a8566f54ff84f498c5c0c0340076c296b1840e6@tazenda.hos.anvin.org> <8260.1204541852@redhat.com>
Subject: Re: [PATCH 1/2] Add C99-style constructor macros for specific-sized integers
Date: Mon, 03 Mar 2008 12:15:59 +0000
Message-ID: <8809.1204546559@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: dhowells@redhat.com, "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Arch Mailing List <linux-arch@vger.kernel.org>, David Brownell <dbrownell@users.sourceforge.net>
Message-ID: <20080303121559.QrfGnkJeYhvk2SsCAFDHP4mjP7TIK5UgdUpQcFUsiT4@z>

Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> > And #if defined(__ASSEMBLY__), just splat x through as is.
> 
> We already have something like this on ARM - include/asm-arm/memory.h

Which you could perhaps replace.

David
