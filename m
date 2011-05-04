From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH] atomic: add *_dec_not_zero
Date: Wed, 4 May 2011 04:33:24 -0400
Message-ID: <BANLkTimctgbto3dsnJ3d3r7NggS0KF9_Sw@mail.gmail.com>
References: <1304458235-28473-1-git-send-email-sven@narfation.org> <AE90C24D6B3A694183C094C60CF0A2F6D8AD0D@saturn3.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:63475 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291Ab1EDIdp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 4 May 2011 04:33:45 -0400
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8AD0D@saturn3.aculab.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Laight <David.Laight@aculab.com>
Cc: Sven Eckelmann <sven@narfation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mips@linux-mips.org, linux-m32r@ml.linux-m32r.org, linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, x86@kernel.org, Chris Metcalf <cmetcalf@tilera.com>, David Howells <dhowells@redhat.com>, linux-m68k@lists.linux-m68k.org, linux-am33-list@redhat.com, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

On Wed, May 4, 2011 at 04:05, David Laight wrote:
>> Introduce an *_dec_not_zero operation. =C2=A0Make this a special cas=
e of
>> *_add_unless because batman-adv uses atomic_dec_not_zero in differen=
t
>> places like re-broadcast queue or aggregation queue management. Ther=
e
>> are other non-final patches which may also want to use this macro.
>
> Isn't there a place where a default definition of this can be
> defined? Instead of adding it separately to every architecture.

that's what asm-generic is for.  if the arch isnt using it, it's
either because the arch needs to convert to it, or they're using SMP
and asm-generic doesnt yet support that for atomic.h.

for example, the Blackfin port only needed updating for the SMP case.
in the non-SMP case, we're getting the def from asm-generic/atomic.h.
-mike
