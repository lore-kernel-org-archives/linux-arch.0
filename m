From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/2] topology: Check for missing CPU devices
Date: Mon, 9 Jan 2012 12:23:04 -0800
Message-ID: <CA+55aFzz3FUsKRQ33NiDghkA3ugV65sBrc+N-h8NLuDRUSBAHQ@mail.gmail.com>
References: <1326055714.13595.309.camel@deadeye> <CA+55aFwwnJPpVY++Vgr6p3s47YjdYWV3sgLZzvCtiJp6DEu78Q@mail.gmail.com>
 <1326077272.4097.3.camel@deadeye> <1326077816.4097.8.camel@deadeye>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <1326077816.4097.8.camel@deadeye>
Sender: linux-m68k-owner@vger.kernel.org
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, Thorsten Glaser <tg@mirbsd.de>, Debian kernel team <debian-kernel@lists.debian.org>, linux-m68k@vger.kernel.org, debian-68k@lists.debian.org
List-Id: linux-arch.vger.kernel.org

On Sun, Jan 8, 2012 at 6:56 PM, Ben Hutchings <ben@decadent.org.uk> wro=
te:
>
> I mean to say that we could have no CPU devices after the *second*
> patch. =A0So the first patch is an extra defence against that. =A0(Th=
ough we
> could just as well panic if register_cpu() fails at boot time.)

I think I'd rather just panic - if you have allocation issues during
early boot, the machine is hosed anyway - and then get rid of the
first patch?

Willing to send out a new patch along those lines (and with UML added)?

Thanks,
                  Linus
