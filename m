From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: What's in asm-generic.git
Date: Fri, 11 Dec 2009 14:06:33 +0100
Message-ID: <200912111406.33424.arnd@arndb.de>
References: <OF24184D8B.2F7F8AA9-ON48257685.002069EF-48257685.00207E45@sunplusct.com> <200912102225.05280.arnd@arndb.de> <10f740e80912110454u172fc2cfye30da6ca0e0f0af0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:51884 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877AbZLKNGa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 11 Dec 2009 08:06:30 -0500
In-Reply-To: <10f740e80912110454u172fc2cfye30da6ca0e0f0af0@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Mike Frysinger <vapier.adi@gmail.com>, liqin.chen@sunplusct.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday 11 December 2009, Geert Uytterhoeven wrote:
> 10+ architectures already have sys_[sg]et_thread_area of have reserved
> entries for it.

No, those are just the ones that blindly copied the unistd.h file from i386.
As I said, only i386 and mips implement it, and I would assume that this
is unlikely to change.

	Arnd
