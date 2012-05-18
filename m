From: "H.J. Lu" <hjl.tools@gmail.com>
Subject: Re: [PATCH 08/10] Use __kernel_ulong_t in struct msqid64_ds
Date: Fri, 18 May 2012 05:06:35 -0700
Message-ID: <CAMe9rOoU=2ma7e+sbfCV1Ca10_XCRY44DS7OJgFq79sNuXoo0A@mail.gmail.com>
References: <1337292816-10839-1-git-send-email-hjl.tools@gmail.com>
	<1337292816-10839-9-git-send-email-hjl.tools@gmail.com>
	<4FB58EFD.7010302@zytor.com>
	<4FB5C050.9070805@kernel.org>
	<CAMe9rOrKq8Ait8wKudRF535J5c=dDTKekmUN_=HOs5BBLtsoGQ@mail.gmail.com>
	<CA+55aFxtejaM8ecOw8VYk74OaXfGY7=LO3JSyz3rdHEv2r9goQ@mail.gmail.com>
	<4FB5C843.9070002@kernel.org>
	<29366.1337341984@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <29366.1337341984@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: "H. Peter Anvin" <hpa@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-arch.vger.kernel.org

On Fri, May 18, 2012 at 4:53 AM, David Howells <dhowells@redhat.com> wr=
ote:
> H. Peter Anvin <hpa@kernel.org> wrote:
>
>> User mode can, and should, be able to use the exported headers. =A0D=
avid
>> Howells have been doing even more work to distill out the actual
>> exported ABIs from the kernel and remove remaining chaff.
>
> See:
>
> =A0 =A0 =A0 =A0http://git.infradead.org/users/dhowells/linux-headers.=
git/shortlog/refs/heads/uapi-split
>
> Linus: Any chance of this being pulled at the end of the next merge w=
indow? =A0I
> know you said you didn't want to do another big header file cleanup f=
or a
> while after pulling the system.h disintegration, but I'm wondering if=
 your
> distaste has expired yet.
>

As shown by x32, the kernel interface types are really arch-dependent.
Any generic types based on long won't work for x32.


--=20
H.J.
