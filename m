Return-Path: <SRS0=nbOu=74=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:38635 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730707AbgFOOks (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jun 2020 10:40:48 -0400
MIME-Version: 1.0
References: <20200615130032.931285-1-hch@lst.de> <20200615130032.931285-3-hch@lst.de>
 <CAK8P3a0bRD3RzE_X6Tjzu9Tj+OhHhP+S=k6+VYODBGko8oQhew@mail.gmail.com> <20200615141239.GA12951@lst.de>
In-Reply-To: <20200615141239.GA12951@lst.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 15 Jun 2020 16:40:28 +0200
Message-ID: <CAK8P3a2MeZhayZWkPbd4Ckq3n410p_n808NJTwN=JjzqHRiAXg@mail.gmail.com>
Subject: Re: [PATCH 2/6] exec: simplify the compat syscall handling
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Luis Chamberlain <mcgrof@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, the arch/x86 maintainers <x86@kernel.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <20200615144028.BrKixEIL7sx3mQL49n26cSWH6cDBsQ3Yps9Y_XhXZEA@z>

On Mon, Jun 15, 2020 at 4:12 PM Christoph Hellwig <hch@lst.de> wrote:
> On Mon, Jun 15, 2020 at 03:31:35PM +0200, Arnd Bergmann wrote:

>
> > I don't really understand
> > the comment, why can't this just use this?
>
> That errors out with:
>
> ld: arch/x86/entry/syscall_x32.o:(.rodata+0x1040): undefined reference to
> `__x32_sys_execve'
> ld: arch/x86/entry/syscall_x32.o:(.rodata+0x1108): undefined reference to
> `__x32_sys_execveat'
> make: *** [Makefile:1139: vmlinux] Error 1

Ah, I see: it's marked x32-only, so arch/x86/entry/syscall_x32.c
uses the __x32 prefix instead of the __x64 one. Marking it 'common'
instead would make it work, but also create an extra entry point
for native processes, something that commit
6365b842aae4 ("x86/syscalls: Split the x32 syscalls into their own table")
was trying to avoid.

      Arnd
