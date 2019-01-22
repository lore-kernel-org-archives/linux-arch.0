From: Christian Brauner <christian@brauner.io>
Subject: Re: linux-next: manual merge of the pidfd tree with the y2038 tree
Date: Tue, 22 Jan 2019 12:46:57 +0100
Message-ID: <20190122114656.joasjhlpwo3vy7hg@brauner.io>
References: <CAK8P3a2CkXJ=giXQgxEcQAeH1Wt8jKc_P+YTOLJpUPVKYU8m9g@mail.gmail.com>
 <20190121202328.rgrv54lybilsvitu@brauner.io>
 <da262bd9-1de0-eabb-ee44-e0ee152d15bb@kernel.dk>
 <20190121224811.gbvg22vg4kgg4kbs@brauner.io>
 <CAK8P3a0ej9NcJM8wXNPbcGUyOUZYX+VLoDFdbenW3s3114oQZw@mail.gmail.com>
 <20190122093146.kmckcgdbvo2e7v3c@brauner.io>
 <20190122103009.vu2a67kviqhcb3cn@brauner.io>
 <CAK8P3a0EW6ZSMoo6FsRQ=XvyhJe50SR7YtpCtuHcPr=JO3fCtA@mail.gmail.com>
 <20190122105747.6gxvghn7n5dxa65w@brauner.io>
 <CAK8P3a0HJX6+1vks=ZCqNymLwWFS+Wt5PPuYnLedpMo=aVSwKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a0HJX6+1vks=ZCqNymLwWFS+Wt5PPuYnLedpMo=aVSwKA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jens Axboe <axboe@kernel.dk>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Jan 22, 2019 at 12:42:44PM +0100, Arnd Bergmann wrote:
> On Tue, Jan 22, 2019 at 11:57 AM Christian Brauner <christian@brauner.io> wrote:
> > On Tue, Jan 22, 2019 at 11:48:12AM +0100, Arnd Bergmann wrote:
> 
> > > Do you mean the asm-generic uapi header? In my current series, I do that:
> >
> > Yes. My idea was to only change pidfd_send_signal's entry to 424 and
> > leave the other ones untouched:
> >
> >  #
> >  # x32-specific system call numbers start at 512 to avoid cache impact
> > diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> > index b77538af7aca..4d86d0787d99 100644
> > --- a/include/uapi/asm-generic/unistd.h
> > +++ b/include/uapi/asm-generic/unistd.h
> > @@ -740,7 +740,7 @@ __SC_COMP(__NR_io_pgetevents, sys_io_pgetevents, compat_sys_io_pgetevents)
> >  __SYSCALL(__NR_rseq, sys_rseq)
> >  #define __NR_kexec_file_load 294
> >  __SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
> > -#define __NR_pidfd_send_signal 295
> > +#define __NR_pidfd_send_signal 424
> >  __SYSCALL(__NR_pidfd_send_signal, sys_pidfd_send_signal)
> >
> > and also leave
> 
> Yes, that looks good.
> 
> > #undef __NR_syscalls
> > #define __NR_syscalls 296
> >
> > Does that work to avoid the merge conflict or do you need something
> > more?
> 
> You need to change __NR_syscalls to 425 as well. This will
> clearly create a conflict, but then the resolution will be to pick
> the correct (a.k.a. highest) number, rather than remembering
> to update it manually.

Hm, ok. Wasn't sure if that would confuse people.

Ok, when I sent my PR I will make a note in the PR that this branch is
aligned to create only minimal conflicts with your y2038 branch. The
patch carries your ack already so this should be good.

Thanks Arnd!
Christian
