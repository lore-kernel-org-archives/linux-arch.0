From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH RFC 00/10] tools: Revamp the unaligned endian access
 functions
Date: Fri, 13 Jun 2014 22:04:05 +0200
Message-ID: <20140613200405.GA12362@ravnborg.org>
References: <1402441994-16780-1-git-send-email-hpa@zytor.com>
 <20140611192111.GB16069@ravnborg.org>
 <5398CFA4.60202@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5398CFA4.60202@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

> >=20
> > A much simpler approach without any fallback to arch specific
> > version etc. is everything we need.
>=20
> It doesn't matter so much for things that are just done for the kerne=
l
> compile, no, but there are some tools that are built to be used as
> standalone things, and it could matter there.
Which tools require 452 lines of codes for a simple set of
le/be wrappers?
In other words - which tool will benefit from the addition speedup
this amount of code gives?

If I as a naive user look in unaligned.h I do not even see
a prototype of the available methods. I am thrown to a directory
with no less than 12 files.

The le_direct.h=B4+ be_direct.h files seems unused.

So again - why is it not enaough to provide only le_byteshift.h
+ the be counterpart?

	Sam
