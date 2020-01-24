Return-Path: <owner-linux-mm@kvack.org>
Subject: Re: [PATCH] lib: Reduce user_access_begin() boundaries in
 strncpy_from_user() and strnlen_user()
References: 
 <70f99f7474826883877e84f93224e937d9c974de.1579767339.git.christophe.leroy@c-s.fr>
 <CAHk-=wgcm5JzyacekDGQ4Ocoe-F5it-7-sbgU8oPnhwnSH3KAA@mail.gmail.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <8de7ba48-7bf4-8d43-5dfc-dacf34f80537@c-s.fr>
Date: Fri, 24 Jan 2020 07:25:51 +0100
MIME-Version: 1.0
In-Reply-To: 
 <CAHk-=wgcm5JzyacekDGQ4Ocoe-F5it-7-sbgU8oPnhwnSH3KAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: Linus Torvalds <torvalds@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux-MM <linux-mm@kvack.org>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200124062551.uLsajoC9BugBgIOvb4PSAGhjlG1DnQMlHjTXibpsriI@z>



Le 23/01/2020 =C3=A0 19:47, Linus Torvalds a =C3=A9crit=C2=A0:
> On Thu, Jan 23, 2020 at 12:34 AM Christophe Leroy
> <christophe.leroy@c-s.fr> wrote:
>>
>> The range passed to user_access_begin() by strncpy_from_user() and
>> strnlen_user() starts at 'src' and goes up to the limit of userspace
>> allthough reads will be limited by the 'count' param.
>>
>> On 32 bits powerpc (book3s/32) access has to be granted for each 256Mb=
ytes
>> segment and the cost increases with the number of segments to unlock.
>>
>> Limit the range with 'count' param.
>=20
> Ack. I'm tempted to take this for 5.5 too, just so that the
> unquestionably trivial fixes are in that baseline, and the
> infrastructure is ready for any architecture that has issues like
> this.

It would be nice, then the user_access_begin stuff for powerpc could go=20
for 5.6 without worring about.

Thanks
Christophe
