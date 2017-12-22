From: Matthew Wilcox <willy@infradead.org>
Subject: Function pointer alignment
Date: Thu, 21 Dec 2017 19:55:18 -0800
Message-ID: <20171222035518.GC23624@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:36980 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755875AbdLVDzT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Dec 2017 22:55:19 -0500
Received: from willy by bombadil.infradead.org with local (Exim 4.89 #1 (Red Hat Linux))
        id 1eSEQY-0000lv-Rb
        for linux-arch@vger.kernel.org; Fri, 22 Dec 2017 03:55:18 +0000
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org


What alignment can we rely on for function pointers?

Most architectures seem to have settled on 4-byte aligned instructions.

While x86 is only byte-aligned, at least x86-64 aligns functions on a
16-byte boundary.  I know s390 has 2-byte alignment on instructions,
but does it have greater alignment on functions?

The three architectures with function descriptors (parisc, ia64, ppc64)
all seem like they'll be 8-byte aligned.

(I'm looking to steal the bottom two bits of a function pointer, so
that's where my interest comes from).
