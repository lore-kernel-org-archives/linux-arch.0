Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ua0-f181.google.com ([209.85.217.181]:43461 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750890AbdKHIlr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Nov 2017 03:41:47 -0500
MIME-Version: 1.0
In-Reply-To: <7795.1510129943@warthog.procyon.org.uk>
References: <cover.1510118606.git.green.hu@gmail.com> <7795.1510129943@warthog.procyon.org.uk>
From: Greentime Hu <green.hu@gmail.com>
Date: Wed, 8 Nov 2017 16:41:06 +0800
Message-ID: <CAEbi=3djUeMtRniq0Z98tVZw_QXB7hfS_mubrot3zHyTjvWZ9A@mail.gmail.com>
Subject: Re: [PATCH 00/31] Andes(nds32) Linux Kernel Port
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev <netdev@vger.kernel.org>
Message-ID: <20171108084106.PAYHsvzU1tJaS3k18iPGZj7_OpzdnppEM2T2BRV-59g@z>

2017-11-08 16:32 GMT+08:00 David Howells <dhowells@redhat.com>:
> Greentime Hu <green.hu@gmail.com> wrote:
>
>> The build script and toolchain repositories are able to be found here:
>>   https://github.com/andestech/build_script.git
>
> Is arch support in upstream binutils and gcc?

Yes, it is but only supporting elf-toolchain now. We will do the
upstream for Linux-toolchain in the next step.
