From: Hugh Dickins <hugh.dickins@tiscali.co.uk>
Subject: Re: [RFC][PATCHSET] mremap/mmap mess
Date: Mon, 7 Dec 2009 20:05:05 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0912071953490.24794@sister.anvils>
References: <E1NGzzu-0008RH-T2@ZenIV.linux.org.uk> <20091207035857.GF14381@ZenIV.linux.org.uk>
 <Pine.LNX.4.64.0912071710540.14445@sister.anvils> <20091207193048.GI14381@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758854AbZLGUFK@vger.kernel.org>
In-Reply-To: <20091207193048.GI14381@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-arch@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Thanks for the explanations,
it sounds as if you and Linus would like to push forward.

On Mon, 7 Dec 2009, Al Viro wrote:
> On Mon, Dec 07, 2009 at 06:58:25PM +0000, Hugh Dickins wrote:
> 
> > [PATCH 9/19] arm: add arch_mmap_check(), get rid of sys_arm_mremap()
> > 
> > You give arm an arch_mmap_check() which tests MAP_FIXED,
> > so now do_brk() needs fixing.  Or can arm's get_unmapped_area()
> > handle this, without any arch_mmap_check()?  In the end you move
> > the arch_mmap_check() call into get_unmapped_area(), but could it be
> > eliminated completely, in favour of code in arch's get_unmapped_area()?
> 
> Point, but take a look at actual check there.  do_brk() won't run afoul
> of it anyway with existing callers on arm.  But yes, I agree that flags
> need to be fixed there.

Right, all that matters is whether MAP_FIXED is set here, and the
fact that it is set through both an explicit MAP_FIXED and a confused
VM_MAYREAD does not really matter - something to clean up, but not
something that will break anybody before it's cleaned up.

> > And (b) I thought you were being perverse in putting sys_mmap_pgoff()
> > in mm/util.c, that's never where I'd look for it, we have a file
> > mm/mmap.c which is just the place for it, after do_mmap_pgoff().
> > Ah, you're trying to avoid duplicating it in mm/nommu.c?  Hmm,
> > well, I'd much rather you do duplicate it.  Particularly once
> > 14/19 complicates it with the MAP_HUGETLB fix, which we should
> > keep in in mm/mmap.c, and shouldn't be needed in mm/nommu.c.
> 
> I'm not too happy with mm/util.c, but I really don't like the mmap vs nommu
> duplications.  Hell knows; we can always split and move later on.

mm/nommu.c is all about duplicating stuff with variations:
unsatisfactory, but no reason to go do it differently here.
Yes, I'll want to revert the util.c mods, but you don't need
to do so now.

Hugh
