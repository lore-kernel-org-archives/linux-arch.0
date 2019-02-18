From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/3] generic asm: mman cleanup
Date: Mon, 18 Feb 2019 15:03:41 +0100
Message-ID: <CAK8P3a2cWjSSUJehMGEMCmnjdWJRZcyoegtN1ERqX7Tzkm-DXg@mail.gmail.com>
References: <20190124142448.23243-1-mst@redhat.com> <20190210231841-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190210231841-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Feb 11, 2019 at 5:20 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Feb 08, 2019 at 01:02:51AM -0500, Michael S. Tsirkin wrote:
> > Now that we have MAP_SHARED, MAP_PRIVATE and MAP_SHARED_VALIDATE on all
> > architectures, it probably makes sense to de-duplicate these
> > and put them into a common header.
> >
> > Please review and consider merging though the generic tree.
> >
> > Build tested on x86 only. Has been in linux-next for a while now.
>
> Arnd, would you consider merging at least the cleanups 2/3 and 3/3?
> In linux-next they had no ill effects and make things
> slightly cleaner IMO.

I applied patches 2 and 3 now, sorry for the late reply.

     Arnd
