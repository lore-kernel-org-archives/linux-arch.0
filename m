From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH v2] Add preadv and pwritev system calls.
Date: Fri, 12 Dec 2008 10:03:47 -0700
Message-ID: <20081212170347.GR26095@parisc-linux.org>
References: <1229090440-32120-1-git-send-email-kraxel@redhat.com> <20081212152929.GM26095@parisc-linux.org> <494287D4.2070909@redhat.com> <20081212155113.GO26095@parisc-linux.org> <49428AFD.5090009@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759364AbYLLRD7@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <49428AFD.5090009@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ulrich Drepper <drepper@redhat.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Dec 12, 2008 at 05:02:05PM +0100, Gerd Hoffmann wrote:
> I'd *really* hate it to have the same system call with different
> argument ordering on different systems though.  Especially when swapping
> two integer values, so gcc wouldn't error out on wrong usage.

We can always permute it further:

int fd, int vlen, loff_t pos, const struct *

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
