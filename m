From: Ley Foon Tan <lftan@altera.com>
Subject: Re: [PATCH v2 20/29] nios2: Cpuinfo handling
Date: Thu, 7 Aug 2014 13:06:57 +0800
Message-ID: <CAFiDJ5_PU7-F1K83NaujQfyKMv3vwvg+G2Vuy3=FBZeoC3_PYw@mail.gmail.com>
References: <1405413956-2772-1-git-send-email-lftan@altera.com>
	<1405413956-2772-21-git-send-email-lftan@altera.com>
	<7103938.6xzUh5tnai@wuerfel>
	<CAFiDJ5-KFmf9-YBnvZae7iwMWwb6XOgOLUFA+9eRLvuk_TDXnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:52845 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754049AbaHGFG7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 7 Aug 2014 01:06:59 -0400
In-Reply-To: <CAFiDJ5-KFmf9-YBnvZae7iwMWwb6XOgOLUFA+9eRLvuk_TDXnw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Chung-Lin Tang <cltang@codesourcery.com>

On Fri, Jul 18, 2014 at 10:43 AM, Ley Foon Tan <lftan@altera.com> wrote:
> On Tue, Jul 15, 2014 at 5:47 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Tuesday 15 July 2014 16:45:47 Ley Foon Tan wrote:
>>> +static void *cpuinfo_start(struct seq_file *m, loff_t *pos)
>>> +{
>>> +       unsigned long i = *pos;
>>> +
>>> +       return i < num_possible_cpus() ? (void *) (i + 1) : NULL;
>>> +}
>>> +
>>> +static void *cpuinfo_next(struct seq_file *m, void *v, loff_t *pos)
>>> +{
>>> +       ++*pos;
>>> +       return cpuinfo_start(m, pos);
>>> +}
>>
>> Do you actually have SMP support?
> Not.
>
>
>>> +const struct seq_operations cpuinfo_op = {
>>> +       .start  = cpuinfo_start,
>>> +       .next   = cpuinfo_next,
>>> +       .stop   = cpuinfo_stop,
>>> +       .show   = show_cpuinfo
>>> +};
>>
>> If not, you can use single_start/next/stop here rather than defining your own.
> Okay, I will look into your suggestion.
> Thanks.

I have tried this. But, it seem that we can't use
single_start/next/stop here. They are static functions to
fs/seq_file.c.

Regards
Ley Foon
