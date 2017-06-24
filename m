Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33404 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751369AbdFXQOT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 24 Jun 2017 12:14:19 -0400
Subject: Re: [PATCH] alpha: provide ioread64 and iowrite64 implementations
References: <20170624115707.30095-1-horia.geanta@nxp.com>
 <20170624151308.6348-1-rth@twiddle.net>
 <dfc70cc1-09a9-f6d0-83a8-c8ca5d7a232b@deltatee.com>
 <787b4be1-ce9e-6838-27b6-0cd9f8d7805f@twiddle.net>
 <721fd59b-b807-86bf-a39c-bab0b33c57c0@deltatee.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <a4ecb85e-f9f7-956f-ec9e-4959313a27d8@twiddle.net>
Date: Sat, 24 Jun 2017 09:14:14 -0700
MIME-Version: 1.0
In-Reply-To: <721fd59b-b807-86bf-a39c-bab0b33c57c0@deltatee.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org
Cc: linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>
Message-ID: <20170624161414.c2Ko89smn-Tk2pceiPr-UBWOPfncGVNjPhPn4hiwKJo@z>

On 06/24/2017 08:32 AM, Logan Gunthorpe wrote:
> So, IMO, the Jensen inq and outq funtions in your patch, which I did
> read, should probably just not be provided.

So you would prefer a function containing BUG?
Because I have to have *something* to put into the machvec function pointer.


r~
