Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from tmailer.gwdg.de ([134.76.10.23]:39324 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423028AbWLUVk6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 21 Dec 2006 16:40:58 -0500
Date: Thu, 21 Dec 2006 22:04:53 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all
 that again
In-Reply-To: <E1GxS4e-0000pb-00@dorka.pomaz.szeredi.hu>
Message-ID: <Pine.LNX.4.61.0612212203510.3720@yvahk01.tjqt.qr>
References: <20061221152621.GB3958@flint.arm.linux.org.uk>
 <E1GxQF2-0000i6-00@dorka.pomaz.szeredi.hu> <20061221165744.GD3958@flint.arm.linux.org.uk>
 <E1GxS4e-0000pb-00@dorka.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


On Dec 21 2006 18:51, Miklos Szeredi wrote:
>
>The root of the problem is that copy_to_user() may cause page faults
>on the userspace buffer, and the page fault might (in case of a
>maliciously crafted filesystem) recurse into the filesystem itself.

Would it be worthwhile to mlock the page? I know that needs root
privs or some capability, but a static buffer could be put aside when
fusermount is run.


	-`J'
-- 
