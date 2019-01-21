Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39355 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbfAUUXd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Jan 2019 15:23:33 -0500
Received: by mail-wm1-f67.google.com with SMTP id y8so12037812wmi.4
        for <linux-arch@vger.kernel.org>; Mon, 21 Jan 2019 12:23:31 -0800 (PST)
Date: Mon, 21 Jan 2019 21:23:29 +0100
From: Christian Brauner <christian@brauner.io>
Subject: Re: linux-next: manual merge of the pidfd tree with the y2038 tree
Message-ID: <20190121202328.rgrv54lybilsvitu@brauner.io>
References: <20190121143951.68956db3@canb.auug.org.au>
 <CAK8P3a0Yth+f8AANE6g8c_zE0Zt1CvCdzMDFK=pr8eNqmrBV0Q@mail.gmail.com>
 <20190121191306.ifga5aw5atu2vvb7@brauner.io>
 <CAK8P3a2CkXJ=giXQgxEcQAeH1Wt8jKc_P+YTOLJpUPVKYU8m9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a2CkXJ=giXQgxEcQAeH1Wt8jKc_P+YTOLJpUPVKYU8m9g@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>
Message-ID: <20190121202329.CDB8BYALbqQ41OtGBx52N2om0j8xveVugsNF1cBl8l4@z>

On Mon, Jan 21, 2019 at 09:15:27PM +0100, Arnd Bergmann wrote:
> On Mon, Jan 21, 2019 at 8:13 PM Christian Brauner <christian@brauner.io> wrote:
> > On Mon, Jan 21, 2019 at 06:16:22PM +0100, Arnd Bergmann wrote:
> > > On Mon, Jan 21, 2019 at 4:40 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > I plan on sending the pidfd branch with the new pidfd_send_signal()
> > syscall for the 5.1 window. Should we somehow coordinate so that our
> > branches don't conflict? Any suggestions?
> 
> A conflict can't be avoided, but if you pick system call number 427
> for pidfd_send_signal, and Jens picks numbers 424 through 426 for

That sounds good to me. Since it's only one syscall for the pidfd branch
is there anything that speaks against me using 424? Given that the other
patchset has 4 new syscalls. :)
Jens, any objections?

Christian
