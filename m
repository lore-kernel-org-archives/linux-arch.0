Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ve1eur01on0131.outbound.protection.outlook.com ([104.47.1.131]:27776
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751347AbdKARrZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 1 Nov 2017 13:47:25 -0400
Date: Wed, 1 Nov 2017 10:47:13 -0700
From: Andrei Vagin <avagin@virtuozzo.com>
Subject: Re: [PATCH] [RFC] vm: add a syscall to map a process memory into a
 pipe
Message-ID: <20171101174712.GA26700@outlook.office365.com>
References: <20170810184616.22726-1-avagin@openvz.org>
 <CAKgNAkiSMhmK7JzVArAUejGPpfvKu0ut-WbFg=r22vk4p78PEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <CAKgNAkiSMhmK7JzVArAUejGPpfvKu0ut-WbFg=r22vk4p78PEg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc: Andrei Vagin <avagin@openvz.org>, Alexander Viro <viro@zeniv.linux.org.uk>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, criu@openvz.org, Arnd Bergmann <arnd@arndb.de>, Pavel Emelyanov <xemul@virtuozzo.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.vnet.ibm.com>
Message-ID: <20171101174713.H-p27xX_95SkbgaRYh8NqlGjs98aEitvSrU72JDR-2M@z>


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline

Hi Michael,

On Mon, Oct 30, 2017 at 01:47:31PM +0100, Michael Kerrisk (man-pages) wrote:
> On 10 August 2017 at 20:46, Andrei Vagin <avagin@openvz.org> wrote:
> > It is a hybrid of process_vm_readv() and vmsplice().
> >
> > vmsplice can map memory from a current address space into a pipe.
> > process_vm_readv can read memory of another process.
> >
> > A new system call can map memory of another process into a pipe.
> >
> > ssize_t process_vmsplice(pid_t pid, int fd, const struct iovec *iov,
> >                         unsigned long nr_segs, unsigned int flags)
> >
> > All arguments are identical with vmsplice except pid which specifies a
> > target process.
> 
> Can we have a man page for this new syscall please?

I think we can add a description for process_vmsplice into
man2/vmsplice.2. The patch is attached.

Thanks,
Andrei

> 
> Thanks,
> 
> Michael
> 
> 

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=koi8-r
Content-Disposition: attachment; filename="0001-vmsplice.2-add-description-for-process_vmsplice.patch"


--fdj2RfSjLxBAspz7--
