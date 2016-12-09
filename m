Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:33778 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752429AbcLIQtt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Dec 2016 11:49:49 -0500
Subject: Re: [RFC, PATCHv1 00/28] 5-level paging
References: <20161208162150.148763-1-kirill.shutemov@linux.intel.com>
 <20161209050130.GC2595@gmail.com> <20161209103722.GE30380@node.shutemov.name>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <0117384c-e591-2a91-3eab-1af0b0c9f9c9@intel.com>
Date: Fri, 9 Dec 2016 08:49:47 -0800
MIME-Version: 1.0
In-Reply-To: <20161209103722.GE30380@node.shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>, Ingo Molnar <mingo@kernel.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20161209164947.6jaC3t66kFp12micXnuHQ1bQt9aK2zn8cgr8yQ8XotI@z>

On 12/09/2016 02:37 AM, Kirill A. Shutemov wrote:
> On other hand, large virtual address space would put more pressure on
> cache -- at least one more page table per process, if we make 56-bit VA
> default.

For a process only using a small amount of its address space, the
mid-level paging structure caches will be very effective since the page
walks are all very similar.  You may take a cache miss on the extra
level on the *first* walk, but you only do that once per context switch.
 I bet the CPU is also pretty aggressive about filling those things when
it sees a new CR3 and they've been forcibly emptied.  So, you may never
even _see_ the latency from that extra miss.
