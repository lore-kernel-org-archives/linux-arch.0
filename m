Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:54224 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfCSVqt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Mar 2019 17:46:49 -0400
Date: Tue, 19 Mar 2019 14:46:48 -0700 (PDT)
Message-ID: <20190319.144648.2244362851338248970.davem@davemloft.net>
Subject: Re: [PATCH] uapi: avoid namespace conflict in linux/posix_types.h
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190319165123.3967889-1-arnd@arndb.de>
References: <20190319165123.3967889-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de
Cc: linux-api@vger.kernel.org, linux-arch@vger.kernel.org, netdev@vger.kernel.org, labbott@redhat.com, fw@deneb.enyo.de, pburton@wavecomp.com, deepa.kernel@gmail.com, linux-kernel@vger.kernel.org
Message-ID: <20190319214648.o-Ck86MpCP0ozw6TEB-WkeCCifOObEeeu-j7HAmoRQw@z>

From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 19 Mar 2019 17:51:09 +0100

> Florian Weimer points out an issue with including linux/posix_types.h
> from arbitrary other headers: if an application has defined a macro
> named 'fds_bits', it may stop compiling after a change in the kernel
> headers. Since fds_bits is a non-reserved identifier in C, that is
> considered a bug in the kernel headers.
> 
> The structure definition does not really seem to be helpful here,
> as the kernel no longer provides macros to manipulate it.
 ...
> Fixes: a623a7a1a567 ("y2038: fix socket.h header inclusion")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: David S. Miller <davem@davemloft.net>
