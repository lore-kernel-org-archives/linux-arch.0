Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S264571AbUIVLOM@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44007 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264531AbUIVLOM
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 22 Sep 2004 07:14:12 -0400
Date: Wed, 22 Sep 2004 12:14:11 +0100
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: sem_is_locked()
Message-ID: <20040922111411.GG16153@parcelfarce.linux.theplanet.co.uk>
References: <20040922111139.GQ9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040922111139.GQ9106@holomorphy.com>
Sender: <willy@www.linux.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, Sep 22, 2004 at 04:11:39AM -0700, William Lee Irwin III wrote:
> hch and some others (e.g. moi) trying to do vfs sweeps would very much
> like to have a sem_is_locked() to assist them; by any chance could arch
> maintainers help out with implementing this for various arches?

asm-parisc/semaphore.h already has a sem_getcount().  If you choose a
different name for it, please just rename it.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
