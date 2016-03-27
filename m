From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 01/31] bitops: add parity functions
Date: Sun, 27 Mar 2016 19:56:15 +0200
Message-ID: <20160327175615.GA8864@ravnborg.org>
References: <1458788612-4367-1-git-send-email-zhaoxiu.zeng@gmail.com>
 <56F3A77D.6060802@redhat.com>
 <56F75490.9010608@gmail.com>
 <20160327124401.GA7407@ravnborg.org>
 <56F7E24F.3040306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from asavdk4.altibox.net ([109.247.116.15]:34964 "EHLO
	asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752647AbcC0R4W (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 27 Mar 2016 13:56:22 -0400
Content-Disposition: inline
In-Reply-To: <56F7E24F.3040306@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "zhaoxiu.zeng" <zhaoxiu.zeng@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Martin Kepplinger <martink@posteo.de>, Sasha Levin <sasha.levin@oracle.com>, Ingo Molnar <mingo@kernel.org>, Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

> > Any particular reason that you select one approach over the other
> > in the different cases?
> 
> No particular reason, just like the architecture's __arch_hweightN.

The general recommendatiosn these days are to use static inline
for code to get better type check.
And it would also be nice to be consistent across architectures.

	Sam
