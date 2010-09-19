From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/5] mm: stack based kmap_atomic
Date: Sun, 19 Sep 2010 10:01:12 -0700
Message-ID: <AANLkTikkVZEGS=1_qbwPoG47twdbzrgWa85NEVD3TxMK@mail.gmail.com>
References: <20100918155326.478277313@chello.nl> <20100918155652.684071800@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20100918155652.684071800@chello.nl>
Sender: owner-linux-mm@kvack.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Russell King <rmk@arm.linux.org.uk>, David Howells <dhowells@redhat.com>, Ralf Baechle <ralf@linux-mips.org>, David Miller <davem@davemloft.net>, Chris Metcalf <cmetcalf@tilera.com>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>
List-Id: linux-arch.vger.kernel.org

On Sat, Sep 18, 2010 at 8:53 AM, Peter Zijlstra <a.p.zijlstra@chello.nl> wr=
ote:
>
> =A0usr/src/linux-2.6/drivers/gpu/drm/nouveau/nouveau_bios.c | 6832 ------=
---------
> =A029 files changed, 361 insertions(+), 7195 deletions(-)

What's that odd 'usr/src/linux-2.6' file that you have and removed?

You're using some seriously broken SCM there.

                  Linus

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
