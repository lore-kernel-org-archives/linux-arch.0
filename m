From: Thorsten Glaser <tg@mirbsd.de>
Subject: Re: [PATCH] arch: m68k: include: asm: the 3rd parameter of 'insl'
 and 'outsl' need '<< 2'
Date: Thu, 6 Jun 2013 11:52:27 +0000 (UTC)
Message-ID: <Pine.BSM.4.64L.1306050936200.18048@herc.mirbsd.org>
References: <51A71E49.1000707@asianux.com>
 <CAMuHMdUz8o4d=RiAMW8-pCrnZyfoH9EETVqjcb7E1GqCgYmQ7g@mail.gmail.com>
 <51A93FA0.1050203@biophys.uni-duesseldorf.de> <51A94281.7050708@biophys.uni-duesseldorf.de>
 <51AC6472.3060606@asianux.com> <CAMuHMdVLA_zgeGxTTzfXnBYZiihH3w+LLcW0cRzVk_dvkFojgg@mail.gmail.com>
 <51AE87DF.5000301@asianux.com> <51AEE7C0.9060206@biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <51AEE7C0.9060206@biophys.uni-duesseldorf.de>
Sender: linux-m68k-owner@vger.kernel.org
To: schmitz <schmitz@biophys.uni-duesseldorf.de>
Cc: Chen Gang <gang.chen@asianux.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Ungerer <gerg@uclinux.org>, schmitz@debian.org, Sam Ravnborg <sam@ravnborg.org>, Greg KH <gregkh@linuxfoundation.org>, linux-m68k <linux-m68k@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

schmitz dixit:

> No need for the #ifdef CONFIG_Q40 - Q40 is the only m68k subarch that=
 builds
> the parport_pc module (which includes parport.h), IIRC. Is that corre=
ct,
> Thorsten?

The header is included outside of Q40. There is no Q40 kernel
in Debian (yet). So, no.

bye,
//mirabilos
--=20
17:08=E2=8E=9C=C2=ABVutral=C2=BB fr=C3=BCher gabs keine packenden smart=
phones und so
17:08=E2=8E=9C=C2=ABVutral=C2=BB heute gibts frauen die sind facebooks=C3=
=BCchtig
17:10=E2=8E=9C=C2=ABVutral=C2=BB aber auch traurig; fr=C3=BCher warst d=
u als nerd voll am arsch
17:10=E2=8E=9C=C2=ABVutral=C2=BB heute bist du als nerd der einzige der=
 wirklich damit klarkommt
