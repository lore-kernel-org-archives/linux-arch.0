Return-Path: <willy@www.linux.org.uk>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49119 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261431AbUCAUzM
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 1 Mar 2004 15:55:12 -0500
Date: Mon, 1 Mar 2004 20:55:10 +0000
From: Matthew Wilcox <willy@debian.org>
Subject: Re: SHMLBA and compat tasks
Message-ID: <20040301205510.GF25779@parcelfarce.linux.theplanet.co.uk>
References: <20040228014128.GA6897@intel.com> <20040228155529.64bc0741.davem@redhat.com> <20040229021105.GA6964@intel.com> <20040229215752.3a6f0ce7.davem@redhat.com> <20040301193308.GA13305@intel.com> <16451.37325.109790.457348@napali.hpl.hp.com> <20040301201613.GA13349@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040301201613.GA13349@intel.com>
Sender: <willy@www.linux.org.uk>
To: Arun Sharma <arun.sharma@intel.com>
Cc: davidm@hpl.hp.com, "David S. Miller" <davem@redhat.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, Mar 01, 2004 at 12:16:13PM -0800, Arun Sharma wrote:
> Sounds like we have sufficient grounds for using different alignment
> rules for different architectures ?

#ifndef COMPAT_SHMLBA
#define COMPAT_SHMLBA SHMLBA
#endif

should be enough, no?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
