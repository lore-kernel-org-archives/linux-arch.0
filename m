From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [GIT PULL] Btrfs
Date: Fri, 13 Sep 2013 13:15:29 +0100
Message-ID: <20130913121529.GA1437@flint.arm.linux.org.uk>
References: <20130912153629.16487.88969@localhost.localdomain> <CA+5PVA5GogJnewWvdmVo03oZRZDerE=H7BR49Xi1DZQyE_CG4Q@mail.gmail.com> <CAMuHMdWgzQvKkASycHSzpTwi2c3qG+wn52YSr-=c8cDtro7NyQ@mail.gmail.com> <CA+5PVA6Hm6XLdJa=x9TmZnjSH160337i-CM2HGHBpQMf06Bv9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-btrfs-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+5PVA6Hm6XLdJa=x9TmZnjSH160337i-CM2HGHBpQMf06Bv9w@mail.gmail.com>
Sender: linux-btrfs-owner@vger.kernel.org
To: Josh Boyer <jwboyer@fedoraproject.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Chris Mason <chris.mason@fusionio.com>, Mark Fasheh <mfasheh@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, linux-btrfs <linux-btrfs@vger.kernel.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Sep 13, 2013 at 07:53:21AM -0400, Josh Boyer wrote:
> I'm not an ARM expert, so I don't know if ARM should use the
> asm-generic implementations, or just use __get_user/__put_user in all
> cases.  I've CC'd rmk.

Why do we have uaccess-unaligned.h ?  Normally, these kinds of things
are spawned by architectures which have problems with unaligned accesses,
ARM being one of them, but afaik we've never need this.

With the kernel-side trapping of unaligned accesses on older hardware,
we've always dealt with the normal accessor faulting.

From what I can tell in the git history, these unaligned put_user and
get_user have existed all the way back to the dawn of git use.

Can someone enlighten me why we have them?

-- 
Russell King
