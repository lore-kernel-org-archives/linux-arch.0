From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/3] module: deal with alignment issues in built-in module versions
Date: Tue, 22 Feb 2011 12:47:09 -0800
Message-ID: <AANLkTikd9QJZVoN+N4yLfr+Y+GWkB1EvShrgvb39Fp=0@mail.gmail.com>
References: <20110217.140119.39175251.davem@davemloft.net> <20110217221957.GA11244@dtor-ws.eng.vmware.com>
 <20110217.142320.102554706.davem@davemloft.net> <AANLkTinMfTss+9K7fPQbxoMD7d-U_AyCc29_RRPRija3@mail.gmail.com>
 <AANLkTikd-OBhe6-wK7-Xvv-asNSeVKs+0-a0d3FF2KVu@mail.gmail.com>
 <1298074455.2460.85.camel@pasglop> <87pqqmrq9q.fsf@rustcorp.com.au>
 <1298339909.8833.135.camel@pasglop> <AANLkTimyaA+JdBHekm69R5Y2A2DEdPdndFLrKJAaz=vt@mail.gmail.com>
 <20110222070240.GA21765@dtor-ws.eng.vmware.com> <20110222170849.GW13204@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <20110222170849.GW13204@axis.com>
Sender: linux-m68k-owner@vger.kernel.org
To: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Dmitry Torokhov <dtor@vmware.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Rusty Russell <rusty@rustcorp.com.au>, David Miller <davem@davemloft.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "geert@linux-m68k.org" <geert@linux-m68k.org>, "linux-m68k@vger.kernel.org" <linux-m68k@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Mikael Starvik <starvik@axis.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Feb 22, 2011 at 9:08 AM, Jesper Nilsson <jesper.nilsson@axis.com> wrote:
>
> That's probably just a legacy from when I combined the linkscripts
> for the two architectures. If I remember correctly, RODATA brings
> in RO_DATA_SECTION which in turn brings in __param and __modver
> for both architectures. CRISv32 then duplicates the __param stuff
> for some historical reason.

Hmm. This makes it sound like the patch should be to remove the
__param thing rather than to add the _modver thing. And I can
definitely confirm that cris seems to use RODATA, which brings in the
RO_DATA_SECTION() thing with proper page alignment.

But:

> True, at least until I've made sure that there isn't any
> underlying reason for CRISv32 to put __param in a different place...
>
> Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

I really am not going to apply a patch that likely just adds another
redundant field to the linker scripts. So the ack I'm just ignoring,

But it would be good to get the "remove the legacy __param thing
because it's already there from the asm-generic version" confirmed by
testing, and not just looking at the source code.

                     Linus
