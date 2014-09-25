From: Ley Foon Tan <lftan@altera.com>
Subject: Re: [PATCH v3 01/29] asm-generic: add generic futex for !CONFIG_SMP
Date: Thu, 25 Sep 2014 16:33:33 +0800
Message-ID: <CAFiDJ58h4VKrr-wHe6iD+aPB8QU=xLo03kW5k6QDpLW5Et0DGw@mail.gmail.com>
References: <1410168160-3624-1-git-send-email-lftan@altera.com>
	<12538756.JybTPMqFHj@wuerfel>
	<CAFiDJ5-bo_WOz6JockX_BaX0_O0D=+8PjKx7gys-ySKA2KMOaw@mail.gmail.com>
	<3608975.MxU44B73lk@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <3608975.MxU44B73lk@wuerfel>
Sender: linux-doc-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Chung-Lin Tang <cltang@codesourcery.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

On Wed, Sep 24, 2014 at 7:10 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> Please add my 'Acked-by: Arnd Bergmann <arnd@arndb.de>' to this patch
> once Thomas is ok with it. I think we had concluded already that it
> was correct when we talked about it last time, but he doesn't seem
> convinced yet so I want to wait for his reply.
Okay, will wait response from Thomas first. BTW, this is the previous
discussion thread for this generic futex:
http://www.gossamer-threads.com/lists/linux/kernel/1966564

> You definitely need an Ack for all patches touching code outside of
> arch/nios2, from the respective maintainers. For the nios2 code,
> having as many acks as you can helps, and I should probably take
> a last look so I can ack the pull request when you send it.
There are 4 patches that touching code outside of arch/nios2,
including this patch.
Do we have maintainers for common files for patch #15, #27 and #28
below? Can't find this info from MAINTAINERS file.
It is good if you can take a look this v3 patchset so I can send pull
request if no further issue. Thanks!

[PATCH v3 01/29] asm-generic: add generic futex for !CONFIG_SMP
[PATCH v3 15/29] Add ELF machine define for Nios2
[PATCH v3 27/29] MAINTAINERS: Add nios2 maintainer
[PATCH v3 28/29] Documentation: Add documentation for Nios2 architecture

Ley Foon
