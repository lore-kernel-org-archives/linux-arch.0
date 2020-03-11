Return-Path: <SRS0=RUJ7=44=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:57991 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbgCKJKR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 Mar 2020 05:10:17 -0400
Subject: Re: [PATCH] binfmt_misc: pass binfmt_misc P flag to the interpreter
References: <20200306080905.173466-1-syq@debian.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <5546ac4d-b9d1-336e-3861-b1f37e1d059c@vivier.eu>
Date: Wed, 11 Mar 2020 10:09:54 +0100
MIME-Version: 1.0
In-Reply-To: <20200306080905.173466-1-syq@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: YunQiang Su <syq@debian.org>, torvalds@linux-foundation.org, gregkh@linuxfoundation.org, akpm@linux-foundation.org, viro@zeniv.linux.org.uk, James.Bottomley@hansenpartnership.com
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, libc-alpha@sourceware.org
Message-ID: <20200311090954.f2IHMiH_2PiUmDgBPJImQF2BYlIRosMuaWgSf1mq9JA@z>

Le 06/03/2020 à 09:09, YunQiang Su a écrit :
> From: Laurent Vivier <laurent@vivier.eu>
> 
> It can be useful to the interpreter to know which flags are in use.
> 
> For instance, knowing if the preserve-argv[0] is in use would
> allow to skip the pathname argument.
> 
> This patch uses an unused auxiliary vector, AT_FLAGS, to add a
> flag to inform interpreter if the preserve-argv[0] is enabled.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: YunQiang Su <syq@debian.org>
> ---

Any advice to have this merged?

Do I really need to use another AT_ entry?

Thanks,
Laurent
