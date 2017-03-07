From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCHv4 00/33] 5-level paging
Date: Tue, 7 Mar 2017 11:41:15 +1100
Message-ID: <20170307114115.768312f4@canb.auug.org.au>
References: <20170306135357.3124-1-kirill.shutemov@linux.intel.com>
	<CA+55aFypZza_L5jyDEFwBrFZPR72R18RwTMz4TuV5sg0H4aaqA@mail.gmail.com>
	<alpine.DEB.2.20.1703061935220.3771@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <alpine.DEB.2.20.1703061935220.3771@nanos>
Sender: owner-linux-mm@kvack.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, the arch/x86 maintainers <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter
 Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Hi Thomas,

On Mon, 6 Mar 2017 19:42:05 +0100 (CET) Thomas Gleixner <tglx@linutronix.de> wrote:
>
> We probably need to split it apart:
> 
>    - Apply the mm core only parts to a branch which can be pulled into
>      Andrews mm-tree

Andrew's mm-tree is not a git tree it is a quilt series ...

-- 
Cheers,
Stephen Rothwell

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
