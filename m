From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] get_write_access()/deny_write_access() without inode->i_lock
Date: Mon, 20 Jun 2011 08:55:38 -0700
Message-ID: <BANLkTimdPT2dbTToTHGVzJr=f3xPKT9tZw@mail.gmail.com>
References: <20110619235147.GQ11521@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20110619235147.GQ11521@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Sun, Jun 19, 2011 at 4:51 PM, Al Viro <viro@zeniv.linux.org.uk> wrot=
e:
> =A0 =A0 =A0 =A0I'm seriously tempted to throw away i_lock uses in
> {get,deny}_write_access(), as in the patch below. =A0The question is,=
 how
> badly will it suck on various architectures? =A0I'd expect it to be n=
ot
> worse than the current version, but...

It might be worse, because doing a read-before-write can turn a single
cache operation ("get for write") into multiple cache operations ("get
for read" followed by "make exclusive").

We had that exact issue with some other users of the "read + cmpxchg" m=
odel.

The way we fixed it before was to simply omit the read, and turn that
into a "guess".

In other words, I'd suggest you get rid of the "atomic_read()"
entirely, and just assume that the write counter was zero to begin
with. Even if that is a wrong assumption (and it probably isn't all
that wrong), it can actually be more efficient to essentiall go
through the loop twice: the first time yoou use the cmpxchg as just an
odd way to do a read. It basically bcomes a read-with-write-intent,
and solves the cacheline issue.

At that point, it's likely faster in pretty much all cases except for
UP (where the spinlocks just go away, and "cmpxchg" is slower than
normal code).

                  Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
