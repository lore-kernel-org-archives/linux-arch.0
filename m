Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16892.52890.354277.754169@cargo.ozlabs.ibm.com>
Date: Sun, 30 Jan 2005 23:10:02 +1100
From: Paul Mackerras <paulus@samba.org>
Subject: Re: TASK_SIZE is variable.
In-Reply-To: <20050130110127.GA8441@wotan.suse.de>
References: <1106692012.6480.158.camel@localhost.localdomain>
	<20050129122321.0cac707c.akpm@osdl.org>
	<16892.7218.458371.340859@cargo.ozlabs.ibm.com>
	<20050130110127.GA8441@wotan.suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, David Woodhouse <dwmw2@infradead.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Andi Kleen writes:

> I plan to fix this anyways in a more generic way - 4 level currently
> has some bad performance regression because it scans much more pagetables.
> DaveM had an old patch to use bitmaps for used entries in struct page.
> For your 32bit processes only the first bit would be set and it would not
> look at most of the pgds.  The plan was to redo Dave's old patch
> for 4 level (I wanted to redo it a bit because I didn't like how
> his iterators worked)

Sounds good.  I'm looking forward to the patch.

In the meantime I think that MM_VM_SIZE(mm) should be renamed to
MAX_TASK_SIZE without the mm argument.  MAX_TASK_SIZE can default to
TASK_SIZE and be overridden on architectures that have more than one
task size.

Paul.
