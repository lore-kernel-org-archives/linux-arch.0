Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Mon, 4 Apr 2005 12:34:25 +0100
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: Consolidation of asm/unaligned.h
Message-ID: <20050404113425.GE18349@parcelfarce.linux.theplanet.co.uk>
References: <20050317104744.4be7e550.davem@davemloft.net> <1112586161.7087.3.camel@mulgrave> <20050403210201.6ecd41aa.davem@davemloft.net> <1112588136.7087.17.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112588136.7087.17.camel@mulgrave>
Sender: <willy@www.linux.org.uk>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, Apr 03, 2005 at 11:15:36PM -0500, James Bottomley wrote:
> Actually, Matthew Wilcox suggested an alternative:  If the inline
> function arguments for the size are consts, then the compiler seems to
> behave correctly, so how about the attached?

I only tested it; the idea was Randolph Chung's.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
