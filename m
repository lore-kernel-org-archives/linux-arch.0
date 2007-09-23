Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55394 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751875AbXIWVEh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 23 Sep 2007 17:04:37 -0400
Date: Sun, 23 Sep 2007 23:04:36 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [patch 1/7] Extended crashkernel command line
Message-ID: <20070923210436.GA7601@suse.de>
References: <20070920171845.774383000@stravinsky.suse.de> <20070920171846.062209000@stravinsky.suse.de> <E1IZEAi-00051i-23@flower> <20070923201943.GA5272@suse.de> <20070923211517.GU24301@flower.upol.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070923211517.GU24301@flower.upol.cz>
Sender: linux-arch-owner@vger.kernel.org
To: Oleg Verych <olecom@flower.upol.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

* Oleg Verych <olecom@flower.upol.cz> [2007-09-23 23:15]:
> 
> - crashkernel=512M-2G:64M,2G-:128M@offset
> + crashkernel=512M-2G,64M,2G-,128M,,offset
> ?

I don't like this syntax.


Thanks,
   Bernhard
