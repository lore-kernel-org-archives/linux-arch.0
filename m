From: Bob Liu <lliubbo@gmail.com>
Subject: Re: [PATCH 07/38] Disintegrate asm/system.h for Blackfin [ver #3]
Date: Fri, 16 Mar 2012 11:06:10 +0800
Message-ID: <CAA_GA1coF6zzALMs6iKYfrEW-HGcDb24UJfdG1BNtOxTCpaj_g@mail.gmail.com>
References: <20120315205514.28759.58969.stgit@warthog.procyon.org.uk>
	<20120315205620.28759.65095.stgit@warthog.procyon.org.uk>
	<201203151902.25640.vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:52970 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030260Ab2CPDGM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 15 Mar 2012 23:06:12 -0400
In-Reply-To: <201203151902.25640.vapier@gentoo.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mike Frysinger <vapier@gentoo.org>
Cc: uclinux-dist-devel@blackfin.uclinux.org, David Howells <dhowells@redhat.com>, paul.gortmaker@windriver.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de

Hi Mike=EF=BC=8C

On Fri, Mar 16, 2012 at 7:02 AM, Mike Frysinger <vapier@gentoo.org> wro=
te:
> On Thursday 15 March 2012 16:56:21 David Howells wrote:
>> Disintegrate asm/system.h for Blackfin.
>
> i think Bob found an error in this patch. =C2=A0he'll have to comment=
 though.

This patch has no error.
But when i apply it to our internal tree i didn't fix a conflict in
the right way.
Sorry for my mistake.

--=20
Regards,
--Bob
