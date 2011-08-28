From: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: [PATCH] All Arch: remove linkage for sys_nfsservctl system call
Date: Mon, 29 Aug 2011 09:50:21 +1000
Message-ID: <20110828235021.GS19739@ozlabs.org>
References: <1312810169.2591.1153.camel@deadeye>
 <20110808155538.GB904@fieldses.org>
 <20110808180658.GC29924@decadent.org.uk>
 <20110826220311.GA18140@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110826220311.GA18140@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ben Hutchings <ben@decadent.org.uk>, Neil Brown <neilb@suse.de>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, Aug 26, 2011 at 06:03:11PM -0400, J. Bruce Fields wrote:
> From: NeilBrown <neilb@suse.de>
> 
> The nfsservctl system call is now gone, so we should remove all
> linkage for it.

What about powerpc?

$ egrep -r nfsservctl arch/powerpc/
arch/powerpc/include/asm/systbl.h:COMPAT_SYS(nfsservctl)
arch/powerpc/include/asm/unistd.h:#define __NR_nfsservctl		168

Yours Tony
