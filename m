Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:36969 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbfLQOoo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 17 Dec 2019 09:44:44 -0500
Subject: Re: [PATCH] RFC: platform driver registering via initcall tables
References: <20191217102219.29223-1-info@metux.net>
 <20191217103152.GB2914497@kroah.com>
 <6422bc88-6d0a-7b51-aaa7-640c6961b177@metux.net>
 <20191217140646.GC3489463@kroah.com>
From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <d938b8e1-d9ce-9ad6-4178-86219e99d4df@metux.net>
Date: Tue, 17 Dec 2019 15:43:56 +0100
MIME-Version: 1.0
In-Reply-To: <20191217140646.GC3489463@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg KH <greg@kroah.com>
Cc: "Enrico Weigelt, metux IT consult" <info@metux.net>, linux-kernel@vger.kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, dmitry.torokhov@gmail.com, jacek.anaszewski@gmail.com, pavel@ucw.cz, dmurphy@ti.com, arnd@arndb.de, masahiroy@kernel.org, michal.lkml@markovi.net, kafai@fb.com, songliubraving@fb.com, yhs@fb.com, andriin@fb.com, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Message-ID: <20191217144356.9mf63TSTddwNvyaT5PN4-2O62E8DXPPHFeNGJQ-CpmY@z>

On 17.12.19 15:06, Greg KH wrote:

> That's not needed, and you are going to break the implicit ordering we
> already have with link order.  

Ups, 10 points for you - I didn't consider that.

> You are going to have to figure out what
> bus type the driver is, to determine what segment it was in, to figure
> out what was loaded before what.

hmm, if it's just the ordering by bus type (but not within one bus
type), then it shouldn't be the big deal to fix, as I'll need one table
and register-loop per bus-type anyways.

By the way: how is there init order ensured with dynamically loaded
modules ? (for cases where there aren't explicit symbol dependencies)


--mtx

---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
