From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 06/18] x86, barrier: stop speculation for failed access_ok
Date: Fri, 5 Jan 2018 19:09:01 -0800
Message-ID: <CA+55aFzJgyk7peXyuNO8wgm0ZfSY2K-52XA9z=R6JGKcD6hQYw@mail.gmail.com>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151520102670.32271.8447983009852138826.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+55aFzeCHgAtz4vCR9YaUxkuesCNEht56dKJmpytx2A-JmJkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <CA+55aFzeCHgAtz4vCR9YaUxkuesCNEht56dKJmpytx2A-JmJkg@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Network Development <netdev@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@linux.intel.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Jan 5, 2018 at 6:52 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The fact is, we have to stop speculating when access_ok() does *not*
> fail - because that's when we'll actually do the access. And it's that
> access that needs to be non-speculative.

I also suspect we should probably do this entirely differently.

Maybe the whole lfence can be part of uaccess_begin() instead (ie
currently 'stac()'). That would fit the existing structure better, I
think. And it would avoid any confusion about the whole "when to stop
speculation".

                 Linus
