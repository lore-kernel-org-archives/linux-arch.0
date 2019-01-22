From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: linux-next: manual merge of the pidfd tree with the y2038 tree
Date: Tue, 22 Jan 2019 14:44:04 +0100
Message-ID: <CAK8P3a0pzdGHO_CNt26rx0wn38YJrpux9Xtz_dvZWkCw6gDj1w@mail.gmail.com>
References: <20190121202328.rgrv54lybilsvitu@brauner.io> <da262bd9-1de0-eabb-ee44-e0ee152d15bb@kernel.dk>
 <20190121224811.gbvg22vg4kgg4kbs@brauner.io> <CAK8P3a0ej9NcJM8wXNPbcGUyOUZYX+VLoDFdbenW3s3114oQZw@mail.gmail.com>
 <20190122093146.kmckcgdbvo2e7v3c@brauner.io> <20190122103009.vu2a67kviqhcb3cn@brauner.io>
 <CAK8P3a0EW6ZSMoo6FsRQ=XvyhJe50SR7YtpCtuHcPr=JO3fCtA@mail.gmail.com>
 <20190122105747.6gxvghn7n5dxa65w@brauner.io> <CAK8P3a0HJX6+1vks=ZCqNymLwWFS+Wt5PPuYnLedpMo=aVSwKA@mail.gmail.com>
 <20190122114656.joasjhlpwo3vy7hg@brauner.io> <20190122122419.b7lmm4j25w5cbmcx@brauner.io>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190122122419.b7lmm4j25w5cbmcx@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Brauner <christian@brauner.io>
Cc: Jens Axboe <axboe@kernel.dk>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Jan 22, 2019 at 1:24 PM Christian Brauner <christian@brauner.io> wrote:
> On Tue, Jan 22, 2019 at 12:46:56PM +0100, Christian Brauner wrote:
> > On Tue, Jan 22, 2019 at 12:42:44PM +0100, Arnd Bergmann wrote:
> > >
> > > You need to change __NR_syscalls to 425 as well. This will
> > > clearly create a conflict, but then the resolution will be to pick
> > > the correct (a.k.a. highest) number, rather than remembering
> > > to update it manually.
> >
> > Hm, ok. Wasn't sure if that would confuse people.
> >
> > Ok, when I sent my PR I will make a note in the PR that this branch is
> > aligned to create only minimal conflicts with your y2038 branch. The
> > patch carries your ack already so this should be good.

My point was just that __NR_syscalls has to be one more than the highest
syscall number, otherwise we get a build failure on architectures that
create an array of __NR_syscalls entries.

> Arnd, in case you care to take a look
> https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=for-next

Looks good to me.

      Arnd
