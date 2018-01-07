From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 06/18] x86, barrier: stop speculation for failed access_ok
Date: Sat, 6 Jan 2018 17:20:52 -0800
Message-ID: <CA+55aFwa+1HiQo3aX9SZb21s7zQRqc5B40wgMMdsrYG0MJLknQ@mail.gmail.com>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151520102670.32271.8447983009852138826.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+55aFzeCHgAtz4vCR9YaUxkuesCNEht56dKJmpytx2A-JmJkg@mail.gmail.com>
 <CA+55aFzJgyk7peXyuNO8wgm0ZfSY2K-52XA9z=R6JGKcD6hQYw@mail.gmail.com> <CAPcyv4gx+2Dh6HS8e+TKNKP00+rYUkzGnEwdpZ_P6hFiOHKHNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <CAPcyv4gx+2Dh6HS8e+TKNKP00+rYUkzGnEwdpZ_P6hFiOHKHNg@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Network Development <netdev@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@linux.intel.com>
List-Id: linux-arch.vger.kernel.org

On Sat, Jan 6, 2018 at 3:31 PM, Dan Williams <dan.j.williams@intel.com> wrote:
>
> I assume if we put this in uaccess_begin() we also need audit for
> paths that use access_ok but don't do on to call uaccess_begin()? A
> quick glance shows a few places where we are open coding the stac().
> Perhaps land the lfence in stac() directly?

Yeah, we should put it in uaccess_begin(), and in the actual user
accessor helpers that do stac. Some of them probably should be changed
to use uaccess_begin() instead while at it.

One question for the CPU people: do we actually care and need to do
this for things that might *write* to something? The speculative write
obviously is killed, but does it perhaps bring in a cacheline even
when killed?

Because maybe we don't need the lfence in put_user(), only in get_user()?

               Linus
