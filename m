From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH 04/18] csum_and_copy_..._user(): pass 0xffffffff instead
 of 0 as initial sum
Date: Thu, 23 Jul 2020 14:30:10 +0000
Message-ID: <c8122d29be854e4b821c1e242ab8bcc1@AcuMS.aculab.com>
References: <20200721202425.GA2786714@ZenIV.linux.org.uk>
 <20200721202549.4150745-1-viro@ZenIV.linux.org.uk>
 <20200721202549.4150745-4-viro@ZenIV.linux.org.uk>
 <2d85ebb8ea2248c8a14f038a0c60297e@AcuMS.aculab.com>
 <20200722144213.GE2786714@ZenIV.linux.org.uk>
 <4e03cce8ed184d40bb0ea40fd3d51000@AcuMS.aculab.com>
 <20200722155452.GF2786714@ZenIV.linux.org.uk>
 <a55679c8d4dc4fb08d1e1782b5fc572c@AcuMS.aculab.com>
 <20200722173903.GG2786714@ZenIV.linux.org.uk>
 <02938acd78fd40beb02ffc5a1b803d85@AcuMS.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:56710 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726761AbgGWOaO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Jul 2020 10:30:14 -0400
In-Reply-To: <02938acd78fd40beb02ffc5a1b803d85@AcuMS.aculab.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Al Viro' <viro@zeniv.linux.org.uk>
Cc: 'Linus Torvalds' <torvalds@linux-foundation.org>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'linux-arch@vger.kernel.org'" <linux-arch@vger.kernel.org>

> I had to replace the ror32() with __builtin_bswap32().
> The kernel object do contain the 'ror' instruction - even though I
> didn't find the asm for it.

Looking at some instruction timings ror32() and bswap32()
seem to need one of the same execution ports.
However on Intel cpus bswap64() takes 2 clocks but the ror64()
instructions only take 1.

AMD cpus are more symmetric and run all variant in 1 clock.

So ror32() is probably preferable in case anyone copies the
code into somewhere with 64bit checksum value.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
