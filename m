Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Mon, 31 Jan 2005 02:33:38 +0000
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: TASK_SIZE is variable.
Message-ID: <20050131023338.GB31145@parcelfarce.linux.theplanet.co.uk>
References: <1106692012.6480.158.camel@localhost.localdomain> <20050129122321.0cac707c.akpm@osdl.org> <16892.7218.458371.340859@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16892.7218.458371.340859@cargo.ozlabs.ibm.com>
Sender: <willy@www.linux.org.uk>
To: Paul Mackerras <paulus@samba.org>
Cc: Andrew Morton <akpm@osdl.org>, David Woodhouse <dwmw2@infradead.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, Jan 30, 2005 at 10:28:50AM +1100, Paul Mackerras wrote:
> However, the default
> MM_VM_SIZE is still (based on) TASK_SIZE, and each 64-bit arch that
> has TASK_SIZE as a per-task property then has to override it (except
> that parisc doesn't seem to).

There's no 64-bit userspace for parisc yet ... that would involve dealing
with drepper some more, and nobody wants to do that.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
