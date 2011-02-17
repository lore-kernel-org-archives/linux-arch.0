From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/3] module: deal with alignment issues in built-in module versions
Date: Thu, 17 Feb 2011 09:24:58 -0800
Message-ID: <AANLkTim_BL_Cw=X0iuatgw1F4n50CyXv0uqx9n=5=Bq+@mail.gmail.com>
References: <1297123347-2170-1-git-send-email-dtor@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <1297123347-2170-1-git-send-email-dtor@vmware.com>
Sender: linux-m68k-owner@vger.kernel.org
To: Dmitry Torokhov <dtor@vmware.com>
Cc: LKML <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Rusty Russell <rusty@rustcorp.com.au>, Linux/m68k <linux-m68k@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Feb 7, 2011 at 4:02 PM, Dmitry Torokhov <dtor@vmware.com> wrote:
>
> Moreover, as DaveM said, we can't reliably put structures into
> independent objects, put them into a special section, and then expect
> array access over them (via the section boundaries) after linking the
> objects together to just "work" due to variable alignment choices in
> different situations.

Why not?

That's what we normally do. Just align the "__modver", and you should
be all good. What's the problem?

                     Linus
