From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Subject: Re: Proposal: (u)intptr_t replaces (unsigned) long as opaque type
Date: Sun, 19 Sep 2010 08:33:18 +0400
Message-ID: <AANLkTin001qXMjqPjQxsHOD3xwvxh3YnOmEJmsyMa=yb@mail.gmail.com>
References: <4C95324B.2030707@mcgary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:64681 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848Ab0ISEdT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 19 Sep 2010 00:33:19 -0400
Received: by gwj17 with SMTP id 17so1058451gwj.19
        for <linux-arch@vger.kernel.org>; Sat, 18 Sep 2010 21:33:18 -0700 (PDT)
In-Reply-To: <4C95324B.2030707@mcgary.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg McGary <greg@mcgary.org>
Cc: linux-arch@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>

On Sun, Sep 19, 2010 at 01:42, Greg McGary <greg@mcgary.org> wrote:
> =C2=A0I am porting Linux to a new architecture (a massively multi-thr=
eaded
> network processor), which has a unique and bothersome characteristic:=
 sizeof
> (void*) > sizeof (long). =C2=A0In most regards, it is a 32-bit machin=
e, but
> pointers and all GPRs are 48 bit. =C2=A0Pointers occupy 64 bits in me=
mory, with
> 16 bits ignored by load/store.

=46orgive my ignorence, but is there something fundamentally wrong with
having 48-bit longs?
