From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH] RFC: platform driver registering via initcall tables
Date: Tue, 17 Dec 2019 15:43:56 +0100
Message-ID: <d938b8e1-d9ce-9ad6-4178-86219e99d4df@metux.net>
References: <20191217102219.29223-1-info@metux.net>
 <20191217103152.GB2914497@kroah.com>
 <6422bc88-6d0a-7b51-aaa7-640c6961b177@metux.net>
 <20191217140646.GC3489463@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191217140646.GC3489463@kroah.com>
Content-Language: tl
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: "Enrico Weigelt, metux IT consult" <info@metux.net>, linux-kernel@vger.kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, dmitry.torokhov@gmail.com, jacek.anaszewski@gmail.com, pavel@ucw.cz, dmurphy@ti.com, arnd@arndb.de, masahiroy@kernel.org, michal.lkml@markovi.net, kafai@fb.com, songliubraving@fb.com, yhs@fb.com, andriin@fb.com, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

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
