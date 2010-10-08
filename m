From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 3/5] kvm: stop including asm-generic/bitops/le.h directly
Date: Fri, 8 Oct 2010 14:45:38 +0200
Message-ID: <782A742D-14BD-4B77-A8B5-9C49850A24AE@suse.de>
References: <1286532193-29814-1-git-send-email-akinobu.mita@gmail.com> <1286532193-29814-3-git-send-email-akinobu.mita@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:45405 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753107Ab0JHMpk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 8 Oct 2010 08:45:40 -0400
In-Reply-To: <1286532193-29814-3-git-send-email-akinobu.mita@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org


On 08.10.2010, at 12:03, Akinobu Mita wrote:

> asm-generic/bitops/le.h is only intended to be included directly from
> asm-generic/bitops/ext2-non-atomic.h or asm-generic/bitops/minix-le.h
> which implements generic ext2 or minix bit operations.
> 
> This stops including asm-generic/bitops/le.h directly and use ext2
> non-atomic bit operations instead.
> 
> An alternative approach is introducing little endian bit operations
> in linux/bitops.h. But it needs to touch more files than this change does.

That's properly a better idea, given the fact that ext2_set_bit doesn't really say too much to the reader :).


Alex
