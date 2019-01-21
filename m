From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: linux-next: manual merge of the pidfd tree with the y2038 tree
Date: Mon, 21 Jan 2019 21:15:27 +0100
Message-ID: <CAK8P3a2CkXJ=giXQgxEcQAeH1Wt8jKc_P+YTOLJpUPVKYU8m9g@mail.gmail.com>
References: <20190121143951.68956db3@canb.auug.org.au> <CAK8P3a0Yth+f8AANE6g8c_zE0Zt1CvCdzMDFK=pr8eNqmrBV0Q@mail.gmail.com>
 <20190121191306.ifga5aw5atu2vvb7@brauner.io>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190121191306.ifga5aw5atu2vvb7@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Brauner <christian@brauner.io>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>
List-Id: linux-arch.vger.kernel.org

On Mon, Jan 21, 2019 at 8:13 PM Christian Brauner <christian@brauner.io> wrote:
> On Mon, Jan 21, 2019 at 06:16:22PM +0100, Arnd Bergmann wrote:
> > On Mon, Jan 21, 2019 at 4:40 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> I plan on sending the pidfd branch with the new pidfd_send_signal()
> syscall for the 5.1 window. Should we somehow coordinate so that our
> branches don't conflict? Any suggestions?

A conflict can't be avoided, but if you pick system call number 427
for pidfd_send_signal, and Jens picks numbers 424 through 426 for
io_uring on all architectures, we can hopefully avoid the renumbering.
Of course, if one or more of the patch series don't make it in or
see a rework that changes the number of new syscalls, then we may
have to change the numbers after all, but we can always hope ;-)

      Arnd
