From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 00/13] Virtually mapped stacks with guard pages (x86, core)
Date: Tue, 21 Jun 2016 21:47:44 +0200
Message-ID: <6248429.A4IJrfgOW3@wuerfel>
References: <cover.1466466093.git.luto@kernel.org> <13212319.WrhLzgRA6Z@wuerfel> <CAGXu5jJaWxcOKLtXG3r1XWE8NpL=GFSZwmV_UYjjv6q0135ETQ@mail.gmail.com>
Reply-To: kernel-hardening@lists.openwall.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <kernel-hardening-return-3572-glkh-kernel-hardening=m.gmane.org@lists.openwall.com>
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
In-Reply-To: <CAGXu5jJaWxcOKLtXG3r1XWE8NpL=GFSZwmV_UYjjv6q0135ETQ@mail.gmail.com>
To: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@kernel.org>, "x86@kernel.org" <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-Id: linux-arch.vger.kernel.org

On Tuesday, June 21, 2016 10:16:21 AM CEST Kees Cook wrote:
> On Tue, Jun 21, 2016 at 2:24 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Monday, June 20, 2016 4:43:30 PM CEST Andy Lutomirski wrote:
> >>
> >> On my laptop, this adds about 1.5=B5s of overhead to task creation,
> >> which seems to be mainly caused by vmalloc inefficiently allocating
> >> individual pages even when a higher-order page is available on the
> >> freelist.
> >
> > Would it help to have a fixed virtual address for the stack instead
> > and map the current stack to that during a task switch, similar to
> > how we handle fixmap pages?
> >
> > That would of course trade the allocation overhead for a task switch
> > overhead, which may be better or worse. It would also give "current"
> > a constant address, which may give a small performance advantage
> > but may also introduce a new attack vector unless we randomize it
> > again.
>=20
> Right: we don't want a fixed address. That makes attacks WAY easier.

Do we care about making the address more random then? When I look
at /proc/vmallocinfo, I see that allocations are all using
consecutive addresses, so if you can figure out the virtual
address of the stack for one process that would give you a good
chance of guessing the address for the next pid.

	Arnd
