From: "H. Peter Anvin" <hpa@kernel.org>
Subject: Re: [PATCH 0/2] __builtin_unreachable
Date: Wed, 09 Sep 2009 23:42:34 -0700
Message-ID: <4AA89FDA.3090105@kernel.org>
References: <20090910015923.8FB628AE5F@magilla.sf.frob.com> <2375c9f90909092142i58595fedod6780a7c41190f5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:49300 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752577AbZIJGoG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 Sep 2009 02:44:06 -0400
In-Reply-To: <2375c9f90909092142i58595fedod6780a7c41190f5f@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?UTF-8?B?QW3DqXJpY28gV2FuZw==?= <xiyou.wangcong@gmail.com>
Cc: Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Jakub Jelinek <jakub@redhat.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org

On 09/09/2009 09:42 PM, Am=C3=A9rico Wang wrote:
>=20
> Just curious, what different asm code will gcc generate for this? Com=
paring it
> to for(;;) ? I am sorry that I don't have gcc 4.5 on hand.
>=20

It generates nothing.  It is you as the programmer guaranteeing that we
will never get there, and as such gcc will generate no code at all.

	-hpa
