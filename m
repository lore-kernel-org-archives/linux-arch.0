Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:38821 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751357AbeCNUSC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Mar 2018 16:18:02 -0400
MIME-Version: 1.0
In-Reply-To: <20180314174150.GA2068@avx2>
References: <20180314143755.1508262-1-arnd@arndb.de> <20180314174150.GA2068@avx2>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 14 Mar 2018 21:18:00 +0100
Message-ID: <CAK8P3a1fJEY7iy9FghcU-WE8Q=gwZxU6b=aVoFPsbR5sHGkyUQ@mail.gmail.com>
Subject: Re: [PATCH 08/16] procfs: remove CONFIG_HARDWALL dependency
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Akinobu Mita <akinobu.mita@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, Michal Hocko <mhocko@suse.com>
Message-ID: <20180314201800.t_3IHR1kEV3HkC70zGzkpL3SRbW7EHueqOORwFei_QA@z>

On Wed, Mar 14, 2018 at 6:41 PM, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> On Wed, Mar 14, 2018 at 03:37:37PM +0100, Arnd Bergmann wrote:
>> Hardwall is a tile specific feature, and with the removal of the
>> tile architecture, this has become dead code, so let's remove it.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> ACK
>
> Although it should go via tile tree for "atomicity".

Both the arch/tile removal and this patch are in my asm-generic tree, as there
is no longer a tile specific git.

Thanks for your Ack!

       Arnd
