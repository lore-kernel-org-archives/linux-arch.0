From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v2 5/5] uaccess: Rename user_access_begin/end() to
 user_full_access_begin/end()
Date: Sun, 5 Apr 2020 20:47:26 +0200
Message-ID: <0e5985d7-e73b-455b-6b05-351831f09340@c-s.fr>
References: <36e43241c7f043a24b5069e78c6a7edd11043be5.1585898438.git.christophe.leroy@c-s.fr>
 <42da416106d5c1cf92bda1e058434fe240b35f44.1585898438.git.christophe.leroy@c-s.fr>
 <CAHk-=wh_DY_dysMX0NuvJmMFr3+QDKOZPZqWKwLkkjgZTuyQ+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHk-=wh_DY_dysMX0NuvJmMFr3+QDKOZPZqWKwLkkjgZTuyQ+A@mail.gmail.com>
Content-Language: fr
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Peter Anvin <hpa@zytor.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, intel-gfx@lists.freedesktop.org
List-Id: linux-arch.vger.kernel.org



Le 03/04/2020 à 20:01, Linus Torvalds a écrit :
> On Fri, Apr 3, 2020 at 12:21 AM Christophe Leroy
> <christophe.leroy@c-s.fr> wrote:
>>
>> Now we have user_read_access_begin() and user_write_access_begin()
>> in addition to user_access_begin().
> 
> I realize Al asked for this, but I don't think it really adds anything
> to the series.
> 
> The "full" makes the names longer, but not really any more legible.
> 
> So I like 1-4, but am unconvinced about 5 and would prefer that to be
> dropped. Sorry for the bikeshedding.
> 

Yes I was not sure about it, that's the reason why I added it as the 
last patch of the series.

And in the meantime, we see Robots reporting build failures due to 
additional use of user_access_begin() in parallele to this change, so I 
guess it would anyway be a challenge to perform such a change without 
coordination.

> And I like this series much better without the cookie that was
> discussed, and just making the hard rule be that they can't nest.
> 
> Some architecture may obviously use a cookie internally if they have
> some nesting behavior of their own, but it doesn't look like we have
> any major reason to expose that as the actual interface.
> 
> The only other question is how to synchronize this? I'm ok with it
> going through the ppc tree, for example, and just let others build on
> that.  Maybe using a shared immutable branch with 5.6 as a base?

Michael, can you take patches 1 to 4 ?

Otherwise, can you ack patch 4 to enable merging through another tree ?

Christophe
