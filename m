Return-Path: <willy@www.linux.org.uk>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29124 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263535AbUCTU3n
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 20 Mar 2004 15:29:43 -0500
Date: Sat, 20 Mar 2004 20:29:38 +0000
From: Matthew Wilcox <willy@debian.org>
Subject: Re: compat-signal-noarch-2004-01-29.patch again
Message-ID: <20040320202938.GZ25059@parcelfarce.linux.theplanet.co.uk>
References: <20040319214949.6b7d50bc.akpm@osdl.org> <20040320051519.780318b8.ak@suse.de> <20040319223744.1f003f9f.akpm@osdl.org> <20040320055753.27517d88.ak@suse.de> <20040320133634.GU25059@parcelfarce.linux.theplanet.co.uk> <20040320122048.70db9888.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040320122048.70db9888.akpm@osdl.org>
Sender: <willy@www.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Matthew Wilcox <willy@debian.org>, ak@suse.de, linux-arch@vger.kernel.org, carlos@baldric.uwo.ca
List-ID: <linux-arch.vger.kernel.org>

On Sat, Mar 20, 2004 at 12:20:48PM -0800, Andrew Morton wrote:
> I can sort-of-see Andi's worry.
> 
> The issue appears to be that at some time in the future he will have 64-bit
> applications using the 32-bit API without PER_LINUX32 set.  So the proposed
> is_compat_task() is meaningless in this context - hence Andi doesn't want
> is_compat_task() propagated around the place.
> 
> This begs the question of how his kernel correctly handle these
> pseudo-32-bit tasks.

Well, what we actually want to know is whether to deliver 32- or 64-bit
signals to this task.  So what if we simply renamed is_compat_task() to
task_wants_compat_signals()?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
