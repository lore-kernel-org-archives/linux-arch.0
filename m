From: Ley Foon Tan <lftan@altera.com>
Subject: Re: [PATCH v2 24/29] nios2: Module support
Date: Wed, 16 Jul 2014 09:32:05 +0800
Message-ID: <CAFiDJ58+TV1i0jdq5SCAt+=VqM-oayJ7tz5dPxYkEaTZ+nwDiA@mail.gmail.com>
References: <1405413956-2772-1-git-send-email-lftan@altera.com>
	<1405413956-2772-25-git-send-email-lftan@altera.com>
	<6364841.e2Acy30lOs@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <6364841.e2Acy30lOs@wuerfel>
Sender: linux-doc-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Chung-Lin Tang <cltang@codesourcery.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Jul 15, 2014 at 6:24 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 15 July 2014 16:45:51 Ley Foon Tan wrote:

>
>> +void module_arch_cleanup(struct module *mod)
>> +{
>> +}
>
> This is not needed at all.
>
Okay, will remove this.
