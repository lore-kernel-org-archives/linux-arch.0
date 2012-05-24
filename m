From: David Howells <dhowells@redhat.com>
Subject: Re: Arch maintainers Ahoy!
Date: Thu, 24 May 2012 18:16:46 +0100
Message-ID: <14829.1337879806@redhat.com>
References: <CA+55aFwziHq8XZsD_N6sNHNfOoCjhE7AyuakXU0yeWVnk0v1LQ@mail.gmail.com> <CA+55aFy675A7qH+5GUZ_C_aN+Um0o70Zq=SVXYZxbM93ft50mg@mail.gmail.com> <20120523.132109.1153947222019508621.davem@davemloft.net> <CA+55aFxWaB4eeYgdvhTJ2RegM53WxJZFC4HfV=shNn7ZDdG9CQ@mail.gmail.com> <20120523.141647.2252460119413470634.davem@davemloft.net> <CA+55aFxcRc_zR9HtFAtrT1exGP2DspP0aA6T49Ph3kZEHHyQWw@mail.gmail.com> <32064.1337852416@redhat.com> <CA+55aFzwZ3mCeALQx7fXX_HO4GZF03q4gtZOFGmdWkJrvwjrJg@mail.gmail.com> <14266.1337877929@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:1108 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933683Ab2EXRQ4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 24 May 2012 13:16:56 -0400
In-Reply-To: <CA+55aFwziHq8XZsD_N6sNHNfOoCjhE7AyuakXU0yeWVnk0v1LQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dhowells@redhat.com, David Miller <davem@davemloft.net>, James.Bottomley@hansenpartnership.com, geert@linux-m68k.org, linux-arch@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > I didn't suggest it was free, but it might be cheaper. =C2=A0Beside=
s x86/x86_64
> > has BSF/BSR instructions - though having played with Dave's algorit=
hm
> > some, I don't think they're usable for this.
>=20
> David, I don't think you've followed this saga very well.

No, I didn't phrase the paragraph above very well, so let me rephrase: =
I think
Dave's patch is _good_[*] and that BSF/BSR would _not_ be usable for it=
=2E

I was thinking that reordering the bytes on LE might help, but no, it d=
oesn't
as Dave's algorithm works equally well, no matter on the order the byte=
s are
in.

David

[*] Barring an extraneous semicolon already pointed out
