Return-Path: <willy@www.linux.org.uk>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:733 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261496AbUCPTSN
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 16 Mar 2004 14:18:13 -0500
Date: Tue, 16 Mar 2004 19:18:10 +0000
From: Matthew Wilcox <willy@debian.org>
Subject: Re: [patch 1/1] generic 32 bit emulation for System-V IPC
Message-ID: <20040316191810.GX25059@parcelfarce.linux.theplanet.co.uk>
References: <200403152253.i2FMrSE09813@mail.osdl.org> <40575155.3070208@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40575155.3070208@intel.com>
Sender: <willy@www.linux.org.uk>
To: Arun Sharma <arun.sharma@intel.com>
Cc: akpm@osdl.org, torvalds@osdl.org, arnd@arndb.de, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Mar 16, 2004 at 11:11:17AM -0800, Arun Sharma wrote:
> Could we get rid of CONFIG_SYSVIPC_COMPAT and use something like:

No; not all 32-bit emulations need it.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
