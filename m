From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: 'hweight_long' include/linux/bitops.h compile warning problem.
Date: Mon, 20 Jun 2011 15:00:58 +0200
Message-ID: <201106201500.58617.arnd@arndb.de>
References: <BANLkTi=ETn+LXtd20qkfcgrUngjqwVrVPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:50365 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752535Ab1FTNBM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jun 2011 09:01:12 -0400
In-Reply-To: <BANLkTi=ETn+LXtd20qkfcgrUngjqwVrVPg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: NamJae Jeon <linkinjeon@gmail.com>
Cc: linux-arch@vger.kernel.org

On Monday 20 June 2011, NamJae Jeon wrote:
> I found compile warning while compiling module when using -Wsign-compare option.
> 
> include/linux/bitops.h: In function 'hweight_long':
> include/linux/bitops.h:49: warning: signed and unsigned type in
> conditional expression
> 
> I found the reason of this problem that the default return value of
> the below macro is signed.
> 
> #define __const_hweight8(w)        \
>       ( (!!((w) & (1ULL << 0))) +       \
>         (!!((w) & (1ULL << 1))) +       \
>         (!!((w) & (1ULL << 2))) +       \
>         (!!((w) & (1ULL << 3))) +       \
>         (!!((w) & (1ULL << 4))) +       \
>         (!!((w) & (1ULL << 5))) +       \
>         (!!((w) & (1ULL << 6))) +       \
>         (!!((w) & (1ULL << 7))) )
> 
> So, I try to add (unsigned long) in __const_hweight8 like this.
> 
> #define __const_hweight8(w)     (unsigned long )        \
>       ( (!!((w) & (1ULL << 0))) +       \
>         (!!((w) & (1ULL << 1))) +       \
>         (!!((w) & (1ULL << 2))) +       \
>         (!!((w) & (1ULL << 3))) +       \
>         (!!((w) & (1ULL << 4))) +       \
>         (!!((w) & (1ULL << 5))) +       \
>         (!!((w) & (1ULL << 6))) +       \
>         (!!((w) & (1ULL << 7))) )
> 
> so, I can't see compile warning after fixing it, Would you plz check this ?

Yes, this looks correct to me. Could you send the change as a proper patch
with your Signed-off-by:?

	Arnd
