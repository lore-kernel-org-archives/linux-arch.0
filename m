Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35311 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbeHKR6h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 11 Aug 2018 13:58:37 -0400
Subject: Re: [PATCH 3/6] alpha: Unify the not-implemented system call entry
 name
References: <1531736638-15294-1-git-send-email-firoz.khan@linaro.org>
 <1531736638-15294-4-git-send-email-firoz.khan@linaro.org>
 <20180811000455.GC6515@ZenIV.linux.org.uk>
 <98937991-cefa-b7f3-11c3-12727b3159b1@twiddle.net>
 <20180811024553.GF6515@ZenIV.linux.org.uk>
 <d223ad23-04ae-408f-2a73-d5fa641ad725@twiddle.net>
 <20180811150731.GG6515@ZenIV.linux.org.uk>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <7521cba8-64d3-c262-5590-791ee0abdb7d@twiddle.net>
Date: Sat, 11 Aug 2018 08:24:02 -0700
MIME-Version: 1.0
In-Reply-To: <20180811150731.GG6515@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Firoz Khan <firoz.khan@linaro.org>, linux-alpha@vger.kernel.org, ink@jurassic.park.msu.ru, mattst88@gmail.com, y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com
Message-ID: <20180811152402.aJqEBO-NCR20GVku365EbLc4e0P1PnbJjex7bTgNMdI@z>

On 08/11/2018 08:07 AM, Al Viro wrote:
> BTW, looking through old patches around entry.S, are you OK with this
> one?  Same kind of macro as that for fork/vfork/clone glue...

LGTM.


r~
