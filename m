From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/4] drivers/net/ethernet/sfc: Add efx_ prefix to set_bit_le()
Date: Tue, 12 Jun 2012 13:12:32 +0000
Message-ID: <201206121312.32301.arnd@arndb.de>
References: <20120611212735.f92ea521.yoshikawa.takuya@oss.ntt.co.jp> <201206111409.16093.arnd@arndb.de> <20120612220654.fd0246e6e687f7c79e5c988c@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:63706 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117Ab2FLNMn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 12 Jun 2012 09:12:43 -0400
In-Reply-To: <20120612220654.fd0246e6e687f7c79e5c988c@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Takuya Yoshikawa <takuya.yoshikawa@gmail.com>
Cc: Takuya Yoshikawa <yoshikawa.takuya@oss.ntt.co.jp>, bhutchings@solarflare.com, grundler@parisc-linux.org, avi@redhat.com, mtosatti@redhat.com, linux-net-drivers@solarflare.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kvm@vger.kernel.org

On Tuesday 12 June 2012, Takuya Yoshikawa wrote:
> > 
> > Hmm, any reason why we're not just using the existing non-atomic
> > __set_bit_le() here? I think the helpers in sfc and tulip can
> > just get removed if you use those.
> 
> __set_bit_le() assumes long word alignment and does endian conversion
> when needed.

Ah, I see.
 
> To be honest, I am a bit scared of changing drivers which I cannot test
> on real hardware.

Ok, let's take your patches as they are then.

With the change to add clear_bit_le:

Acked-by: Arnd Bergmann <arnd@arndb.de>
