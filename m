From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 06/18] x86, barrier: stop speculation for failed access_ok
Date: Sat, 6 Jan 2018 09:56:12 -0800
Message-ID: <CA+55aFxBYfbShsPKj1rJjB4TQXxcd+-hYG7y7gq0RF7gdfv_Uw@mail.gmail.com>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151520102670.32271.8447983009852138826.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+55aFzeCHgAtz4vCR9YaUxkuesCNEht56dKJmpytx2A-JmJkg@mail.gmail.com> <20180106123242.77f4d860@alans-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180106123242.77f4d860@alans-desktop>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Dan Williams <dan.j.williams@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Network Development <netdev@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

On Sat, Jan 6, 2018 at 4:32 AM, Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:
>
> Also for x86-64 if we are trusting that an AND with a constant won't get
> speculated into something else surely we can just and the address with ~(1
> << 63) before copying from/to user space ? The user will then just
> speculatively steal their own memory.

User accesses *may* go to the kernel too, with set_fs(KERNEL_DS).
We've been getting rid of those, but they still exist.

We historically perhaps have 'and'ed the address with
current->thread.addr_limit, but it's no longer a power-of-two mask, so
that doesn't work. We'd have to play tricks there, but it might work
to do something like

     addr &= current->thread.addr_limit | 0xfff;

or similar.

But this is one area where the 'lfence' is probably not too bad. The
cost of the existing 'stac' instruction is much higher, and in fact
depending on how lfence works (and how stac affects the memory unit
pipeline, it might even _help_ to serialize the stac with the actual
address.

            Linus
