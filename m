From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 00/27] more non-ABI asm-generic headers
Date: Thu, 14 May 2009 13:59:59 +0200
Message-ID: <200905141359.59897.arnd@arndb.de>
References: <cover.1241105648.git.arnd@arndb.de> <200905041632.28026.arnd@arndb.de> <10f740e80905080704q4d2336b2v8ec851d0c87c6cda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:52424 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755046AbZENMAG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 14 May 2009 08:00:06 -0400
In-Reply-To: <10f740e80905080704q4d2336b2v8ec851d0c87c6cda@mail.gmail.com>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert.uytterhoeven@gmail.com>
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Remis Lima Baima <remis.developer@googlemail.com>, linux-kernel@vger.kernel.org

On Friday 08 May 2009, Geert Uytterhoeven wrote:
> On Mon, May 4, 2009 at 16:32, Arnd Bergmann <arnd@arndb.de> wrote:
> > I haven't tried using git send-email yet, because it does not let
> > me inspect mails after changing the headers but before sending
> > them out.
> 
> The --dry-run option is not sufficient for you?

I've now started using git-send-email after yet another screwup
with quilt+kmail. I now played around using '--suppress-cc all' sending
patches to myself and fixed the problems I found there, which gave
me enough confidence in the general procedure.

	Arnd <><
