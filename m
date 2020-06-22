From: Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 0/2] Small fixes around cacheflush.h
Date: Mon, 22 Jun 2020 16:47:38 -0700
Message-ID: <20200622234740.72825-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731625AbgFWAkO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Jun 2020 20:40:14 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, clang-built-linux@googlegroups.com

Hi all,

These two patches are the culmination of the small discussion here:

https://lore.kernel.org/lkml/CAMuHMdVSduTOi5bUgF9sLQdGADwyL1+qALWsKgin1TeOLGhAKQ@mail.gmail.com/

I have fallen behind on fixing issues so sorry for not sending these
sooner and letting these warnings slip into mainline. Please let me know
if there are any comments or concerns. They are two completely
independent patches so if they need to be routed via separate trees,
that is fine. It was just easier to send them together since they are
dealing with the same problem.

Cheers,
Nathan
