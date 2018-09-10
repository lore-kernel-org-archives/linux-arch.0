Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38138 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbeIJRQD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Sep 2018 13:16:03 -0400
Subject: Re: [PATCH v2] asm-generic: bug: unify hints for BUG_ON()
References: <20180908045928.26201-1-igor.stoppa@huawei.com>
 <CAK8P3a02Q0_r4sqzJzA01GEHf0oUyevwwVg+E0_iCEkLFrwOaw@mail.gmail.com>
From: Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <a58d4439-bc6c-66b3-0de2-ea92be21e6b8@gmail.com>
Date: Mon, 10 Sep 2018 15:22:10 +0300
MIME-Version: 1.0
In-Reply-To: <CAK8P3a02Q0_r4sqzJzA01GEHf0oUyevwwVg+E0_iCEkLFrwOaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: igor.stoppa@huawei.com, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20180910122210.F1Lk0uDsdZZsNM0qorLsvfdRgC_fATqLFP5LjSZuJn0@z>



On 10/09/18 15:16, Arnd Bergmann wrote:

> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> I assume this will be included in a longer patch series rather than
> going through
> my asm-generic tree, right?

sadly, no: this patch is just for the asm-generic tree
I tried with the longer patch series, but it didn't work out
I'm now submitting individual patches to their respective mailing lists 
and maintainers.
It requires more churning, but at least some patches are going through.

--
thanks, igor
