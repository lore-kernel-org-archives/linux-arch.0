From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [concept & "good taste" review] persistent store
Date: Thu, 16 Dec 2010 17:57:07 -0800
Message-ID: <AANLkTindPUkF7fCkdbqSstNHFjF3_7fEYh18nhQFx_AJ@mail.gmail.com>
References: <4d0662e511688484b3@agluck-desktop.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57375 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750943Ab0LQB56 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Dec 2010 20:57:58 -0500
In-Reply-To: <4d0662e511688484b3@agluck-desktop.sc.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu, greg@kroah.com, akpm@linux-foundation.org, ying.huang@intel.com, Borislav Petkov <bp@alien8.de>, David Miller <davem@davemloft.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jim Keniston <jkenisto@linux.vnet.ibm.com>, Kyungmin Park <kmpark@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, "H. Peter Anvin" <hpa@zytor.com>

On Mon, Dec 13, 2010 at 10:16 AM, Luck, Tony <tony.luck@intel.com> wrot=
e:
>
> So before I embark on another round of code nit-picking, I'd like to
> get answers to the bigger questions:
>
> =A0Do we want/need this in Linux at all?
>
> =A0Is the overall approach OK, or do I need do this some other way?

So I have to say, it seemed interesting at first. I was like "ok, I
don't really see the point of making it a filesystem, but whatever -
it's pretty small".

Then I hit the

        /* Don't dump oopses to persistent store */
        if (reason =3D=3D KMSG_DUMP_OOPS)
                return;

and I'm like "ok, this is just stupid".

The _only_ valid reason for persistent storage is for things like
oopses that kill the machine. Nothing else matters at all. If the
machine isn't dead, and it's not some critical oops, then why the
_hell_ would you ever use persistent storage? You're much better off
just using the regular disk.

So in the end, I really don't see any point at all to this thing. The
filesystem part is pointless (there are better filesystems around and
everybody has a disk or flash or whatever), and the only real upside
has been explicitly castrated.

                         Linus
