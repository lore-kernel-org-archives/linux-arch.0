From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 00/27] more non-ABI asm-generic headers
Date: Mon, 4 May 2009 16:32:27 +0200
Message-ID: <200905041632.28026.arnd@arndb.de>
References: <cover.1241105648.git.arnd@arndb.de> <10f740e80905030417m3b67da38uecd6bd008b4c7e3f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:58185 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753831AbZEDOcc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 4 May 2009 10:32:32 -0400
In-Reply-To: <10f740e80905030417m3b67da38uecd6bd008b4c7e3f@mail.gmail.com>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert.uytterhoeven@gmail.com>
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Remis Lima Baima <remis.developer@googlemail.com>, linux-kernel@vger.kernel.org

On Sunday 03 May 2009, Geert Uytterhoeven wrote:
> On Thu, Apr 30, 2009 at 17:34, Arnd Bergmann <arnd@arndb.de> wrote:
> > To avoid trouble with quilt mail, I'm now trying
> > git-format-patch to generate them, hopefully this
> > works a little better. Can anyone tell me why I can't
> > add a 'To' header rather than just 'Cc' in
> > git-format-patch?
> 
> I always specify the --to with git send-email.

I haven't tried using git send-email yet, because it does not let
me inspect mails after changing the headers but before sending
them out.

I have now gone back to my old method of

rm -rf patches
mkdir -p patches
git-format-patch -o patches | cut -f 2- -d/ > patches/series
quilt mail --mbox ~/Mail/outbox
#manually edit outbox if necessary, then hit send button in mail client.

	Arnd <><
