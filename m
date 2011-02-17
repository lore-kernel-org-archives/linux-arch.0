From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/3] module: deal with alignment issues in built-in module versions
Date: Thu, 17 Feb 2011 14:48:15 -0800
Message-ID: <AANLkTinMfTss+9K7fPQbxoMD7d-U_AyCc29_RRPRija3@mail.gmail.com>
References: <AANLkTi=nQ4c6fgk9_-974QOu=kQkJiGpdzpOa_U6ZZcs@mail.gmail.com>
 <20110217.140119.39175251.davem@davemloft.net> <20110217221957.GA11244@dtor-ws.eng.vmware.com>
 <20110217.142320.102554706.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <20110217.142320.102554706.davem@davemloft.net>
Sender: linux-m68k-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: dtor@vmware.com, linux-kernel@vger.kernel.org, geert@linux-m68k.org, rusty@rustcorp.com.au, linux-m68k@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, Feb 17, 2011 at 2:23 PM, David Miller <davem@davemloft.net> wro=
te:
>
> You have to also pick .word vs. .xword, or whatever the appropriate
> sized pointer mnenomic is for a given architecture. =A0I know .word
> works for 32-bit sparc, and .xword works for 64-bit sparc.

Gaah, I didn't realize that we've never had to do anything like this
before, and that the exception table is all arch-specific code. So we
don't have any way to "output that damned pointer and stop whining
about it" model at all.

I really detest gcc sometimes. All these "clever" things that just
make things harder to do. If the user explicitly tells it the section
and the alignment, it should damn well not think that it knows better
and change it. Damn.

Maybe we have to take the "just confuse gcc enough and pray" approach
on those pointers after all.

                      Linus
