From: =?UTF-8?Q?Martin_P=C3=A4rtel?= <martin.partel@gmail.com>
Subject: Re: [uml-devel] [REVIEW][PATCH 19/22] signal/um: Use force_sig_fault
 in relay_signal.
Date: Wed, 25 Apr 2018 01:03:39 +0300
Message-ID: <CAMD8JhxHwcuXh68o1=fbZ_t6DH7x_dO_0nEMqL=cHXBfZXub=w@mail.gmail.com>
References: <87604mhrnb.fsf@xmission.com> <20180420143811.9994-19-ebiederm@xmission.com>
 <7074fe36-27c5-ee82-9659-da703cfc91fe@kot-begemot.co.uk> <CAFLxGvyM+Kru=ERDvccjVuMjSPbu+FQzjbUbMwSyEbL1rVGkBQ@mail.gmail.com>
 <7ddd238f-88a8-ed03-fe9e-0f4e5f2a490d@kot-begemot.co.uk> <87zi1sd28d.fsf@xmission.com>
 <CAMD8JhwgcWCp6c=O4-spNW1VdY5M-eAjr7M5PieeAfeTSe_4yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMD8JhwgcWCp6c=O4-spNW1VdY5M-eAjr7M5PieeAfeTSe_4yw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, Richard Weinberger <richard.weinberger@gmail.com>, Linux-Arch <linux-arch@vger.kernel.org>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>
List-Id: linux-arch.vger.kernel.org

And once more in plain text..

On 25 April 2018 at 01:00, Martin P=C3=A4rtel <martin.partel@gmail.com> wro=
te:
>
> Hi all,
>
> This was ages ago, but from what I remember...
>
>>
>> Having a second look I really don't understand what relay_signal is
>> trying to do.
>>
>> The function relay_signal does not pass siginfo through unchanged.
>
>
> Just copying the entire struct would do the wrong thing. It was discussed=
 here:
> https://marc.info/?l=3Duser-mode-linux-devel&m=3D133910707911999&w=3D2
>
>>
>> Am I missing something subtle or have the subtle details of siginfo just
>> always been ignored?
>
>
> My guess is they have. I was almost certainly oblivious to such subtletie=
s when writing my commit.
>
