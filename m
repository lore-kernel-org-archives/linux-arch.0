From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH v4 05/24] arm: introduce little-endian bitops
Date: Mon, 17 Jan 2011 11:36:09 +0900
Message-ID: <AANLkTim=n7iVn_b6CRaWzwLLocC-rbH58ueEFFs6vfv8@mail.gmail.com>
References: <1295183333-13802-1-git-send-email-akinobu.mita@gmail.com>
	<1295183333-13802-6-git-send-email-akinobu.mita@gmail.com>
	<20110116175109.GC13615@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:36596 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515Ab1AQCgK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 16 Jan 2011 21:36:10 -0500
In-Reply-To: <20110116175109.GC13615@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

2011/1/17 Russell King <rmk@arm.linux.org.uk>:
> On Sun, Jan 16, 2011 at 10:08:34PM +0900, Akinobu Mita wrote:
>> Introduce little-endian bit operations by renaming native ext2 bit
>> operations. =A0The ext2 bit operations are kept as wrapper macros us=
ing
>> little-endian bit operations to maintain bisectability until the
>> conversions are finished.
>
> This looks fine to me - is there any chance we can get this in to mai=
nline
> so we can avoid conflicts between this and some patches I'm working o=
n atm
> to fix the unsafe UP+SMP kernel combination with ARMs bitops ?

The le bitops is still unacceptable to mainline.
So please do the fixes without bothering about the conflict.
