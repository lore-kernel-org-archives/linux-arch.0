From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v3 00/13] Virtually mapped stacks with guard pages (x86, core)
Date: Wed, 22 Jun 2016 18:22:17 -0700
Message-ID: <CALCETrUuG0-tGNQ5iAEO2_gaK1eUq7AoALoBeQKcOP8cvxr=eA@mail.gmail.com>
References: <cover.1466466093.git.luto@kernel.org> <CA+55aFyahpuy94qqECj0ZA6oD3Vy0r=gY2cH8_dB1a-4XURV2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:34641 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835AbcFWBWh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jun 2016 21:22:37 -0400
Received: by mail-vk0-f45.google.com with SMTP id c2so55529654vkg.1
        for <linux-arch@vger.kernel.org>; Wed, 22 Jun 2016 18:22:37 -0700 (PDT)
In-Reply-To: <CA+55aFyahpuy94qqECj0ZA6oD3Vy0r=gY2cH8_dB1a-4XURV2Q@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>

On Mon, Jun 20, 2016 at 9:01 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Jun 20, 2016 at 4:43 PM, Andy Lutomirski <luto@kernel.org> wr=
ote:
>>
>> On my laptop, this adds about 1.5=C2=B5s of overhead to task creatio=
n,
>> which seems to be mainly caused by vmalloc inefficiently allocating
>> individual pages even when a higher-order page is available on the
>> freelist.
>
> I really think that problem needs to be fixed before this should be m=
erged.
>
> The easy fix may be to just have a very limited re-use of these stack=
s
> in generic code, rather than try to do anything fancy with multi-page
> allocations. Just a few of these allocations held in reserve (perhaps
> make the allocations percpu to avoid new locks).

I implemented a percpu cache, and it's useless.

When a task goes away, one reference is held until the next RCU grace
period so that task_struct can be used under RCU (look for
delayed_put_task_struct).  This means that free_task gets called in
giant batches under heavy clone() load, which is the only time that
any of this matters, which means that only get to refill the cache
once per RCU batch, which means that there's very little benefit.

Once thread_info stops living in the stack, we could, in principle,
exempt the stack itself from RCU protection, thus saving a bit of
memory under load and making the cache work.  I've started working on
(optionally, per-arch) getting rid of on-stack thread_info, but that's
not ready yet.

=46WIW, the same issue quite possibly hurts non-vmap-stack performance
as well, as it makes it much less likely that a cache-hot stack gets
immediately reused under heavy fork load.

So may I skip this for now?  I think that the performance hit is
unlikely to matter on most workloads, and I also expect the speedup
from not using higher-order allocations to be a decent win on some
workloads.

--Andy
