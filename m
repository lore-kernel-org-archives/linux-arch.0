Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:37515 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752706AbaGPBcH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jul 2014 21:32:07 -0400
MIME-Version: 1.0
In-Reply-To: <6364841.e2Acy30lOs@wuerfel>
References: <1405413956-2772-1-git-send-email-lftan@altera.com>
	<1405413956-2772-25-git-send-email-lftan@altera.com>
	<6364841.e2Acy30lOs@wuerfel>
Date: Wed, 16 Jul 2014 09:32:05 +0800
Message-ID: <CAFiDJ58+TV1i0jdq5SCAt+=VqM-oayJ7tz5dPxYkEaTZ+nwDiA@mail.gmail.com>
Subject: Re: [PATCH v2 24/29] nios2: Module support
From: Ley Foon Tan <lftan@altera.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Chung-Lin Tang <cltang@codesourcery.com>
Message-ID: <20140716013205.XKSHg1wxl0EOaboe1W8iTJzcwsowfg1oj69r04E6ugw@z>

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
