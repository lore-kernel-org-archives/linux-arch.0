From: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>
Subject: Re: [PATCH 01/31] bitops: add parity functions
Date: Mon, 28 Mar 2016 10:44:43 +0800
Message-ID: <56F89A9B.10709@gmail.com>
References: <1458788612-4367-1-git-send-email-zhaoxiu.zeng@gmail.com>
 <56F3A77D.6060802@redhat.com> <56F75490.9010608@gmail.com>
 <20160327124401.GA7407@ravnborg.org> <56F7E24F.3040306@gmail.com>
 <20160327175615.GA8864@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36555 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753044AbcC1Cos (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 27 Mar 2016 22:44:48 -0400
In-Reply-To: <20160327175615.GA8864@ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Martin Kepplinger <martink@posteo.de>, Sasha Levin <sasha.levin@oracle.com>, Ingo Molnar <mingo@kernel.org>, Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

OK, I will do the V2 patches soon.
In addition, the best is to provide asm version parity functions for=20
powerpc, sparc, and x86.

=E5=9C=A8 2016=E5=B9=B403=E6=9C=8828=E6=97=A5 01:56, Sam Ravnborg =E5=86=
=99=E9=81=93:
>>> Any particular reason that you select one approach over the other
>>> in the different cases?
>> No particular reason, just like the architecture's __arch_hweightN.
> The general recommendatiosn these days are to use static inline
> for code to get better type check.
> And it would also be nice to be consistent across architectures.
>
> 	Sam
