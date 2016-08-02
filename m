Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47790 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966932AbcHBOEV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 2 Aug 2016 10:04:21 -0400
Subject: Re: [RFC][PATCHSET v2] allowing exports in *.S
References: <20160129191744.GB17997@ZenIV.linux.org.uk>
 <20160203211953.GT17997@ZenIV.linux.org.uk>
From: Michal Marek <mmarek@suse.cz>
Message-ID: <57A0A7B8.7080107@suse.cz>
Date: Tue, 2 Aug 2016 16:01:28 +0200
MIME-Version: 1.0
In-Reply-To: <20160203211953.GT17997@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20160802140128.t1kIQTZpOaDtQRi-EGCvBzxRigHghG8GusxLfvtz2HM@z>

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

