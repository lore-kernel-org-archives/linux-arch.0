From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH v1 31/31] ARC: [plat-arcfpga] defconfig
Date: Mon, 12 Nov 2012 14:21:51 +0000
Message-ID: <201211121421.52020.arnd@arndb.de>
References: <1352281674-2186-1-git-send-email-vgupta@synopsys.com> <201211071406.58304.arnd@arndb.de> <50A10540.3080005@imgtec.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:56495 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556Ab2KLOV6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 12 Nov 2012 09:21:58 -0500
In-Reply-To: <50A10540.3080005@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de

On Monday 12 November 2012, James Hogan wrote:
> > 
> > Please use "make defconfig" to generate minimal defconfig files, instead of
> > copying the entire file here.
> 
> I think you mean "make savedefconfig"? (I think "make defconfig" loads
> the default defconfig).

Yes, that's right. Sorry for the typo.

	Arnd
