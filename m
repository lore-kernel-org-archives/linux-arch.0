From: Michal Marek <mmarek@suse.cz>
Subject: Re: [RFC][PATCHSET v2] allowing exports in *.S
Date: Tue, 2 Aug 2016 16:01:28 +0200
Message-ID: <57A0A7B8.7080107@suse.cz>
References: <20160129191744.GB17997@ZenIV.linux.org.uk>
 <20160203211953.GT17997@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20160203211953.GT17997@ZenIV.linux.org.uk>
Sender: linux-kbuild-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 2016-02-03 22:19, Al Viro wrote:
> If everyone (including kbuild folks) is OK with the arch-independent parts of
> this series, I'd like to put the first two commits into never-rebased branch
> so that individual architecture trees could pull that and apply the
> corresponding arch-dependent stuff on top of that; going that way would
> minimize the amount of conflicts that would need to be dealt with during
> this cycle, but it obviously depends on those first two commits being
> acceptable to everyone.  Please, review and comment.
> 
> Shortlog:
> Al Viro (13):
>       [kbuild] handle exports in lib-y objects reliably
>       EXPORT_SYMBOL() for asm
>       x86: move exports to actual definitions
>       alpha: move exports to actual definitions
>       m68k: move exports to definitions
>       s390: move exports to definitions
>       arm: move exports to definitions
>       ppc: move exports to definitions
>       ppc: get rid of unreachable abs() implementation
>       sparc: move exports to definitions
>       [sparc] unify 32bit and 64bit string.h
>       sparc32: debride memcpy.S a bit
>       ia64: move exports to definitions

After several pings by Al (sorry about that!), I got around to review a
rebased version of this patchset at

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git asm-exports

The kbuild commits are good, but since we are close to the end of the
merge window, I will apply them to my kbuild branch after 4.8-rc1.

Thanks,
Michal

