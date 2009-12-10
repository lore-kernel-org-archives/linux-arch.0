From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 5/5] blackfin: Convert BUG() to use
	unreachable()
Date: Thu, 10 Dec 2009 16:33:49 -0500
Message-ID: <8bd0f97a0912101333x2ba210d8ib1936bffa0ef2d7b@mail.gmail.com>
References: <4B212EEC.3060808@caviumnetworks.com> <1260466101-17545-5-git-send-email-ddaney@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-gx0-f212.google.com ([209.85.217.212]:59331 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755939AbZLJVeD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 Dec 2009 16:34:03 -0500
In-Reply-To: <1260466101-17545-5-git-send-email-ddaney@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Daney <ddaney@caviumnetworks.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, uclinux-dist-devel@blackfin.uclinux.org

On Thu, Dec 10, 2009 at 12:28, David Daney wrote:
> Use the new unreachable() macro instead of for(;;);

sorry, i guess i missed this back in Sept.  change looks fine to me
(i'll test it later when finishing putting together other patches).
you want me to push though my queue ?  doesnt matter to me.
-mike
