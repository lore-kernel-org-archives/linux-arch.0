From: NamJae Jeon <linkinjeon@gmail.com>
Subject: 'hweight_long' include/linux/bitops.h compile warning problem.
Date: Mon, 20 Jun 2011 16:59:11 +0900
Message-ID: <BANLkTi=ETn+LXtd20qkfcgrUngjqwVrVPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:45179 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717Ab1FTH7M (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jun 2011 03:59:12 -0400
Received: by ewy4 with SMTP id 4so1132395ewy.19
        for <linux-arch@vger.kernel.org>; Mon, 20 Jun 2011 00:59:11 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, linux-arch@vger.kernel.org

Hello Arnd

I found compile warning while compiling module when using -Wsign-compare option.

include/linux/bitops.h: In function 'hweight_long':
include/linux/bitops.h:49: warning: signed and unsigned type in
conditional expression

I found the reason of this problem that the default return value of
the below macro is signed.

#define __const_hweight8(w)        \
      ( (!!((w) & (1ULL << 0))) +       \
        (!!((w) & (1ULL << 1))) +       \
        (!!((w) & (1ULL << 2))) +       \
        (!!((w) & (1ULL << 3))) +       \
        (!!((w) & (1ULL << 4))) +       \
        (!!((w) & (1ULL << 5))) +       \
        (!!((w) & (1ULL << 6))) +       \
        (!!((w) & (1ULL << 7))) )

So, I try to add (unsigned long) in __const_hweight8 like this.

#define __const_hweight8(w)     (unsigned long )        \
      ( (!!((w) & (1ULL << 0))) +       \
        (!!((w) & (1ULL << 1))) +       \
        (!!((w) & (1ULL << 2))) +       \
        (!!((w) & (1ULL << 3))) +       \
        (!!((w) & (1ULL << 4))) +       \
        (!!((w) & (1ULL << 5))) +       \
        (!!((w) & (1ULL << 6))) +       \
        (!!((w) & (1ULL << 7))) )

so, I can't see compile warning after fixing it, Would you plz check this ?

Thanks.
