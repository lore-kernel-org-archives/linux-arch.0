Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41000 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfDVMLN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Apr 2019 08:11:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id c12so9409584wrt.8
        for <linux-arch@vger.kernel.org>; Mon, 22 Apr 2019 05:11:11 -0700 (PDT)
Subject: Re: [PATCH 3/7] thermal/drivers/core: Add init section table for
 self-encapsulation
References: <20190402161256.11044-1-daniel.lezcano@linaro.org>
 <20190402161256.11044-3-daniel.lezcano@linaro.org>
 <1555922585.26198.19.camel@intel.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <fb45157c-38c4-7940-3252-af459d446323@linaro.org>
Date: Mon, 22 Apr 2019 14:11:08 +0200
MIME-Version: 1.0
In-Reply-To: <1555922585.26198.19.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Zhang Rui <rui.zhang@intel.com>, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>
Message-ID: <20190422121108.ejRA7ImQxg24QpwScKiauPGcG2blm-9hKKzcvdmW95I@z>


Hi Zhang,


On 22/04/2019 10:43, Zhang Rui wrote:
> Hi, Daniel,
> 
> Thanks for the patches, it looks good to me except this one and patch
> 4/7.
> 
> First, I don't think this is a cyclic dependency issue as they are in
> the same module.

The governors have to export their [un]register functions in order to
have the core to use them.

The core has to export the [un]register function in order to have the
governors to use them.
