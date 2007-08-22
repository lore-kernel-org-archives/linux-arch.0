Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:60874 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264AbXHVImE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 22 Aug 2007 04:42:04 -0400
Received: by rv-out-0910.google.com with SMTP id k20so102910rvb
        for <linux-arch@vger.kernel.org>; Wed, 22 Aug 2007 01:42:03 -0700 (PDT)
Message-ID: <6bffcb0e0708220142t1d3f5d66o5a43b1b1c4565ed2@mail.gmail.com>
Date: Wed, 22 Aug 2007 10:42:03 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: RFC: drop support for gcc < 4.0
In-Reply-To: <Pine.LNX.4.64.0708221009010.20435@fbirervta.pbzchgretzou.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070821132038.GA22254@ff.dom.local>
	 <20070821093103.3c097d4a.randy.dunlap@oracle.com>
	 <20070821173550.GC30705@stusta.de>
	 <6101e8c40708211441g2ae20412u877082eb611f595e@mail.gmail.com>
	 <Pine.LNX.4.64.0708220956540.20435@fbirervta.pbzchgretzou.qr>
	 <20070822080854.GD1684@ff.dom.local>
	 <Pine.LNX.4.64.0708221009010.20435@fbirervta.pbzchgretzou.qr>
Sender: linux-arch-owner@vger.kernel.org
To: Jan Engelhardt <jengelh@computergmbh.de>
Cc: Jarek Poplawski <jarkao2@o2.pl>, Oliver Pinter <oliver.pntr@gmail.com>, Adrian Bunk <bunk@kernel.org>, Randy Dunlap <randy.dunlap@oracle.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Hi,

On 22/08/07, Jan Engelhardt <jengelh@computergmbh.de> wrote:
>
> On Aug 22 2007 10:08, Jarek Poplawski wrote:
> >On Wed, Aug 22, 2007 at 09:57:04AM +0200, Jan Engelhardt wrote:
> >>
> >> On Aug 21 2007 23:41, Oliver Pinter wrote:
> >> >I think it's bad idea, when removing support for gcc3.x, while some
> >> >people using debian 3.1 at now and under debian 3.1 the default
> >> >comiler is 3.3.5, when I good know or not!?
> >>
> >> They always lag behind.
> >
> >Yes! Probably that's why they are so darn good!
>
> ISTR that even Ubuntu overtook Debian... what about Debian 4.x?

They are using gcc 4.1.1 as default
http://packages.debian.org/stable/devel/gcc

Anyway, IMO dropping support for a compiler just because of warnings
it is a bad thing.

Regards,
Michal

-- 
LOG
http://www.stardust.webpages.pl/log/
