From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH] Add script to add/remove/rename/renumber syscalls and
 resolve conflicts
Date: Tue, 11 Jun 2019 16:18:07 -1000
Message-ID: <CAHk-=wih2Ko+9CBRrdp36G7DPy4EDZKxZQ6q0CNyXRWsy5ujyA@mail.gmail.com>
References: <156025961444.27052.12727156666287330749.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <156025961444.27052.12727156666287330749.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-arch <linux-arch@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Jun 11, 2019 at 3:27 AM David Howells <dhowells@redhat.com> wrote:
>
> Add a script that simplifies the process of altering system call tables in
> the kernel sources.  It has five functions available:

Ugh, I hate it.

I'm sure the script is all kinds of clever and useful, but I really
think the solution is not this kind of helper script, but simply that
we should work at not having each architecture add new system calls
individually in the first place.

IOW, we should look at having just one unified table for new system
call numbers, and aim for the per-architecture ones to be for "legacy
numbering".

Maybe that won't happen, but in the _hope_ that it happens, I really
would prefer that people not work at making scripts for the current
nasty situation.

                 Linus
