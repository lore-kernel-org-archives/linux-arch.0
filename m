From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] remove in-kernel calls to syscalls
Date: Mon, 2 Apr 2018 21:33:07 -0700
Message-ID: <CA+55aFyaVVKKbXPFzW1Tr7CTpiLCK+1nGdhS21wnm1j64bqWPA@mail.gmail.com>
References: <20180402190454.GB29890@light.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180402190454.GB29890@light.dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, hmclauchlan@fb.com, tautschn@amazon.co.uk, Amir Goldstein <amir73il@gmail.com>, Andi Kleen <ak@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, Darren Hart <dvhart@infradead.org>, "David S. Miller" <davem@davemloft.net>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, Jaswinder Singh <jaswinder@infradead.org>, Jeff Dike <jdike@addtoit.com>, Jiri Slaby <jslaby@suse.com>, Kexec Mailing List <kexec@lists.infradead.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-mm <linux-mm@kv>
List-Id: linux-arch.vger.kernel.org

On Mon, Apr 2, 2018 at 12:04 PM, Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
>
> This patchset removes all in-kernel calls to syscall functions in the
> kernel with the exception of arch/.

Ok, this finished off my arch updates for today, I'll probably move on
to driver pulls tomorrow.

Anyway, it's in my tree, will push out once my test build finishes.

                Linus
