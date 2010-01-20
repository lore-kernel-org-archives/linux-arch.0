From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] asm-generic: dma: Add BUG_ON for uninitialized dma_ops
Date: Wed, 20 Jan 2010 12:48:17 +0200
Message-ID: <b6fcc0a1001200248x1a4b3cedoae90b4f1495d2358@mail.gmail.com>
References: <1263982111-24123-1-git-send-email-monstr@monstr.eu>
	 <1263982111-24123-2-git-send-email-monstr@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-iw0-f197.google.com ([209.85.223.197]:52413 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753240Ab0ATKsS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 20 Jan 2010 05:48:18 -0500
In-Reply-To: <1263982111-24123-2-git-send-email-monstr@monstr.eu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@monstr.eu
Cc: linux-kernel@vger.kernel.org, michal.simek@petalogix.com, arnd@arndb.de, linux-arch@vger.kernel.org, fujita.tomonori@lab.ntt.co.jp, akpm@linux-foundation.org, mingo@elte.hu, joerg.roedel@amd.com

On Wed, Jan 20, 2010 at 12:08 PM,  <monstr@monstr.eu> wrote:
> From: Michal Simek <monstr@monstr.eu>
>
> Check that dma_ops are initialized correctly. Without this
> checking you get kernel fault and you don't know where the problem is=
=2E

Oh, yes you do. PC will be of some small value.

> + =A0 =A0 =A0 BUG_ON(!ops);
> =A0 =A0 =A0 =A0BUG_ON(!valid_dma_direction(dir));
> =A0 =A0 =A0 =A0addr =3D ops->map_page(dev, virt_to_page(ptr),
