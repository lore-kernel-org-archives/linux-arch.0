Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Sun, 30 Jan 2005 12:01:27 +0100
From: Andi Kleen <ak@suse.de>
Subject: Re: TASK_SIZE is variable.
Message-ID: <20050130110127.GA8441@wotan.suse.de>
References: <1106692012.6480.158.camel@localhost.localdomain> <20050129122321.0cac707c.akpm@osdl.org> <16892.7218.458371.340859@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16892.7218.458371.340859@cargo.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Andrew Morton <akpm@osdl.org>, David Woodhouse <dwmw2@infradead.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

> Thus the two patches you included will fix the problems, at the
> expense of having to scan the whole pgd at exit time, even though we
> really only need to look at the first 2 entries on ppc64 for the
> very common case where the mm was used by a 32-bit process.

I plan to fix this anyways in a more generic way - 4 level currently
has some bad performance regression because it scans much more pagetables.
DaveM had an old patch to use bitmaps for used entries in struct page.
For your 32bit processes only the first bit would be set and it would not
look at most of the pgds.  The plan was to redo Dave's old patch
for 4 level (I wanted to redo it a bit because I didn't like how
his iterators worked)

Once that it is in you will get the fast scanning for free.
Should hopefully happen soon.

-Andi
