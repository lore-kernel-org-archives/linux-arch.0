From: Nick Piggin <nickpiggin-/E1597aS9LT0CCvOHzKKcA@public.gmane.org>
Subject: Re: down_spin() implementation
Date: Fri, 28 Mar 2008 16:03:33 +1100
Message-ID: <200803281603.34134.nickpiggin@yahoo.com.au>
References: <1FE6DD409037234FAB833C420AA843ECE9DF60@orsmsx424.amr.corp.intel.com> <20080327141508.GL16721@parisc-linux.org> <20080328155107.e9d8866c.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080328155107.e9d8866c.sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
Content-Disposition: inline
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
Cc: Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>, "Luck, Tony" <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Friday 28 March 2008 15:51, Stephen Rothwell wrote:
> Hi Willy,
>
> On Thu, 27 Mar 2008 08:15:08 -0600 Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org> wrote:
> > Stephen, I've updated the 'semaphore' tag to point ot the same place as
> > semaphore-20080327, so please change your linux-next tree from pulling
> > semaphore-20080314 to just pulling plain 'semaphore'.  I'll use this
> > method of tagging from now on.
>
> Thanks. I read this to late for today's tree, but I will fix it up for
> the next one.

Please don't add this nasty code to semaphore.

Did my previous message to the thread get eaten by spam filters?
