From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/6] x86: 5-level paging enabling for v4.12, Part 1
Date: Tue, 14 Mar 2017 10:48:51 -0700
Message-ID: <CA+55aFzALboaXe5TWv8=3QZBPJCVAVBmfxTjQEi-aAnHKYAuPQ@mail.gmail.com>
References: <20170313143309.16020-1-kirill.shutemov@linux.intel.com> <20170314074729.GA23151@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20170314074729.GA23151@gmail.com>
Sender: owner-linux-mm@kvack.org
To: Ingo Molnar <mingo@kernel.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, the arch/x86 maintainers <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, Michal Hocko <mhocko@suse.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Mar 14, 2017 at 12:47 AM, Ingo Molnar <mingo@kernel.org> wrote:
>
> I've also applied the GUP patch, with the assumption that you'll address Linus's
> request to switch x86 over to the generic version.

Note that switching over to the generic version is somewhat fraught
with subtle issues:

 (a) we need to make sure that x86 actually matches the required
semantics for the generic GUP.

 (b) we need to make sure the atomicity of the page table reads is ok.

 (c) need to verify the maximum VM address properly

I _think_ (a) is ok. The code (and the config option name) talks about
freeing page tables using RCU, but in fact I don't think it relies on
it, and it's sufficient that it disables interrupts and that that will
block any IPI's.

In contrast, I think (b) needs real work to make sure it's ok on
32-bit PAE with 64-bit pte entries. The generic code currently just
does READ_ONCE(), while the x86 code does gup_get_pte().

And (c) means that we need to really replace that generic code that
does "access_ok()": with a proper check against maximum user address
(ie independent of set_fs(KERNEL_DS)).

But it would be good to aim for unifying this part of the VM,
considering how many bugs we've had in GUP. The latest 5-level typo
has not been the only one. It's clearly more subtle than you'd think.

So it's not quite as simple as just "switching over". I think we need
to introduce that gup_get_pte() to all the generic users, and we need
to introduce a "user address limit" for those architectures too.

                Linus

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
