From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 0/6 v2] kbuild changes, thin archives, --gc-sections
Date: Tue, 23 Aug 2016 16:17:39 +1000
Message-ID: <20160823161739.0f4f7337@roar.ozlabs.ibm.com>
References: <1470910580-18458-1-git-send-email-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <1470910580-18458-1-git-send-email-npiggin@gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: linux-kbuild@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Michal Marek <mmarek@suse.com>, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>, Segher Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Thu, 11 Aug 2016 20:16:14 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> Hi,
> 
> I would like to submit the kbuild changes in patches 1-3 for
> consideration.
> 
> I've taken on the feedback, so thanks everybody for that. The
> biggest change since last time is a more general way for
> architectures to do a post-link pass in patch 3.
> 
> On the question of whether to enable thin archives unconditionally,
> I prefer to have architectures enable them as they are tested. But
> I would like to see everybody moved as soon as possible and the
> incremental linking removed.
> 
> All patches should be basically noops without arch enablement,
> so I include initial powerpc enablement in patches 4-6 for
> reference, but I will submit those via powerpc maintainer if
> the kbuild changes are merged.

Hi Michal,

I'm wondering what your thoughts are with this series?

Sam had some other comment on patch 3, but I think it has come to a
matter of preference. I don't mind too much, so I can change it to
whatever people prefer (sh or makefile).

And did you want me to re-post the series, or are you happy to take
updated patches from replies?

The ARM slowness with allyesconfig builds with thin archives was a
linker workaround for a processor bug that they don't need to enable
for allyesconfig build anyway. I provided them a patch to avoid that.
For usual sized builds, it's not noticeable.

Thanks,
Nick
