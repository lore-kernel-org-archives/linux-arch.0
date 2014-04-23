Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:44555 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154AbaDWCrJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 Apr 2014 22:47:09 -0400
MIME-Version: 1.0
In-Reply-To: <201404221433.17861.arnd@arndb.de>
References: <1397824031-4892-1-git-send-email-lftan@altera.com>
	<1397824031-4892-4-git-send-email-lftan@altera.com>
	<201404221433.17861.arnd@arndb.de>
Date: Wed, 23 Apr 2014 10:47:08 +0800
Message-ID: <CAFiDJ58oeUtXR_gqud9pw55wojY6PJRQp8PAyEfpDL_Let7u=Q@mail.gmail.com>
Subject: Re: [PATCH 04/28] nios2: Exception handling
From: Ley Foon Tan <lftan@altera.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, cltang@codesourcery.com
Message-ID: <20140423024708.KIBVr1vasPO9f715e8MKK2FxfeOs9Ao1vFSNcoGt544@z>

On Tue, Apr 22, 2014 at 8:33 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 18 April 2014, Ley Foon Tan wrote:
>> +static const struct file_operations misalign_fops = {
>> +       .open           = proc_misaligned_open,
>> +       .read           = seq_read,
>> +       .llseek         = seq_lseek,
>> +       .release        = single_release,
>> +       .write          = proc_misaligned_write,
>> +};
>> +#endif /* CONFIG_PROC_FS */
>
> We really shouldn't be doing new architecture specific procfs files
> any more. I suggest you drop this one for now, and add back the
> functionality using perf or ftrace at a later point.
>
>         Arnd

Okay, will remove this.
Thanks.

Ley Foon
