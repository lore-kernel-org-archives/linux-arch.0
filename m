From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC, PATCHv1 00/28] 5-level paging
Date: Fri, 9 Dec 2016 08:40:11 -0800
Message-ID: <20161209164011.GL8388@tassilo.jf.intel.com>
References: <20161208162150.148763-1-kirill.shutemov@linux.intel.com>
 <20161209050130.GC2595@gmail.com>
 <20161209103722.GE30380@node.shutemov.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:46543 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933294AbcLIQkM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Dec 2016 11:40:12 -0500
Content-Disposition: inline
In-Reply-To: <20161209103722.GE30380@node.shutemov.name>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Ingo Molnar <mingo@kernel.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

> On other hand, large virtual address space would put more pressure on
> cache -- at least one more page table per process, if we make 56-bit VA
> default.

The top level page always has to be there unless you disable it at boot time
(unless you go for a scheme where some processes share top level pages, and
others do not, which would likely be very complicated)

But even with that it is more than one: A typical set up has at least two extra
4K pages overhead, one for the bottom and one for the top mappings. Could easily be
more.

-Andi
