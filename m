Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay0008.hostedemail.com ([216.40.44.8]:60250 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751230AbcC2DBf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 28 Mar 2016 23:01:35 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
	by smtpgrave07.hostedemail.com (Postfix) with ESMTP id B840411AB08
	for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2016 02:56:11 +0000 (UTC)
Message-ID: <1459220164.25110.41.camel@perches.com>
Subject: Re: [PATCH 01/31] bitops: add parity functions
From: Joe Perches <joe@perches.com>
Date: Mon, 28 Mar 2016 19:56:04 -0700
In-Reply-To: <56F9E818.1050508@gmail.com>
References: <1458788612-4367-1-git-send-email-zhaoxiu.zeng@gmail.com>
	 <56F3A77D.6060802@redhat.com> <56F75490.9010608@gmail.com>
	 <20160328065106.GA12154@ravnborg.org> <56F9E818.1050508@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Martin Kepplinger <martink@posteo.de>, Sasha Levin <sasha.levin@oracle.com>, Ingo Molnar <mingo@kernel.org>, Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Message-ID: <20160329025604.np4UIgWc4F8Ey9hrpeuotQK-Ej7pisIqrpUCDvAahAQ@z>

On Tue, 2016-03-29 at 10:27 +0800, Zeng Zhaoxiu wrote:
> 在 2016年03月28日 14:51, Sam Ravnborg 写道:
[]
> > Defining these as static inlines in asm-generic prevent an
> > architecture
> > from selecting between a more optimal asm version or the generic version
> > at run-time.
> > sparc would benefit from this as only some sparc chips supports popc.
> > See how this is done for hweight*
> > 
> > 	Sam
> Thanks. I will try.

You might also try to describe in any commit message
and perhaps the internal documentation why using gcc's
__builtin_parity isn't appropriate.
