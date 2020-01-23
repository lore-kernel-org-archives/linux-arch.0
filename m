Return-Path: <owner-linux-mm@kvack.org>
MIME-Version: 1.0
References: 
 <70f99f7474826883877e84f93224e937d9c974de.1579767339.git.christophe.leroy@c-s.fr>
In-Reply-To: 
 <70f99f7474826883877e84f93224e937d9c974de.1579767339.git.christophe.leroy@c-s.fr>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 23 Jan 2020 10:47:42 -0800
Message-ID: <CAHk-=wgcm5JzyacekDGQ4Ocoe-F5it-7-sbgU8oPnhwnSH3KAA@mail.gmail.com>
Subject: Re: [PATCH] lib: Reduce user_access_begin() boundaries in
 strncpy_from_user() and strnlen_user()
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-mm@kvack.org
To: Christophe Leroy <christophe.leroy@c-s.fr>, linux-arch <linux-arch@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux-MM <linux-mm@kvack.org>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200123184742.vpvCEbWrL6nwYOq0VHsFd9a953BlKpSFLYoznAe6-2c@z>

On Thu, Jan 23, 2020 at 12:34 AM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
> The range passed to user_access_begin() by strncpy_from_user() and
> strnlen_user() starts at 'src' and goes up to the limit of userspace
> allthough reads will be limited by the 'count' param.
>
> On 32 bits powerpc (book3s/32) access has to be granted for each 256Mbytes
> segment and the cost increases with the number of segments to unlock.
>
> Limit the range with 'count' param.

Ack. I'm tempted to take this for 5.5 too, just so that the
unquestionably trivial fixes are in that baseline, and the
infrastructure is ready for any architecture that has issues like
this.

Adding 'linux-arch' to the participants, to see if other architectures
are at all looking at actually implementing the whole
user_access_begin/end() dance too..

               Linus
