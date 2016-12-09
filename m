From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RFC, PATCHv1 00/28] 5-level paging
Date: Fri, 9 Dec 2016 08:49:47 -0800
Message-ID: <0117384c-e591-2a91-3eab-1af0b0c9f9c9@intel.com>
References: <20161208162150.148763-1-kirill.shutemov@linux.intel.com>
 <20161209050130.GC2595@gmail.com> <20161209103722.GE30380@node.shutemov.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20161209103722.GE30380@node.shutemov.name>
Sender: owner-linux-mm@kvack.org
To: "Kirill A. Shutemov" <kirill@shutemov.name>, Ingo Molnar <mingo@kernel.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

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

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
