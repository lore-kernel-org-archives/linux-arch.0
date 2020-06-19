Return-Path: <SRS0=lJ0G=AA=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731271AbgFSI3C (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Jun 2020 04:29:02 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48295C0613EF
        for <linux-arch@vger.kernel.org>; Fri, 19 Jun 2020 01:29:01 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id g139so4263118lfd.10
        for <linux-arch@vger.kernel.org>; Fri, 19 Jun 2020 01:29:01 -0700 (PDT)
Subject: Re: [PATCH 3/6] exec: cleanup the count() function
References: <20200618144627.114057-1-hch@lst.de>
 <20200618144627.114057-4-hch@lst.de>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <04e7876b-a8f3-3f6e-939c-bb0764ece1ac@cogentembedded.com>
Date: Fri, 19 Jun 2020 11:28:44 +0300
MIME-Version: 1.0
In-Reply-To: <20200618144627.114057-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20200619082844.DYx9DOk3xcGyEmwQTvl1b-ktcjC5aXm5mVLfOCI_NfE@z>

Hello!

On 18.06.2020 17:46, Christoph Hellwig wrote:

> Remove the max argument as it is hard wired to MAX_ARG_STRINGS, and

    Technically, argument is what's actually passed to a function, you're 
removing a function parameter.

> give the function a slightly less generic name.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
[...]

MBR, Sergei
