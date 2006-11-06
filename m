Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:63458 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1752923AbWKFMwy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 6 Nov 2006 07:52:54 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Which architectures need 64-bit resources?
Date: Mon, 6 Nov 2006 13:52:26 +0100
References: <20061106122337.GK27140@parisc-linux.org>
In-Reply-To: <20061106122337.GK27140@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200611061352.26667.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Monday 06 November 2006 13:23, Matthew Wilcox wrote:
> +       bool "64 bit Memory and IO resources (EXPERIMENTAL)" if (!64BIT && (ARM || X86 || MIPS || PPC) && EXPERIMENTAL)
> 

How about reversing the logic to make it

	bool "64 bit Memory and IO resources (EXPERIMENTAL)" if (RESOURCES_64BIT_ENABLE && EXPERIMENTAL)

Then each architecture could either have

config RESOURCES_64BIT_ENABLE
	def_bool y if !64BIT

or even

	select RESOURCES_64BIT

to switch it on unconditionally.

	Arnd <><
