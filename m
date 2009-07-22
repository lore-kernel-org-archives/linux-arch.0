From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH/RFC] Move generated files to include/generated
Date: Wed, 22 Jul 2009 15:50:15 +0200
Message-ID: <200907221550.15280.arnd@arndb.de>
References: <20090721211040.GA7688@merkur.ravnborg.org> <20090722095818.GH6281@cr0.nay.redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:51497 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755551AbZGVNuR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jul 2009 09:50:17 -0400
In-Reply-To: <20090722095818.GH6281@cr0.nay.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Amerigo Wang <xiyou.wangcong@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, linux arch <linux-arch@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>

On Wednesday 22 July 2009, Amerigo Wang wrote:
> On Tue, Jul 21, 2009 at 11:10:40PM +0200, Sam Ravnborg wrote:
> >In 2.6.30 we introduced support for adding generated
> >files to a dedicated directory named "include/generated".
>
> Personally, I don't like this, I hate to see
> #include <generated/foo.h>

I think that moving the generated files to a common location
makes a lot of sense, but it seems easier to move them
to include/generated/linux/ or even to (generated/linux/) and
then add -Iinclude/generated/ to the gcc command line so
you don't need to actually change all the users.

For the files in asm/, you could either add a generated/asm
directory or move them to generated/linux/ and change the
users.

	Arnd <><
