Return-Path: <willy@www.linux.org.uk>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12200 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263409AbUCTNgf
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 20 Mar 2004 08:36:35 -0500
Date: Sat, 20 Mar 2004 13:36:34 +0000
From: Matthew Wilcox <willy@debian.org>
Subject: Re: compat-signal-noarch-2004-01-29.patch again
Message-ID: <20040320133634.GU25059@parcelfarce.linux.theplanet.co.uk>
References: <20040319214949.6b7d50bc.akpm@osdl.org> <20040320051519.780318b8.ak@suse.de> <20040319223744.1f003f9f.akpm@osdl.org> <20040320055753.27517d88.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040320055753.27517d88.ak@suse.de>
Sender: <willy@www.linux.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org, carlos@baldric.uwo.ca
List-ID: <linux-arch.vger.kernel.org>

On Sat, Mar 20, 2004 at 05:57:53AM +0100, Andi Kleen wrote:
> No. The problem is not in a particular implementation of this for a specific 
> architecture, but in the generic design - it is the wrong direction and will
> cause hard to fix later design problems.

You're wrong.  Just accept this patch.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
