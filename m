From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCHv4 00/33] 5-level paging
Date: Mon, 6 Mar 2017 11:03:56 -0800
Message-ID: <CA+55aFyL7UDP4AyscTOO=pxYuFG2GkG_rbEPgqBMBwkEi7t3vw@mail.gmail.com>
References: <20170306135357.3124-1-kirill.shutemov@linux.intel.com>
 <CA+55aFypZza_L5jyDEFwBrFZPR72R18RwTMz4TuV5sg0H4aaqA@mail.gmail.com> <alpine.DEB.2.20.1703061935220.3771@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <alpine.DEB.2.20.1703061935220.3771@nanos>
Sender: owner-linux-mm@kvack.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, the arch/x86 maintainers <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Mar 6, 2017 at 10:42 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> We probably need to split it apart:
>
>    - Apply the mm core only parts to a branch which can be pulled into
>      Andrews mm-tree
>
>    - Base the x86 changes on top of it

I'll happily take some of the preparatory patches for 4.11 too. Some
of them just don't seem to have any downside. The cpuid stuff, and the
basic scaffolding we could easily merge early. That includes the dummy
5level code, ie "5level-fixup.h" and even some of the mm side that
doesn't actually change anything and just prepares for the real code.

But having some base branch too just for avoiding conflicts with
whatever mm stuff that Andrew keeps around sounds fine too.

                   Linus

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
