Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Sun, 30 Jan 2005 18:23:53 -0800
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: TASK_SIZE is variable.
Message-Id: <20050130182353.1a68745c.davem@davemloft.net>
In-Reply-To: <16892.52890.354277.754169@cargo.ozlabs.ibm.com>
References: <1106692012.6480.158.camel@localhost.localdomain>
	<20050129122321.0cac707c.akpm@osdl.org>
	<16892.7218.458371.340859@cargo.ozlabs.ibm.com>
	<20050130110127.GA8441@wotan.suse.de>
	<16892.52890.354277.754169@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Paul Mackerras <paulus@samba.org>
Cc: ak@suse.de, akpm@osdl.org, dwmw2@infradead.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, 30 Jan 2005 23:10:02 +1100
Paul Mackerras <paulus@samba.org> wrote:

> Andi Kleen writes:
> 
> > I plan to fix this anyways in a more generic way - 4 level currently
> > has some bad performance regression because it scans much more pagetables.
> > DaveM had an old patch to use bitmaps for used entries in struct page.
> > For your 32bit processes only the first bit would be set and it would not
> > look at most of the pgds.  The plan was to redo Dave's old patch
> > for 4 level (I wanted to redo it a bit because I didn't like how
> > his iterators worked)
> 
> Sounds good.  I'm looking forward to the patch.
> 
> In the meantime I think that MM_VM_SIZE(mm) should be renamed to
> MAX_TASK_SIZE without the mm argument.  MAX_TASK_SIZE can default to
> TASK_SIZE and be overridden on architectures that have more than one
> task size.

I'm looking forward very much to Andi's work as well.

However, I like the mm->max_addr idea because that could be used
for the mmap()/munmap()/mremap() sanity checks as well instead of
bogus TASK_SIZE.

There are some compat syscalls for the mmap like stuff that exists
only to validate the address ranges for compat task limits.
